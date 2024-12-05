import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:salon_reservation/core/constants/app_colors.dart';
import 'package:salon_reservation/core/constants/app_styles.dart';
import 'package:salon_reservation/core/constants/helpers.dart';
import 'package:salon_reservation/core/formatters.dart';

import '../../data/model/salon_model.dart';

class ServiceWidget extends StatelessWidget {
  final ServiceModel? service;
  final VoidCallback? onTap;

  const ServiceWidget({super.key,
    required this.service, this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.0),
        margin: EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: AppColors.secondary.withOpacity(0.8),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            service?.name != null ?
            Row(
              children: [
                Icon(Icons.person, color: AppColors.white, size: 20,),
                Width.v8,
                Text(
                  service?.name ?? '',
                  style: AppStyles.title.copyWith(color: AppColors.white),
                ),
              ],
            ) : SizedBox.shrink(),
            if(service?.name != null)
              Height.v8,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  service?.service ?? '',
                  style: AppStyles.headline.copyWith(color: AppColors.white, fontSize: 16),
                ),

                Text(
                  '${service?.type ?? ''}',
                  style: AppStyles.title.copyWith(color: AppColors.white),
                ),
              ],
            ),
            Height.v8,
            const Divider(
              color: AppColors.white,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.access_time_filled_outlined, color: AppColors.white,),
                    Width.v8,
                    Text(
                      '${service?.duration}',
                      style: AppStyles.body.copyWith(color: AppColors.white),
                    ),
                  ],
                ),
                Text(
                  Formatters.formatPrice(service?.price?.toDouble() ?? 0),
                  style: AppStyles.headline.copyWith(color: AppColors.white),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}