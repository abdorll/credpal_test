import 'package:flutter/material.dart';
import 'package:credpaltest/core/theme/app_theme.dart';

class AppIcon extends StatelessWidget {
  const AppIcon(this.icon, {this.size, this.color, super.key});
  final IconData icon;
  final double? size;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: size ?? 20,
      color: color ?? AppTheme.colorScheme(context).primary,
    );
  }
}
