import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:credpaltest/core/widgets/app_text.dart';
import 'package:credpaltest/core/theme/app_theme.dart';
import 'package:credpaltest/core/theme/colors.dart';

enum ButtonType { whiteEnabled, enabled, disabled }

class AppButton extends StatefulWidget {
  const AppButton({
    this.text,
    this.child,
    this.color,
    this.radius,
    this.fixedSize,
    this.onPressed,
    this.buttonType,
    super.key,
  });
  final Widget? child;
  final String? text;
  final Color? color;
  final double? radius;
  final Size? fixedSize;
  final ButtonType? buttonType;
  final VoidCallback? onPressed;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  Color _resolveButtonColor() {
    if (widget.buttonType == ButtonType.enabled) {
      return widget.color ?? AppColors.primaryColor;
    } else if (widget.buttonType == ButtonType.whiteEnabled) {
      return AppTheme.colorScheme(context).primary == AppColors.black
          ? AppColors.white
          : AppColors.grey1.withValues(alpha: 0.075);
    } else {
      return AppColors.primaryColor;
    }
  }

  Color _resolveButtonBorderColor() {
    if (widget.buttonType == ButtonType.disabled || widget.buttonType == null) {
      return AppColors.secondaryColor;
    } else {
      return widget.color ?? AppColors.primaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        disabledBackgroundColor: AppColors.secondaryColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: _resolveButtonBorderColor()),
          borderRadius: BorderRadius.circular(widget.radius ?? 15.r),
        ),
        fixedSize:
            widget.fixedSize ?? Size(MediaQuery.of(context).size.width, 56.sp),
        backgroundColor: _resolveButtonColor(),
      ),
      onPressed:
          (widget.buttonType == ButtonType.disabled ||
                  widget.buttonType == null)
              ? null
              : widget.onPressed,
      child:
          widget.child ??
          AppText(
            widget.text!,
            15.sp,
            7,
            color:
                widget.buttonType == ButtonType.whiteEnabled
                    ? widget.color ?? AppColors.primaryColor
                    : AppColors.white,
            textOverflow: TextOverflow.ellipsis,
          ),
    );
  }
}
