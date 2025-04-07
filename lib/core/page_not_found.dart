import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:credpaltest/core/widgets/app_text.dart';

class PageNotFound extends StatelessWidget {
  static const String pageNotFound = "/pagenotfound";
  const PageNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: AppText("Page not found, restart app", 13.sp, 4)),
    );
  }
}
