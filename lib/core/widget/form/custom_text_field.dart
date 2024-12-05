import 'package:salon_reservation/core/constants/app_styles.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final bool autofocus;
  final bool enabled;
  final EdgeInsetsGeometry contentPadding;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldValidator<String>? validator;

  const CustomTextField({super.key,
    this.labelText,
    this.hintText,
    this.controller,
    this.keyboardType,
    this.textInputAction = TextInputAction.next,
    this.obscureText = false,
    this.autofocus = false,
    this.enabled = true,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.onChanged,
    this.validator, this.onEditingComplete, this.onFieldSubmitted, this.prefixIcon, this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        onFieldSubmitted: onFieldSubmitted,
        onEditingComplete: onEditingComplete,
        enabled: enabled,
        controller: controller,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        obscureText: obscureText,
        autofocus: autofocus,
        onChanged: onChanged,
        style: AppStyles.title,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          labelText: labelText,
          hintText: hintText,
          hintStyle: AppStyles.title,
          labelStyle: AppStyles.title,
          contentPadding: contentPadding,
          errorStyle: AppStyles.body,
          border: InputBorder.none,
        ),
        validator: validator,

      ),
    );
  }
}
