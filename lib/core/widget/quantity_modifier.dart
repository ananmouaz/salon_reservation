import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_colors.dart';
import '../constants/app_styles.dart';
import '../constants/helpers.dart';

class QuantityModifier extends StatefulWidget {
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;
  final VoidCallback? onTap;
  final String quantity;

  const QuantityModifier(
      {super.key,
      required this.onDecrease,
      required this.onIncrease,
      this.onTap,
      required this.quantity});

  @override
  State<QuantityModifier> createState() => _QuantityModifierState();
}

class _QuantityModifierState extends State<QuantityModifier> {
  final BoxDecoration _quantityContainerDecoration = BoxDecoration(boxShadow: [
    BoxShadow(
        color: Colors.grey.withOpacity(0.2),
        blurRadius: 5,
        offset: const Offset(0, 3)),
  ], shape: BoxShape.circle, color: AppColors.white);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Container(
              height: 50.h,
              width: 50.h,
              decoration: _quantityContainerDecoration,
              child: const Icon(Icons.remove, color: AppColors.darkGray)),
          padding: EdgeInsets.zero,
          onPressed: widget.onDecrease,
        ),
        Width.v12,

        widget.onTap == null ? Text(
          widget.quantity,
          style: AppStyles.headline.copyWith(fontWeight: FontWeight.normal),
        ) :
        GestureDetector(
          onTap: widget.onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primary),
              // Add a border to indicate it's clickable
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              widget.quantity,
              style: AppStyles.headline.copyWith(fontWeight: FontWeight.normal),
            ),
          ),
        ),
        Width.v12,
        IconButton(
          icon: Container(
              height: 50.h,
              width: 50.h,
              decoration: _quantityContainerDecoration,
              child: const Icon(
                Icons.add,
                color: AppColors.darkGray,
              )),
          padding: EdgeInsets.zero,
          onPressed: widget.onIncrease,
        ),
      ],
    );
  }
}
