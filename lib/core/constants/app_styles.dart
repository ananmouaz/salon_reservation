import 'package:flutter/material.dart';

import '../utils/di.dart';
import '../utils/shared_perefrences/shared_perefrences_helper.dart';

class AppStyles {
  static final AppPreferences _appPreferences = instance<AppPreferences>();
  static  String lang = _appPreferences.getLanguage();

  static const String enFont =   'Poppins';
  static const String arFont =   'Cairo';

  static String font = arFont;



  static TextStyle headline =  TextStyle(
    fontFamily: font,
    fontWeight: FontWeight.w700,
    fontSize: 16,
    letterSpacing: 0.4,
    overflow: TextOverflow.ellipsis,
  );

  static TextStyle title = TextStyle(
    overflow: TextOverflow.ellipsis,
    fontFamily: font,
    fontWeight: FontWeight.normal,
    fontSize: 14,
    letterSpacing: 0.4,
  );

  static TextStyle body = TextStyle(
    fontFamily: font,
    fontWeight: FontWeight.normal,
    fontSize: 12,
    letterSpacing: 0.4,
  );
}