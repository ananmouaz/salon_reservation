import 'package:salon_reservation/features/user/presentation/pages/profile_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_styles.dart';
import '../../../../core/constants/helpers.dart';
import '../../../../core/utils/navigation.dart';
import '../../../../core/widget/base_page.dart';
import '../../../../core/widget/language_selector.dart';
import '../widget/settings_card.dart';


class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  @override
  Widget build(BuildContext context) {
    return BasePage(
      hasMenu: false,
      isCentered: false,
      title: 'settings'.tr(),
      content: _buildBody(context),
    );
  }


  _buildBody(context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [

/*        SettingsCard(
          title: 'personalProfile'.tr(),
          onTap: () {
            Navigation.push(context, const ProfilePage());
          },
          description: "personalProfileBody".tr(),
        ),*/


        SettingsCard(
          title: "language".tr(),
          onTap: ()  {
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
          description: "languageBody".tr(),
        ),


        SettingsCard(
          title: "update".tr(),
          onTap: () {
            //Navigation.push(context, const AboutUsPage());
          },
          description: "updateBody".tr(),

        ),
      ],
    );
  }
}
