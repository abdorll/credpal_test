import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:credpaltest/core/widgets/app_text.dart';
import 'package:credpaltest/core/theme/app_theme.dart';
import 'package:credpaltest/core/util/app_exception.dart';
import 'package:toastification/toastification.dart';

extension NavigatorExtension on BuildContext {
  void pushNamed(String route, {Object? arguments}) {
    Navigator.pushNamed(this, route, arguments: arguments);
  }

  void pushNamedAndRemoveUntil(String route, {Object? arguments}) {
    Navigator.pushNamedAndRemoveUntil(
      this,
      route,
      (_) => false,
      arguments: arguments,
    );
  }

  pop() {
    Navigator.pop(this);
  }
}

extension ToastAlert on BuildContext {
  void showError(AppException error, BuildContext context) {
    final errorMessage = error.message;
    toastification.show(
      context: this,
      description: AppText(
        errorMessage,
        13.sp,
        5,
        color: AppTheme.colorScheme(context).primary,
      ),
      type: ToastificationType.error,
      autoCloseDuration: const Duration(seconds: 5),
      style:
          AppTheme.themeColor(context).brightness == Brightness.light
              ? ToastificationStyle.flatColored
              : ToastificationStyle.fillColored,
    );
  }

  void showSuccess(String message, BuildContext context) {
    toastification.show(
      context: this,
      title: AppText(
        "Success",
        18.sp,
        5,
        color: AppTheme.colorScheme(context).primary,
      ),
      description: AppText(
        message,
        13.sp,
        5,
        color: AppTheme.colorScheme(context).primary,
      ),
      type: ToastificationType.success,
      autoCloseDuration: const Duration(seconds: 5),
      style:
          AppTheme.themeColor(context).brightness == Brightness.light
              ? ToastificationStyle.flatColored
              : ToastificationStyle.fillColored,
    );
  }

  void showInfo(String message, BuildContext context) {
    toastification.show(
      context: this,
      description: AppText(
        message,
        13.sp,
        5,
        color: AppTheme.colorScheme(context).primary,
      ),
      type: ToastificationType.info,
      autoCloseDuration: const Duration(seconds: 5),
      style:
          AppTheme.themeColor(context).brightness == Brightness.light
              ? ToastificationStyle.flatColored
              : ToastificationStyle.fillColored,
    );
  }
}

extension HandleShowToast on WidgetRef {
  void handleToast({
    required BuildContext context,
    required ProviderListenable<AsyncValue> provider,
    VoidCallback? onSuccess,
    VoidCallback? onError,
  }) {
    WidgetRef ref = this;
    ref.listen(provider, (prev, next) {
      if (prev!.isLoading && !next.isLoading && next is AsyncData) {
        onSuccess?.call();
      } else if (prev.isLoading && !next.isLoading && next is AsyncError) {
        AppException exp = next.error as AppException;
        context.showError(exp, context);
        onError?.call();
      }
    });
  }
}
