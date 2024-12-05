import 'dart:ui' as UI;

import 'package:flutter/material.dart';
import 'package:salon_reservation/core/constants/helpers.dart';

import '../../../../core/boilerplate/create_model/cubits/create_model_cubit.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_styles.dart';
import '../../../reservation/data/reservation_model.dart';


class AppointmentListCard extends StatelessWidget {
  final GestureTapCallback? onTap;
  final Reservation? reservation;
  final bool active;

  CreateModelCubit? deleteCubit;

  AppointmentListCard(
      {Key? key, this.onTap, this.reservation, this.active = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildAppointmentCard(
      context,
    );
  }

  Widget _buildAppointmentCard(context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: AppColors.black),
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
        ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Doctor and health center
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Salon name
              Text(
                reservation?.business?.name ?? '',
                style: AppStyles.headline.copyWith(color: AppColors.secondary),
              ),
              Height.v8,
              // Service name
              Text(
                '${reservation?.service?.type ?? ''} | ${reservation?.service?.service ?? ' '}',
                style: AppStyles.body,
              ),
              Text(
                reservation?.time.toString() ?? '',
                style: AppStyles.body,
              ),
            ],
          ),
        ],
      ),
    );
  }



  String getDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

}
