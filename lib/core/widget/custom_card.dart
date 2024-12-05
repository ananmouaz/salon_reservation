import 'package:salon_reservation/core/constants/app_colors.dart';
import 'package:salon_reservation/core/constants/app_styles.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final IconData? icon; // The icon is optional, so it can be null.
  final Color? cardColor;
  final Function() onPressed;

  const CustomCard({super.key,
    required this.title,
    this.icon,
    this.cardColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: const BorderSide(color: AppColors.primary,)
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) // Show the icon only if it's not null
              Icon(
                icon,
                size: 30,
                color: AppColors.secondary,
              ),
            if(icon != null)
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppStyles.title,
            ),
          ],
        ),
      ),
    );
  }
}
