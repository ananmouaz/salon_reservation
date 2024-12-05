import 'package:salon_reservation/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

import 'custom_card.dart';

class CustomCardItem {
  final String title;
  final IconData? icon;
  final Function() onPressed;

  CustomCardItem({
    required this.title,
    this.icon,
    required this.onPressed,
  });
}

class CustomGrid extends StatelessWidget {
  final List<CustomCardItem> customCardItems;

  CustomGrid({required this.customCardItems});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // You can change the number of cards in a row here
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
        childAspectRatio: 1.5
      ),
      itemCount: customCardItems.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final item = customCardItems[index];
        return CustomCard(
          cardColor: AppColors.lightGray,
          title: item.title,
          onPressed: item.onPressed,
        );
      },
    );
  }
}
