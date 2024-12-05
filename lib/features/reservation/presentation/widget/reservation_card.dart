import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:salon_reservation/core/constants/app_colors.dart';
import 'package:salon_reservation/core/constants/app_styles.dart';
import 'package:salon_reservation/core/constants/helpers.dart';
import 'package:salon_reservation/features/reservation/presentation/widget/status_widget.dart';

import '../../../../core/utils/navigation.dart';
import '../../../../core/widget/custom_button.dart';
import '../../data/reservation_model.dart';
import '../add_review_page.dart';

class ReservationCard extends StatelessWidget {
  const ReservationCard({super.key, this.reservation});

  final Reservation? reservation;

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(
        flex: 1,
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: AppColors.secondary)
          ),
          color: AppColors.white,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      reservation?.business?.name ?? '',
                      style: AppStyles.headline.copyWith(color: AppColors.secondary),
                    ),
                    (reservation?.business?.status ?? '') == 'Finished' ?
                    TextButton(
                      onPressed: () {
                        Navigation.push(context, AddReviewPage(businessId: reservation?.business?.id ?? 0));
                      },
                      child: Text('Add review'.tr(), style: AppStyles.title,),
                    ) :
                    Container(
                      child: Text(
                        reservation?.service?.service ?? '',
                        style: AppStyles.body.copyWith(color: AppColors.secondary),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                color: AppColors.secondary.withOpacity(0.8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                     Text(
                      reservation?.time ?? '',
                      style: AppStyles.body.copyWith(color: AppColors.white),
                    ),
                    StatusWidget(status: reservation?.status ?? ''),
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    ]);
  }
}
