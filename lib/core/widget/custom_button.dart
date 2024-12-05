import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../constants/app_colors.dart';
import '../constants/app_styles.dart';
import '../constants/app_values.dart';
import '../constants/helpers.dart';

enum ButtonType { bordered, filled }

enum ButtonSize { small, large }

class CustomButton extends StatefulWidget {
  const CustomButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.size = ButtonSize.large,
    this.type= ButtonType.filled,
    this.enabled = true,
    this.hasLoading = false,
    this.buttonColor = AppColors.secondary,
    this.textColor = AppColors.white,
    this.isBold = false,
    this.height,
    this.width,
    this.iconData
  }) : super(key: key);

  final bool enabled;
  final ButtonSize size;
  final ButtonType type;
  final Function onTap;
  final String text;
  final Color buttonColor;
  final Color textColor;
  final bool isBold;
  final bool hasLoading;
  final double? height;
  final double? width;
  final IconData? iconData;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isLoading = false;

  double _getButtonWidth(BuildContext context) {
    return widget.size == ButtonSize.small ? MediaQuery.of(context).size.width * 0.45 : MediaQuery.of(context).size.width;
  }

  bool _isBordered(BuildContext context) {
    return widget.type == ButtonType.bordered ? true : false;
  }



  void _handleTap() {
    setState(() {
      widget.onTap();
      if (widget.hasLoading) {
          _isLoading = true;
      }
    });

  }

  Widget _buildButtonContent() {
    final textColor = widget.enabled ? widget.textColor : AppColors.darkGray;
    final fontWeight = widget.isBold ? FontWeight.bold : FontWeight.normal;
    final text = Text(
      widget.text.tr(),
      style: AppStyles.title.copyWith(color: textColor, fontWeight: fontWeight),
    );
    if (widget.iconData != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          text,
          Width.v12,
          Icon(widget.iconData, color: textColor, size: 20,),
        ],
      );
    }
    return text;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _isLoading ? null : _handleTap,
      child: _isLoading ?
      Shimmer.fromColors(
        baseColor: widget.buttonColor,
        highlightColor: widget.buttonColor.withOpacity(0.8),
          child: Container(
            width: widget.width ?? _getButtonWidth(context),
            height: widget.height ?? AppSize.s55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSize.s10),
              color: widget.enabled ? widget.buttonColor : AppColors.midGray,
              border: _isBordered(context) ? Border.all(color: widget.buttonColor) : null
            ),
          )
      ) :
      Container(
        width: widget.width ?? _getButtonWidth(context),
        height: widget.height ?? AppSize.s55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.s10),
          color: widget.enabled ? widget.buttonColor : AppColors.midGray,
          border: _isBordered(context) ? Border.all(color: widget.textColor) : null

        ),
        child: Center(
          child: _buildButtonContent(),
        ),
      ),
    );
  }
}
