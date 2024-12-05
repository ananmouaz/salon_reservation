import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_styles.dart';
import 'app_values.dart';

class AppInputStyle {
  static final OutlineInputBorder errorBorderStyle = OutlineInputBorder(
    borderSide: const BorderSide(color: AppColors.red),
    borderRadius: AppSize.borderRadius,
  );

  static final OutlineInputBorder enabledBorderStyle = OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.transparent),
    borderRadius: AppSize.borderRadius,
  );

  static final OutlineInputBorder focusedBorderStyle = OutlineInputBorder(
    borderSide: const BorderSide(color: AppColors.primary),
    borderRadius: AppSize.borderRadius,
  );

  static InputDecoration getInputDecoration({required String hint, Widget? prefix,Widget? suffix}) {
    return InputDecoration(
      errorStyle: AppStyles.title.copyWith(color: AppColors.red),
      hintStyle: AppStyles.title.copyWith(color: AppColors.darkGray),
      border: InputBorder.none,
      hintText: hint,
      prefixIcon: prefix,
      suffixIcon: suffix,
      fillColor: AppColors.lightGray,
      filled: true,
      errorBorder: errorBorderStyle,
      focusedErrorBorder: errorBorderStyle,
      enabledBorder: enabledBorderStyle,
      focusedBorder: focusedBorderStyle,
    );
  }

}