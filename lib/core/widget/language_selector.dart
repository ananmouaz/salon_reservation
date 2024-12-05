import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_styles.dart';
import '../../../../core/utils/di.dart';
import '../../../../core/utils/shared_perefrences/shared_perefrences_helper.dart';
import '../../features/home/presentation/pages/splash_page.dart';
import '../constants/constants.dart';
import '../utils/navigation.dart';

class LanguageSelector extends StatefulWidget {
  const LanguageSelector({super.key});

  @override
  _LanguageSelectorState createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  bool _isArabicSelected = false;
  bool _isEnglishSelected = false;

  static final AppPreferences _appPreferences = instance<AppPreferences>();

  @override
  void initState() {
    _getSelectedLanguage();
    super.initState();
  }

  _getSelectedLanguage() {
    String lang = _appPreferences.getLanguage();
    if(lang == 'ar') {
      _isArabicSelected = true;
    }
    else {
      _isEnglishSelected = true;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CheckboxListTile(
          title: Text('العربية', style: AppStyles.title,),
          value: _isArabicSelected,
          onChanged: (value) {
            context.setLocale(Constants.languages['ar']!);
            setState(() {
              _isArabicSelected = value!;
              _appPreferences.setLanguage('ar');
              _isEnglishSelected = !value;
            });
            setState((){});
            //Navigation.pushReplacement(context, const SplashScreen());
          },
        ),
        CheckboxListTile(
          title: Text('English', style: AppStyles.title,),
          value: _isEnglishSelected,
          onChanged: (value) {
            context.setLocale(Constants.languages['en']!);
            setState(() {
              _appPreferences.setLanguage('en');
              _isEnglishSelected = value!;
              _isArabicSelected = !value;
            });
            setState((){});
            //Navigation.pushReplacement(context, const SplashScreen());
          },
        ),
      ],
    );
  }
}
