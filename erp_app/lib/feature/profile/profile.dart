import 'package:erp_app/feature/profile/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resources_package/l10n/app_localizations.dart';

class ProfilePage extends StatefulWidget {
  final bool refreshData;

  const ProfilePage({super.key, required this.refreshData});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final Widget userInfoIcon = Image.asset(
    'assets/images/userinfo.png',
    package: 'resources_package',
  );
  final Widget userPasswordChange = Image.asset(
    'assets/images/user_password_change.png',
    package: 'resources_package',
  );
  final Widget userWallet = Image.asset(
    'assets/images/user_wallet.png',
    package: 'resources_package',
  );
  final Widget userSettings = Image.asset(
    'assets/images/user_settings.png',
    package: 'resources_package',
  );
  final Widget userOtherAccounts = Image.asset(
    'assets/images/user_other_accounts.png',
    package: 'resources_package',
  );
  final Widget userTitle = Image.asset(
    'assets/images/user_title.png',
    package: 'resources_package',
  );
  final Widget userDevices = Image.asset(
    'assets/images/user_devices.png',
    package: 'resources_package',
  );
  final Widget userSignOut = Image.asset(
    'assets/images/user_sign_out.png',
    package: 'resources_package',
  );
  final TextStyle itemsStyle = GoogleFonts.abel(
    color: Color(0xFF585858),
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  @override
  void initState() {
    super.initState();
    if (widget.refreshData) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<ProfileBloc>().add(ProfileInitialEvent());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileInitialState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProfileLoadDataSuccess) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      AppLocalizations.of(context)!.userPasswordChange,
                      style: itemsStyle,
                    ),
                    horizontalTitleGap: 10,
                    leading: userPasswordChange,
                  ),
                  Divider(height: 10, color: Color(0xFFB1B1B1)),
                  ListTile(
                    title: Text(
                      AppLocalizations.of(context)!.userWallet,
                      style: itemsStyle,
                    ),
                    horizontalTitleGap: 10,
                    leading: userWallet,
                  ),
                  Divider(height: 10, color: Color(0xFFB1B1B1)),
                  ListTile(
                    title: Text(
                      AppLocalizations.of(context)!.userSettings,
                      style: itemsStyle,
                    ),
                    horizontalTitleGap: 10,
                    leading: userSettings,
                  ),
                  Divider(height: 10, color: Color(0xFFB1B1B1)),
                  ListTile(
                    title: Text(
                      AppLocalizations.of(context)!.userOtherAccounts,
                      style: itemsStyle,
                    ),

                    horizontalTitleGap: 10,
                    leading: userOtherAccounts,
                  ),
                  Divider(height: 10, color: Color(0xFFB1B1B1)),

                  ListTile(
                    title: Text(
                      AppLocalizations.of(context)!.usersTitle,
                      style: itemsStyle,
                    ),
                    contentPadding: EdgeInsets.only(right: 30),
                    horizontalTitleGap: 10,
                    leading: userInfoIcon,
                  ),

                  Divider(height: 10, color: Color(0xFFB1B1B1)),
                  ListTile(
                    title: Text(
                      AppLocalizations.of(context)!.usersDevices,
                      style: itemsStyle,
                    ),
                    horizontalTitleGap: 10,
                    leading: userDevices,
                  ),
                  Divider(height: 10, color: Color(0xFFB1B1B1)),
                  ListTile(
                    title: Text(
                      AppLocalizations.of(context)!.usersSignOut,
                      style: TextStyle(
                        color: Color(0xFFDC3545),
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    horizontalTitleGap: 10,
                    leading: userSignOut,
                    onTap: onSignoutPressed,
                  ),
                ],
              ),
            ),
          );
        } else if (state is ProfileLoadDataError) {
          return Text('Error');
        } else if (state is ProfileLoadDataSource) {
          return Text('Error');
        } else {
          return SizedBox();
        }
      },
    );
  }

  void onSignoutPressed() {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => LoginPage()),
    // );
  }
}
