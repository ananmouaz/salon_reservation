import 'package:salon_reservation/core/validator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_strings.dart';
import 'custom_text_field.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField(
      {Key? key,
        required this.controller,
        this.hint,
        this.onFieldSubmitted, this.labelText, this.onChanged, this.isLast, this.labelWidget, this.prefixIcon, this.onEditingComplete})
      : super(key: key);

  final TextEditingController controller;
  final Function(String)? onFieldSubmitted;
  final void Function()? onEditingComplete;
  final Function(String)? onChanged;
  final String? hint;
  final String? labelText;
  final Widget? labelWidget;
  final bool? isLast;
  final IconData? prefixIcon;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool obscureText = true;

  IconData _getObscureIcon() {
    return obscureText ? Icons.visibility : Icons.visibility_off;
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      labelText: widget.labelText ?? AppStrings.passwordHint,
      onEditingComplete: widget.onEditingComplete,
      onFieldSubmitted: widget.onFieldSubmitted,
      prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon, color: AppColors.primary,) : null,
      //isLast: widget.isLast ?? true,
      onChanged: widget.onChanged ?? (value) {},
      suffixIcon: IconButton(
        onPressed: () {
          setState(() {
            obscureText = !obscureText;
          });
        },
        icon: Icon(
          _getObscureIcon(),
          color: AppColors.darkGray,
        ),
      ),
      validator: (value) => Validator.validatePassword(value ?? '', 'password'.tr()),
      hintText: widget.hint ?? AppStrings.passwordHint,
      controller: widget.controller,
      keyboardType: TextInputType.text,
      obscureText: obscureText,
    );
  }
}