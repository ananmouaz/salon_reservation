import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:salon_reservation/core/constants/app_colors.dart';
import 'package:salon_reservation/core/constants/app_styles.dart';
import 'package:salon_reservation/core/constants/helpers.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:salon_reservation/features/salon/presentation/widget/service_widget.dart';

import '../../../../core/api/http/api_urls.dart';
import '../../../../core/utils/navigation.dart';
import '../../../../core/widget/base_page.dart';
import '../../../Appointment/presentation/pages/AppintmentIntervalsPage.dart';
import '../../../salon/data/model/salon_model.dart';

class RestaurantPage extends StatefulWidget {
  final SalonModel salon;

  const RestaurantPage({
    super.key,
    required this.salon,
  });

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      hasMenu: false,
      hasPadding: false,
      isScrollable: false,
      title: widget.salon.name ?? '',
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image(
                    image: NetworkImage(
                        '${ApiURLs.imageBaseUrl}${widget.salon.image ?? ''}'),
                    height: 200.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Height.v12,
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_rounded,
                      color: AppColors.secondary,
                      size: 20,
                    ),
                    Width.v8,
                    Text(
                      widget.salon.location ?? '',
                      style: AppStyles.title.copyWith(
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ],
                ),
                Height.v12,
                Row(
                  children: [
                    const Icon(
                      Icons.access_time_filled,
                      color: AppColors.secondary,
                      size: 20,
                    ),
                    Width.v8,
                    Text(
                      widget.salon.open ?? '',
                      style: AppStyles.title.copyWith(
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Height.v12,
            Text(
              'menu'.tr(),
              style: AppStyles.headline.copyWith(
                  overflow: TextOverflow.visible,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            Height.v8,
            Expanded(
              child: ListView.builder(
                itemCount: widget.salon.service?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  return ServiceWidget(
                      onTap: () {
                        Navigation.push(
                            context,
                            AppointmentIntervalsPage(
                              businessId: widget.salon.id.toString(),
                              serviceId:
                              widget.salon.service![index].id.toString(),
                            ));
                      },
                      service: widget.salon.service?[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
