import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:salon_reservation/core/constants/app_styles.dart';

import '../../../../core/constants/app_colors.dart';

class StatusWidget extends StatelessWidget {
  final String status;

  StatusWidget({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    // Map to define status properties
    final Map<String, StatusProperties> statusMap = {
      'Pending': StatusProperties(
        bgColor: Colors.orange,
        icon: Icons.pending,
      ),
      'Approved': StatusProperties(
        bgColor: Colors.green,
        icon: Icons.check_circle,
      ),
      'Canceled': StatusProperties(
        bgColor: Colors.red,
        icon: Icons.cancel,
      ),
      'Finished': StatusProperties(
        bgColor: Colors.blue,
        icon: Icons.done,
      ),
    };

    // Get status properties from the map
    final StatusProperties properties = statusMap[status] ?? StatusProperties();

    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            properties.icon,
            color: Colors.white,
          ),
          SizedBox(width: 8.0),
          Text(
            status.tr(),
            style: AppStyles.body.copyWith(color: AppColors.white),
          ),
        ],
      ),
    );
  }
}

class StatusProperties {
  final Color bgColor;
  final IconData icon;

  StatusProperties({
    this.bgColor = Colors.grey,
    this.icon = Icons.info,
  });
}