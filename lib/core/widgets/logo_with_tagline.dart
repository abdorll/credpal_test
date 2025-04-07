import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:credpaltest/gen/assets.gen.dart';
import 'package:credpaltest/core/util/app_constansts.dart';
import 'package:credpaltest/core/widgets/app_text.dart';
import 'package:credpaltest/core/theme/app_theme.dart';

class LogoWithTagline extends StatefulWidget {
  const LogoWithTagline({super.key});

  @override
  State<LogoWithTagline> createState() => _LogoWithTaglineState();
}

class _LogoWithTaglineState extends State<LogoWithTagline> {
  final _duration = Duration(seconds: 3);

  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      isExpanded = true;
      setState(() {});
    });
    return AnimatedOpacity(
      opacity: isExpanded == false ? 0.25 : 1,
      curve: Curves.easeOut,
      duration: Duration(seconds: 4),
      child: SizedBox(
        width: null,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.sp, vertical: 10.sp),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(Assets.images.logo.path, height: 120.sp),
              AppAnimatedText(
                AppConsts.APP_NAME,
                isExpanded == false ? 17.sp : 40.sp,
                6,
                duration: _duration,
              ),
              AppAnimatedText(
                "Discover unbeatable deals on the latest tech and electronics—all in one place, right at your fingertips",
                isExpanded == false ? 10.sp : 17.5.sp,
                5,
                duration: _duration,
                color: AppTheme.colorScheme(context).onSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
