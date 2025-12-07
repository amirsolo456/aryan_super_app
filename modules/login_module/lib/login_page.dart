import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_module/services/html_text_parser.dart';
import 'package:login_module/services/modal_manager.dart';
import 'package:login_module/services/snackbar_service.dart';
import 'package:resources_package/Resources/Assets/assets_manager.dart';
import 'package:resources_package/Resources/Assets/icons_manager.dart';
import 'package:resources_package/Resources/Styles/Colors/dark.dart';
import 'package:resources_package/Resources/Styles/font_size.dart';
import 'package:resources_package/l10n/app_localizations.dart';
import 'package:resources_package/l10n/app_localizations_fa.dart';
import 'package:resources_package/resources/Theme/theme_manager.dart';
import 'package:resources_package/resources/styles/styles.dart';
import 'package:services_package/setup_services.dart';
import 'package:ui_components_package/erp_app_componenets/common/Buttons/language_button_standalone/language_button_stand_alone.dart';
import 'package:ui_components_package/erp_app_componenets/common/aryan_logo.dart';
import 'package:ui_components_package/erp_app_componenets/mobile/Buttons/count_down.dart';
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
  var otpValue;
  AppLocalizations? loc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // این متد دقیقاً وقتی صدا میشه که Localizations آماده باشه
    loc = (AppLocalizations.of(context) != null
        ? AppLocalizations.of(context)!
        : AppLocalizationsFa("fa")); // اینجا ! امن هست!
  }

  String get _passwordValidationNullMsg =>
      AppLocalizations.of(context)?.passwordValidationNullMsg ??
      'رمز عبور را وارد کنید';

  String get _usernameValidationNullMsg =>
      AppLocalizations.of(context)?.usernameValidationNullMsg ??
      'شماره موبایل را وارد کنید';

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _passwordFieldValidator(String? value) {
    if (value == null || value.isEmpty) {
      return _passwordValidationNullMsg;
    }
    return null;
  }

  String? _usernameFieldValidator(String? value) {
    if (value == null || value.isEmpty) {
      return _usernameValidationNullMsg;
    }
    return null;
  }

  void sendOtpMessage() {}

  void submitOtpInput(String? code) {
    context.read<LoginBloc>().add(
      LoginRecoveryPasswordEvent(_usernameController.text, code ?? ""),
    );
  }

  bool isRtl() {
    return ((Localizations.localeOf(context).languageCode ?? "fa") == "fa"
        ? true
        : false);
  }

  String getSourceByIsRtl() {
    try {
      bool isRtl = this.isRtl();
      return (isRtl == true
          ? AryanAssets.smallGoCaret
          : AryanAssets.smallGoCaretRtl);
    } catch (e) {
      return AryanAssets.smallGoCaret;
    }
  }

  Widget _buildPasswordTitle(BuildContext context) {
    return SizedBox(
      height: 30,
      child: Text(
        (AppLocalizations.of(context)?.password ?? "A"),
        maxLines: 1,
        textWidthBasis: TextWidthBasis.parent,
        textAlign: TextAlign.start,
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
        (AppLocalizations.of(context)?.phoneNumber ?? "A"),
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.right,
        textWidthBasis: TextWidthBasis.parent,
        maxLines: 1,
        style: TextStyle(
          textBaseline: TextBaseline.ideographic,
          fontWeight: FontWeight.bold,
          fontFamily: 'Yekan',
          fontSize: 14,
          color: ThemeColorsManager(ThemeManager.themeMode).primary,
        ),
      ),
    );
  }

  Widget _buildUsernameBody(String username, BuildContext context) {
    _usernameController.text = username;
    return Form(
      key: _userformKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        verticalDirection: VerticalDirection.down,
        children: [
          _buildUsernameTitle(context),
          AryanInputs.secondaryUsernameTextForm(
            controller: _usernameController,
            obscureText: false,
            hintText: '0912 202 5458',
            validator: _usernameFieldValidator,
            isRtl: isRtl(),
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
          Container(
            padding: const EdgeInsets.only(bottom: 10),
            child: AryanInputs.secondaryPasswordTextFormWithToggle(
              controller: _passwordController,
              validator: _passwordFieldValidator,
              isRtl: isRtl(),
            ),
          ),

          Align(
            alignment: (isRtl() == true
                ? Alignment.bottomRight
                : Alignment.bottomLeft),
            child: TextButton(
              onPressed: () {
                final bloc = context.read<LoginBloc>();
                bloc.add(LoginOtpRequestMessageEvent(_usernameController.text));
              },
              child: Text(
                (AppLocalizations.of(context)?.passwordForgot ?? "A"),
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
            inputHintText:
                (AppLocalizations.of(context)?.passwordRecovery ?? "A"),
            validator: _passwordFieldValidator,
          ),
          const Divider(height: 20, color: Colors.transparent),
          ListTile(
            titleAlignment: ListTileTitleAlignment.center,
            title: Text(
              (AppLocalizations.of(context)?.passwordRecovery ?? "a"),
              textAlign: TextAlign.center,
            ),
            horizontalTitleGap: 20,
            leading: const Icon(Icons.lock, color: Colors.black),
          ),
          AryanInputs.secondaryPasswordTextFormWithToggle(
            controller: _passwordController,
            inputHintText: (AppLocalizations.of(context)?.password ?? "A"),
            validator: _passwordFieldValidator,
          ),
        ],
      ),
    );
  }

  Widget _buildOtpPasswordBody(
    String? phonNumber,
    BuildContext currentContext,
  ) {
    return Form(
      key: _passRecformKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            textAlign: TextAlign.center,
            style: TextStyle(
              color: FontColors.primary,
              fontSize: AryanSizes.mediumFont16,
            ),
            HtmlTextParserWidget.replaceAllBrackets(
              (AppLocalizations.of(currentContext) != null &&
                      AppLocalizations.of(
                            currentContext,
                          )?.userOtpValidationTitle !=
                          null
                  ? AppLocalizations.of(currentContext)!.userOtpValidationTitle
                  : "ad"),
              phonNumber ?? '',
            ),
          ),

          TextButton.icon(
            label: Text(
              (AppLocalizations.of(context)?.phoneNumber ?? "A"),
              style: TextStyle(
                color: Color(0XFF086EDC),
                fontSize: AryanSizes.smallFont12,
              ),
            ),
            onPressed: () =>
                currentContext.read<LoginBloc>().add(LoginInitialEvent()),
            icon: AryanAppAssets.images.imageByValue(
              getSourceByIsRtl(),
              width: 22,
              height: 22,
            ),
            iconAlignment: IconAlignment.start,
          ),
          VerificationWidget(
            onChanged: (value) => {otpValue = value},
            onSubmited: (value) => {
              currentContext.read<LoginBloc>().add(
                LoginOtpValidationEvent(
                  username: _usernameController.text,
                  otpCode: value,
                ),
              ),
            },
          ),

          ClickableCountDown(
            duration: Duration(minutes: 1, seconds: 30),
            finishedText:
                (AppLocalizations.of(context)?.untilSendOtpCodeAgain ?? "A"),
            untilFinishedText: (AppLocalizations.of(context) != null
                ? (AppLocalizations.of(context)?.sendOtpCodeAgain ?? "test a")
                : "test a"),
            onFinishedClick: sendOtpMessage,
          ),
        ],
      ),
    );
  }

  Widget _buildSignUpBody(LoginSignUpState state, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        HtmlTextParserWidget(
          text: (AppLocalizations.of(context)?.userSignupLabel ?? "a"),
          textAlign: TextAlign.center,
          defaultStyle: AryanText.secondary(),
        ),
      ],
    );
  }

  Widget _buildLoadingState(LoginLoadingState state) {
    return customLoadingWidget(state.message);
  }

  Widget _buildLoginOtpProgress(LoginOtpRequestState state) {
    return customLoadingWidget(state.phoneNumber);
  }

  Widget customLoadingWidget(String? message) {
    return Column(
      children: [
        const CircularProgressIndicator(),
        const SizedBox(height: 20),
        Text(message ?? "", style: AryanText.secondary()),
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

  void _handleButtonPress(BuildContext context, LoginStates state) {
    final bloc = context.read<LoginBloc>();

    if (state is LoginInitialState || state is LoginUsernameState) {
      _handleUsernameSubmit(bloc);
    } else if (state is LoginPasswordState) {
      _handlePasswordSubmit(bloc, state);
    } else if (state is LoginSignUpState) {
      _handleSignUp();
    } else if (state is LoginOtpRequestState) {
      _handleOtpRequestSubmit(bloc, state);
    } else if (state is LoginOtpValidationState) {
      _handleOtpValidationSubmit(bloc, state);
    } else if (state is LoginRecoverPasswordState) {
      _handleRecoveryPasswordSubmit(bloc, state);
    } else if (state is LoginSuccessState) {
      _handleSuccessSubmit(bloc, state);
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

  void _handleSuccessSubmit(LoginBloc bloc, LoginSuccessState state) {
    bloc.add(LoginSuccessEvent(state.moduleResult));
  }

  void _handleRecoveryPasswordSubmit(
    LoginBloc bloc,
    LoginRecoverPasswordState state,
  ) {
    bloc.add(LoginRecoveryPasswordEvent(state.username, state.otpCode));
  }

  void _handleOtpRequestSubmit(LoginBloc bloc, LoginOtpRequestState state) {
    bloc.add(LoginOtpRequestMessageEvent(state.phoneNumber));
  }

  void _handleOtpValidationSubmit(
    LoginBloc bloc,
    LoginOtpValidationState state,
  ) {
    if (otpValue != null && otpValue == state.correctOtpCode) {
      bloc.add(
        LoginOtpValidationEvent(
          username: state.phoneNumber,
          otpCode: state.correctOtpCode,
        ),
      );
    }
  }

  Future<void> _handleSignUp() async {
    try {
      await openUrl("https://github.com/");
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)?.showSnackBar(
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

  Widget _buildLoginButton(
    BuildContext context,
    LoginStates state,
    String? loginTitle,
  ) {
    return LoadingButton(
      text:
          loginTitle ?? (AppLocalizations.of(context)?.loginButtonText ?? "A"),
      onPressed: () => _handleButtonPress(context, state),
    );
  }

  Widget _buildContent(LoginStates state, BuildContext context) {
    Widget content;
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
    } else if (state is LoginOtpRequestState) {
      content = _buildLoginOtpProgress(state);
    } else if (state is LoginOtpValidationState) {
      content = _buildOtpPasswordBody(state.phoneNumber, context);
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
              children: [
                const AryanLogo(),
                const SizedBox(height: 20),
                _buildContent(state, context),
                if (state is! LoginLoadingState &&
                    state is! LoginCriticalErrorState)
                  const SizedBox(height: 50),
                if (state is! LoginLoadingState &&
                    state is! LoginCriticalErrorState)
                  _buildLoginButton(
                    context,
                    state,

                    (state is LoginOtpValidationState
                        ? AppLocalizations.of(context)!.loginButtonOtpText
                        : (state is LoginSignUpState
                              ? AppLocalizations.of(
                                  context,
                                )!.loginButtonSignUpText
                              : null)),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
