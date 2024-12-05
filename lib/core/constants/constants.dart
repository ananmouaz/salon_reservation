import 'package:flutter/material.dart';

import '../utils/di.dart';
import '../utils/shared_perefrences/shared_perefrences_helper.dart';

class Constants {
  static final AppPreferences appPreferences = instance<AppPreferences>();

  static const APP_NAME = 'Book it Beauté';
  static const APP_VERSION = '1.0.0';

// Languages
  static String defaultLanguage = appPreferences.getLanguage();
  static const Map<String, Locale> languages = {
    'en': Locale('en'),
    'ar': Locale('ar'),
  };
}

