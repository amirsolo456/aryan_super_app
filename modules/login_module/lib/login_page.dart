import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_module/services/html_text_parser.dart';
import 'package:login_module/services/modal_manager.dart';
import 'package:login_module/services/snackbar_service.dart';
import 'package:resources_package/Resources/Assets/assets_manager.dart';
import 'package:resources_package/Resources/Assets/icons_manager.dart';
import 'package:resources_package/l10n/app_localizations.dart';
import 'package:resources_package/resources/Theme/theme_manager.dart';
import 'package:resources_package/resources/styles/styles.dart';
import 'package:services_package/setup_services.dart';
import 'package:ui_components_package/erp_app_componenets/common/Buttons/language_button_standalone/language_button_stand_alone.dart';
import 'package:ui_components_package/erp_app_componenets/common/aryan_logo.dart';
import 'package:ui_components_package/erp_app_componenets/mobile/Buttons/dynamic_button.dart';
import 'package:ui_components_package/erp_app_componenets/mobile/Buttons/loading_button.dart';
import 'package:ui_components_package/erp_app_componenets/mobile/Inputs/secondary_input.dart';
import 'package:ui_components_package/erp_app_componenets/mobile/Inputs/verification.dart';
import 'package:url_launcher/url_launcher.dart';

import 'login_bloc.dart';

class LoginPage extends StatelessWidget {
  final int netMode;
  final Locale locale;
  final String deviceToken;

  const LoginPage({
    super.key,
    required this.locale,
    required this.deviceToken,
    required this.netMode,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(networkMode: netMode, deviceToken: deviceToken),
      child: const LoginPageBody(),
    );
  }
}

class LoginPageBody extends StatefulWidget {
  const LoginPageBody({super.key});

  @override
  State<LoginPageBody> createState() => _LoginPageBodyState();
}

class _LoginPageBodyState extends State<LoginPageBody> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _passformKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _passRecformKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _userformKey = GlobalKey<FormState>();
  final SnackBarService _snackBarService = getIt.get<SnackBarService>();

  String get _validationMsg =>
      AppLocalizations.of(context)?.passwordValidationMsg ?? '';

  String get _validationNullMsg =>
      AppLocalizations.of(context)?.passwordValidationNullMsg ?? '';

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _passwordFieldValidator(String? value) {
    if (value == null || value.isEmpty) {
      return _validationNullMsg;
    }
    return null;
  }

  String? _usernameFieldValidator(String? value) {
    if (value == null || value.isEmpty) {
      return _validationNullMsg;
    }
    return null;
  }

  Widget _buildPasswordTitle(BuildContext context) {
    return SizedBox(
      height: 30,
      child: Text(
        AppLocalizations.of(context)!.password,
        maxLines: 1,
        textWidthBasis: TextWidthBasis.parent,
        textAlign: TextAlign.right,
        textDirection: TextDirection.rtl,
        softWrap: true,
        style: TextStyle(
          textBaseline: TextBaseline.ideographic,
          fontSize: 16,
          fontFamily: 'Yekan',
          color: ThemeColorsManager(ThemeManager.themeMode).primary,
        ),
      ),
    );
  }

  Widget _buildUsernameTitle(BuildContext context) {
    return SizedBox(
      height: 30,
      child: Text(
        AppLocalizations.of(context)!.phoneNumber,
        textDirection: TextDirection.rtl,
        textWidthBasis: TextWidthBasis.parent,
        maxLines: 1,
        style: TextStyle(
          textBaseline: TextBaseline.ideographic,
          fontWeight: FontWeight.bold,
          fontFamily: 'Yekan',
          fontSize: 14,
        ),
        softWrap: true,
        textAlign: TextAlign.right,
      ),
    );
  }

  Widget _buildUsernameBody(String username, BuildContext context) {
    _usernameController.text = username;
    return Form(
      key: _userformKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildUsernameTitle(context),
          MediaQuery(
            data: const MediaQueryData(),
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Material(
                child: AryanInputs.secondaryUsernameTextForm(
                  controller: _usernameController,
                  obscureText: false,
                  hintText: '0912 202 5458',
                  validator: _usernameFieldValidator,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordBody(LoginPasswordState state, BuildContext context) {
    return Form(
      key: _passformKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPasswordTitle(context),
          AryanInputs.secondaryPasswordTextFormWithToggle(
            controller: _passwordController,
            inputHintText: ". . . . . . . . . .",
            validator: _passwordFieldValidator,
          ),
          TextButton(
            onPressed: () {
              final bloc = context.read<LoginBloc>();
              bloc.add(LoginRecoveryPasswordEvent(_usernameController.text));
            },
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                AppLocalizations.of(context)!.passwordForgot,
                style: AryanText.secondary(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecoverPasswordBody(
    LoginRecoverPasswordState state,
    BuildContext context,
  ) {
    return Form(
      key: _passRecformKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildPasswordTitle(context),
          AryanInputs.secondaryPasswordTextFormWithToggle(
            controller: _passwordController,
            inputHintText: AppLocalizations.of(context)!.passwordRecovery,
            validator: _passwordFieldValidator,
          ),
          const Divider(height: 20, color: Colors.transparent),
          ListTile(
            titleAlignment: ListTileTitleAlignment.center,
            title: Text(
              AppLocalizations.of(context)!.passwordRecovery,
              textAlign: TextAlign.center,
            ),
            horizontalTitleGap: 20,
            leading: const Icon(Icons.lock, color: Colors.black),
          ),
          AryanInputs.secondaryPasswordTextFormWithToggle(
            controller: _passwordController,
            inputHintText: AppLocalizations.of(context)!.password,
            validator: _passwordFieldValidator,
          ),
        ],
      ),
    );
  }

  Widget _buildOtpPasswordBody(String? phonNumber) {
    return Form(
      key: _passRecformKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            textAlign: TextAlign.center,
            AppLocalizations.of(
              context,
            )!.userOtpValidationTitle.replaceFirst('[]', phonNumber ?? ' '),
          ),

          TextButton.icon(
            label: Text(
              AppLocalizations.of(context)!.phoneNumber,
              style: TextStyle(color: ThemeColorsManager().primary),
            ),
            onPressed: () =>
                _getBackPressed(LoginOtpValidationState(phonNumber ?? '')),
            icon: AryanAppAssets.images.imageByValue(AryanAssets.smallGoCaret),
            iconAlignment: IconAlignment.start,
          ),
          VerificationWidget(),
        ],
      ),
    );
  }

  Widget _buildSignUpBody(LoginSignUpState state, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        HtmlTextParserWidget(
          text: AppLocalizations.of(context)!.userSignupLabel,
          textAlign: TextAlign.center,
          defaultStyle: AryanText.secondary(),
        ),
      ],
    );
  }

  Widget _buildLoadingState(LoginLoadingState state) {
    return Column(
      children: [
        const CircularProgressIndicator(),
        const SizedBox(height: 20),
        Text(state.message, style: AryanText.secondary()),
      ],
    );
  }

  Widget _buildErrorState(LoginCriticalErrorState state) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: Colors.red),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context, LoginStates state) {
    return LoadingButton(
      text: AppLocalizations.of(context)!.loginButtonText,
      onPressed: () => _handleButtonPress(context, state),
    );
  }

  void _handleButtonPress(BuildContext context, LoginStates state) {
    final bloc = context.read<LoginBloc>();

    if (state is LoginInitialState || state is LoginUsernameState) {
      _handleUsernameSubmit(bloc);
    } else if (state is LoginPasswordState) {
      _handlePasswordSubmit(bloc, state);
    } else if (state is LoginSignUpState) {
      _handleSignUp();
    } else if (state is LoginOtpValidationState) {
      // Handle OTP validation
    } else if (state is LoginRecoverPasswordState) {
      // Handle password recovery
    }
  }

  void _handleUsernameSubmit(LoginBloc bloc) {
    if (_userformKey.currentState?.validate() ?? false) {
      final username = _usernameController.text;
      bloc.add(LoginUsernameEvent(username));
    }
  }

  void _handlePasswordSubmit(LoginBloc bloc, LoginPasswordState state) {
    if (_passformKey.currentState?.validate() ?? false) {
      final password = _passwordController.text;
      bloc.add(LoginPasswordEvent(state.username, password));
    }
  }

  Future<void> _handleSignUp() async {
    try {
      await openUrl("https://github.com/");
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error opening signup page: $e')),
        );
      }
    }
  }

  Future<void> openUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  Widget _buildContent(LoginStates state, BuildContext context) {
    Widget content;
    SnackBarService messengerService = getIt.get<SnackBarService>();

    if (state is LoginLoadingState) {
      content = _buildLoadingState(state);
    } else if (state is LoginCriticalErrorState) {
      content = _buildErrorState(state);
    } else if (state is LoginUsernameState || state is LoginInitialState) {
      final username = state is LoginUsernameState ? state.username : '';
      content = _buildUsernameBody(username, context);
    } else if (state is LoginPasswordState) {
      content = _buildPasswordBody(state, context);
    } else if (state is LoginRecoverPasswordState) {
      content = _buildRecoverPasswordBody(state, context);
    } else if (state is LoginOtpValidationState) {
      content = _buildOtpPasswordBody(state.phoneNumber);
    } else if (state is LoginSignUpState) {
      content = _buildSignUpBody(state, context);
    } else {
      content = const SizedBox();
    }

    return content;
  }

  LoginEvents _getBackPressed(LoginStates currentState) {
    if (currentState is LoginPasswordState) {
      return LoginBackEvent(currentState);
    } else if (currentState is LoginRecoverPasswordState) {
      return LoginBackEvent(currentState);
    } else if (currentState is LoginSignUpState) {
      return LoginBackEvent(currentState);
    } else if (currentState is LoginOtpValidationState) {
      return LoginBackEvent(currentState);
    } else {
      return LoginInitialEvent();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginStates>(
      listener: (context, state) {
        if (state is LoginManagementPickerState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (dialogContext) => ManagementPickerModal(
                result: state.result,
                accounts: state.result.managementAccount ?? [],
                onAccountSelected: (account) {
                  final updatedResult = state.result.copyWith(
                    selectedAccount: account,
                    success: true,
                  );
                  context.read<LoginBloc>().add(
                    LoginManagementSelectedEvent(updatedResult, account),
                  );
                },
              ),
            );
          });
        }
        if (state is LoginSuccessState) {
          Navigator.of(context).pop(state.moduleResult);
        }

        if (state is LoginCriticalErrorState && mounted) {
          _snackBarService.showError(state.exception.toString());
        }
      },

      builder: (context, state) {
        return Scaffold(
          appBar: (state is LoginUsernameState || state is LoginInitialState)
              ? AppBar(
                  primary: true,
                  scrolledUnderElevation: 0.0,
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.white,
                  animateColor: false,
                  title: const LanguageButtonStandAlone(),
                )
              : AppBar(
                  toolbarHeight: 50,
                  primary: true,
                  animateColor: false,
                  backgroundColor: Colors.white,
                  scrolledUnderElevation: 0.0,
                  leading: CustomDynamicButton(
                    icon: const Icon(Icons.arrow_back),
                    useDefaultAnimation: false,
                    onPressed: () =>
                        context.read<LoginBloc>().add(_getBackPressed(state)),
                  ),
                  actions: const [LanguageButtonStandAlone()],
                ),
          body: _buildBody(state, context),
        );
        // } else {
        //   final pickerState = state as LoginManagementPickerState;
        //   final accounts = pickerState.result.managementAccount ?? [];
        //
        //   return Scaffold(
        //     body: Column(
        //       mainAxisSize: MainAxisSize.min,
        //       children: [
        //         Text("سلام امیر!", style: TextStyle(fontSize: 22)),
        //         SizedBox(height: 20),
        //         Expanded(
        //           child: ListView.builder(
        //             itemCount: accounts.length,
        //             itemBuilder: (context, index) {
        //               final account = accounts[index];
        //               return Card(
        //                 margin: EdgeInsets.symmetric(vertical: 8),
        //                 child: ListTile(
        //                   title: Text(
        //                     account.managementAccountDesc ?? "نام حساب ندارد",
        //                   ),
        //                   trailing: Icon(Icons.arrow_forward_ios),
        //                   onTap: () {
        //                     final updatedResult = pickerState.result.copyWith(
        //                       selectedAccount: account,
        //                     );
        //
        //                     context.read<LoginBloc>().add(
        //                       LoginSuccessEvent(updatedResult),
        //                     );
        //
        //                     Navigator.pop(context);
        //                   },
        //                 ),
        //               );
        //             },
        //           ),
        //         ),
        //         SizedBox(height: 20),
        //         ElevatedButton(
        //           onPressed: () => Navigator.pop(context),
        //           child: Text("بستن"),
        //         ),
        //       ],
        //     ),
        //   );
        // }
      },
    );
  }

  Widget _buildBody(LoginStates state, BuildContext context) {
    return Center(
      heightFactor: 1.5,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SizedBox(
            child: Column(
              key: ValueKey(state.runtimeType),
              children: [
                const AryanLogo(),
                const SizedBox(height: 20),
                _buildContent(state, context),
                if (state is! LoginLoadingState &&
                    state is! LoginCriticalErrorState)
                  const SizedBox(height: 50),
                if (state is! LoginLoadingState &&
                    state is! LoginCriticalErrorState)
                  _buildLoginButton(context, state),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
