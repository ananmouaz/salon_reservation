import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salon_reservation/core/api/http/api_urls.dart';
import 'package:salon_reservation/core/constants/app_styles.dart';
import 'package:salon_reservation/core/constants/helpers.dart';
import 'package:salon_reservation/core/utils/navigation.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../data/model/salon_model.dart';
import '../pages/salon_page.dart';

class SalonCard extends StatelessWidget {
  final SalonModel salon;

  const SalonCard({
    super.key,
    required this.salon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigation.push(context,
            SalonPage(salon: salon,));
      },
      child: Card(
        color: AppColors.white,
        elevation: 0,
        // Set the shape of the card using a rounded rectangle border with a 8 pixel radius
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: AppColors.midGray)
        ),
        // Set the clip behavior of the card
        clipBehavior: Clip.antiAliasWithSaveLayer,
        // Define the child widgets of the card
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Display an image at the top of the card that fills the width of the card and has a height of 160 pixels
            Image(
              image: NetworkImage( '${ApiURLs.imageBaseUrl}${salon.image ?? ''}',),
              height: 120.h,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            // Add a container with padding that contains the card's title, text, and buttons
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Display the card's title using a font size of 24 and a dark grey color
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        salon.name ?? '',
                        style: AppStyles.headline.copyWith(fontWeight: FontWeight.w600),
                        ),
                      Text(
                        salon.location ?? '',
                        style: AppStyles.body.copyWith(color: AppColors.darkerGray),
                      )
                    ],
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
