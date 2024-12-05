import 'package:easy_localization/easy_localization.dart';

class Validator {
  static String? validateEmpty(String value, String fieldName) {
    if (value.isEmpty) {
      return '$fieldName ${'isRequired'.tr()}';
    }
    return null;
  }

  static String? validateEmptyWithoutMessage(String value) {
    if (value.isEmpty) {
      return '';
    }
    return null;
  }

  static String? validatePassword(String value, String fieldName) {
    if (value.isEmpty) {
      return '$fieldName ${'isRequired'.tr()}';
    }

    else if(value.length < 6) {
      return '$fieldName ${'must be 6 characters or more'.tr()}';
    }
    return null;
  }


  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'emptyPhoneValidation'.tr();
    }

    // You can use a regular expression to validate the phone number format.
    // For simplicity, we'll just check if it contains only digits.
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'invalidPhoneValidation'.tr();
    }

    return null;
  }

// Add more validation methods as needed
}
