// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:credpaltest/core/widgets/app_icon.dart';
import 'package:credpaltest/core/theme/app_theme.dart';
import 'package:credpaltest/core/theme/colors.dart';

class AppTextField extends StatefulWidget {
  AppTextField({
    this.hintText,
    this.onChanged,
    this.isPassword = false,
    required this.controller,
    this.suffixIcon,
    this.radius,
    this.isObscure = false,
    this.labelText,
    this.prefixIcon,
    this.toggleObscurity,
    this.inputType = TextInputType.text,
    super.key,
  });
  final String? hintText, labelText;
  final double? radius;
  final TextInputType inputType;
  final TextEditingController? controller;
  final Widget? suffixIcon, prefixIcon;
  final bool isPassword;
  final void Function(bool isObscure)? toggleObscurity;
  final void Function(String?)? onChanged;
  bool isObscure;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    var iconConstraints = BoxConstraints(
      maxHeight: 37.5.sp,
      maxWidth: 45.sp,
      minHeight: 24.5.sp,
      minWidth: 35.sp,
    );
    return TextFormField(
      onChanged: widget.onChanged,
      controller: widget.controller,
      cursorColor: AppColors.primaryColor,
      keyboardType: widget.inputType,
      obscureText: widget.isObscure,
      style: AppTheme.textStyle(
        context,
        weight: 6,
        fontSize: 15.sp,
        textDecoration: TextDecoration.none,
      ),
      decoration: InputDecoration(
        fillColor: AppColors.primaryColorLite2(context),
        filled: true,
        contentPadding: EdgeInsets.symmetric(
          vertical: 10.sp,
          horizontal: 15.sp,
        ),
        labelText: widget.labelText,
        labelStyle: AppTheme.textStyle(
          context,
          color:
              AppTheme.isDarkTheme(context) ? AppColors.grey1 : AppColors.grey3,
          weight: 5,
          fontSize: 15.sp,
        ),
        hintText: widget.hintText,
        hintStyle: AppTheme.textStyle(
          context,
          color:
              AppTheme.isDarkTheme(context) ? AppColors.grey1 : AppColors.grey3,
          weight: 3,
          fontSize: 13.sp,
        ),
        prefixIcon: widget.prefixIcon,
        prefixIconConstraints: BoxConstraints(
          maxHeight: 37.5.sp,
          maxWidth: 60.sp,
          minHeight: 24.5.sp,
          minWidth: 50.sp,
        ),
        suffixIcon:
            widget.isPassword == true
                ? IconButton(
                  onPressed: () {
                    widget.toggleObscurity!(widget.isObscure);
                  },
                  icon: AppIcon(
                    widget.isObscure == true
                        ? Icons.visibility
                        : Icons.visibility_off_rounded,
                  ),
                )
                : null,
        suffixIconConstraints: iconConstraints,

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.radius ?? 100.r),
          borderSide: BorderSide(
            width: 2,
            color: AppColors.primaryColorLite2(context),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.radius ?? 100.r),
          borderSide: BorderSide(width: 2, color: AppColors.primaryColor),
        ),
      ),
    );
  }
}
