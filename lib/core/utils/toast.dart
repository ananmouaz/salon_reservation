import 'package:flutter/material.dart';
import 'package:m_toast/m_toast.dart';

import '../constants/app_colors.dart';
import '../constants/app_icons.dart';

enum ToastType {
  informative,
  success,
  error,
}

class Toasts {
  static void show(BuildContext context, String message, ToastType type) {
    ShowMToast toast = ShowMToast(context);

    const Alignment alignment = FractionalOffset(0.0, 0.95);

    switch (type) {
      case ToastType.informative:
        toast.successToast(
            icon: AppIcons.informative,
            iconColor: AppColors.secondary,
            backgroundColor: const Color(0xffc3e9f4),
            message: message,
            alignment: alignment,
            duration: 2500
        );
        break;
      case ToastType.success:
        toast.successToast(
            message: message,
            alignment: alignment,
            duration: 2500
        );
        break;
      case ToastType.error:
        toast.errorToast(
            icon: AppIcons.error,
            message: message,
            alignment: alignment,
            duration: 2500
        );
        break;
      default:
    }

  }



}

