import 'package:credpaltest/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AppColors {
  /// [SCAFFOLD COLOR THEMES]
  static Color darkScaffoldColor = Color.fromARGB(255, 1, 6, 24);
  static Color lightScaffoldColor = white;

  /// [BLACK AND WHITE]
  static const Color white = Color(0xffffffff);
  static const Color black = Color(0xff000000);
  static const Color darkBlue = Color(0xff20294A);

  /// [GREY COLORS]
  static const Color grey1 = Color(0xffD8D8D8);
  static const Color grey2 = Color(0xff9C9C9C);
  static const Color grey3 = Color(0xff6B6B6B);
  static Color grey4 = Colors.grey.shade800;

  /// [PRIMARY/SECONDARY COLOR VARIANTS]
  static const Color primaryColor = Color(0xff274FED);
  static Color primaryColorLite(BuildContext context) =>
      Color.lerp(primaryColor, AppTheme.colorScheme(context).onPrimary, 0.8)!;
  static Color primaryColorLite2(BuildContext context) =>
      Color.lerp(primaryColor, AppTheme.colorScheme(context).onPrimary, 0.95)!;
  static const Color secondaryColor = Color.fromARGB(255, 166, 178, 224);

  /// [GREEN COLORS]
  static const Color dgreen = Colors.green;
  static const Color green = Color(0xff24C78B);

  /// [YELLOW COLORS]
  static const Color yellow = Color(0xffFFCD29);

  /// [RED COLORS]
  static const Color red = Colors.red;
}
