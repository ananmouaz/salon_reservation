import 'package:salon_reservation/core/constants/app_colors.dart';
import 'package:salon_reservation/core/constants/app_styles.dart';
import 'package:salon_reservation/core/utils/navigation.dart';
import 'package:salon_reservation/features/home/presentation/pages/settings_page.dart';
import 'package:salon_reservation/features/user/data/model/login_response_model.dart';
import 'package:salon_reservation/features/user/domain/user_reposirory.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../utils/di.dart';
import '../utils/launchers.dart';
import '../utils/shared_perefrences/shared_perefrences_helper.dart';
import 'language_selector.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  LoginResponseModel? userInfo;

  static final AppPreferences _appPreferences = instance<AppPreferences>();

  getUserInfo() async {
    userInfo = await LoginResponseModel.getLoginFromFile();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      surfaceTintColor: Colors.white,
      child: Column(
        children: [
          // Drawer header
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: AppColors.secondary,
            ),
            accountName: Text(
              _appPreferences.getName() ?? '',
              style: AppStyles.title,
            ),
            accountEmail: Text(
              _appPreferences.getPhone() ?? '',
              style: AppStyles.title,
            ),
            currentAccountPicture: const CircleAvatar(
              backgroundImage: AssetImage('assets/images/female.png'),
              backgroundColor: AppColors.white,
            ),
          ),

          // Drawer options
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(
              'language'.tr(),
              style: AppStyles.title,
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    surfaceTintColor: Colors.white,
                    title: Text('languageBody'.tr(), style: AppStyles.headline,),
                    actions: const <Widget>[
                      LanguageSelector()
                    ],
                  );
                },
              );
            },
          ),

/*          // Drawer options
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text(
              'settings'.tr(),
              style: AppStyles.title,
            ),
            onTap: () {
              Navigation.push(context, SettingsPage());
            },
          ),*/

          ListTile(
            leading: const Icon(Icons.phone),
            title: Text(
              'contactUs'.tr(),
              style: AppStyles.title,
            ),
            onTap: () {
              _launchPhoneCall();
            },
          ),
          const Spacer(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: Text(
              'logout'.tr(),
              style: AppStyles.title,
            ),
            onTap: () {
              UserRepository.logout(context);
            },
          ),
        ],
      ),
    );
  }

  _launchPhoneCall() async {
    Launchers.launchWebUrl('https://wa.me/+963968896471');
  }
}
