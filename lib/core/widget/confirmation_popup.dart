import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../constants/app_assets.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../constants/app_styles.dart';
import '../constants/app_values.dart';
import '../constants/helpers.dart';
import 'custom_button.dart';
import 'loading_widget.dart';

class Dialogs {
  static Future<void> confirmationPopup({
    required BuildContext context,
    required String confirmation,
    required VoidCallback onTap,
    Widget? confirmationButton,
  }) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: RichText(
            text: TextSpan(
              text: '${AppStrings.confirmation} ',
              style: AppStyles.title.copyWith(
                  overflow: TextOverflow.visible, color: AppColors.black),
              children: <TextSpan>[
                TextSpan(
                    text: confirmation,
                    style: AppStyles.title.copyWith(
                        overflow: TextOverflow.visible,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black)),
              ],
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actionsPadding: const EdgeInsets.only(bottom: 25),
          actions: <Widget>[
            confirmationButton ??
                CustomButton(
                  text: 'yes'.tr(),
                  height: AppSize.s45,
                  onTap: onTap,
                  size: ButtonSize.small,
                  buttonColor: AppColors.secondary,
                  enabled: true,
                  hasLoading: true,
                ),
            CustomButton(
              type: ButtonType.bordered,
              height: AppSize.s45,
              text: 'cancel'.tr(),
              onTap: () {
                Navigator.pop(context);
              },
              size: ButtonSize.small,
              enabled: true,
              buttonColor: Colors.transparent,
              textColor: AppColors.red,
            ),
          ],
        );
      },
    );
  }

  static Future<void> datePickerPopup({
    required BuildContext context,
    required Widget content,
    bool isEnabled = false,
  }) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: SizedBox(height: 360, width: 240, child: content),
        );
      },
    );
  }


  static Future<void> loading({
    required BuildContext context,
  }) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            // Return true to allow the user to close the dialog
            // Return false to prevent the user from closing the dialog
            return false;
          },
          child:  Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: SizedBox(
                height: 100.h,
                width: 50.w,
                child: const LoadingWidget()),
          ),
        );
      },
    );
  }

  static Future<void> success({
    required BuildContext context,
    String? message,
  }) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            // Return true to allow the user to close the dialog
            // Return false to prevent the user from closing the dialog
            return true;
          },
          child: Dialog(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  Height.v16,
                  Lottie.asset(AppAssets.success,
                      repeat: false,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover),
                  Height.v8,
                  Center(
                      child: Text(
                    message ?? 'success'.tr(),
                    style: AppStyles.headline,
                  )),
                  Height.v16,
                ],
              ),
            ),
          ),
        );
      },
    );
  }

}







