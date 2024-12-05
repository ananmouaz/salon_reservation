import 'package:easy_localization/easy_localization.dart';

class Formatters {
  static String formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  static String formatPrice(double price) {
    // Create a NumberFormat instance for Syrian Pound (SYP)
    final NumberFormat formatter = NumberFormat.currency(locale: 'ar_SY', symbol: 'lira'.tr(), decimalDigits: 0);

    // Format the price using the NumberFormat instance
    String formattedPrice = formatter.format(price);

    return formattedPrice;
  }
}