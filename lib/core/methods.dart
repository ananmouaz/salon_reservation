import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'constants/app_colors.dart';

class Methods {
  static Map<String, Color> statusColors = {
    "Approved": AppColors.approved,
    "Pending": AppColors.pending,
    "Canceled": AppColors.cancelled,
    "Delivered": AppColors.reversed,
  };

  static Map<String, String> statusName = {
    "Approved": 'approved'.tr(),
    "Pending": 'pending'.tr(),
    "Canceled": 'cancelled'.tr(),
    "Delivered": 'delivered'.tr(),
  };

  static Map<String, Color> statusBgColors = {
    "Approved": AppColors.approvedBg,
    "Pending": AppColors.pendingBg,
    "Canceled": AppColors.cancelledBg,
    "Delivered": AppColors.reversedBg,
  };

  static String getDate(String? date) {
    var myFormat = DateFormat('dd/MM/yyyy');
    DateTime datetime = DateTime.parse(date!);
    String formattedDate = myFormat.format(datetime).toString();
    return formattedDate;
  }

  static String capitalizeFirst(String str) {
    return '${str[0].toUpperCase()}${str.substring(1)}';
  }

  static String getTime(String? date) {
    DateTime datetime = DateTime.parse(date!);
    String formattedDate = DateFormat.jm().format(datetime);
    return formattedDate;
  }

  static String formatMoney(double amount) {
    final formatter = NumberFormat.currency(locale: 'ar_SY', symbol: '', decimalDigits: 0);
    return formatter.format(amount);
  }
}