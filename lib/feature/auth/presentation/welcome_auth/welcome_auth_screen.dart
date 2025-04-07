import 'package:credpaltest/feature/auth/presentation/logout_delete_controller/logout_delete_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:credpaltest/core/widgets/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:credpaltest/feature/auth/presentation/create_account/create_account.dart';
import 'package:credpaltest/feature/auth/presentation/signin/signin.dart';
import 'package:credpaltest/core/widgets/app_button.dart';
import 'package:credpaltest/core/widgets/logo_with_tagline.dart';
import 'package:credpaltest/core/theme/app_theme.dart';
import 'package:credpaltest/core/theme/colors.dart';
import 'package:credpaltest/core/util/extensions.dart';

class WelcomeAuthScreen extends ConsumerStatefulWidget {
  static const String welcomeAuthScreen = '/welcomeAuthScreen';
  const WelcomeAuthScreen({super.key});

  @override
  ConsumerState<WelcomeAuthScreen> createState() => _WelcomeAuthScreenState();
}

class _WelcomeAuthScreenState extends ConsumerState<WelcomeAuthScreen> {
  bool isVisible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        isVisible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.handleToast(
      context: context,
      provider: logoutControllerProvider,
      onSuccess: () {
        context.showSuccess("Logged out successfully", context);
      },
    );

    return Scaffold(
      backgroundColor:
          AppTheme.isDarkTheme(context)
              ? AppTheme.themeColor(context).scaffoldBackgroundColor
              : AppColors.primaryColorLite(context),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          YMargin(0.35.sh),
          LogoWithTagline(),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AnimatedSlide(
                  offset: isVisible ? Offset(0, 0) : Offset(0, 1),
                  duration: Duration(seconds: 2),
                  curve: Curves.easeOut,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 20.sp,
                      horizontal: 30.sp,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AppButton(
                          text: "Create Accobbunt",
                          buttonType: ButtonType.enabled,
                          onPressed: () {
                            context.pushNamed(CreateAccount.createAccount);
                          },
                        ),
                        YMargin(7.sp),
                        AppButton(
                          text: "Sign In",
                          buttonType: ButtonType.whiteEnabled,
                          onPressed: () {
                            context.pushNamed(SigninScreen.signinScreen);
                          },
                        ),
                        YMargin(7.sp),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.sp),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: "By tapping ",
                              style: AppTheme.textStyle(
                                context,
                                weight: 6,
                                fontSize: 14.sp,
                              ),
                              children: [
                                TextSpan(
                                  text: "\"Create account\" ",
                                  style: AppTheme.textStyle(
                                    context,
                                    weight: 8,
                                    fontSize: 14.sp,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: "or ",
                                      style: AppTheme.textStyle(
                                        context,
                                        weight: 6,
                                        fontSize: 14.sp,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: "\"Sign In\", ",
                                          style: AppTheme.textStyle(
                                            context,
                                            weight: 8,
                                            fontSize: 14.sp,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: ", you agree to our ",
                                              style: AppTheme.textStyle(
                                                context,
                                                weight: 6,
                                                fontSize: 14.sp,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: "Terms ",
                                                  style: AppTheme.textStyle(
                                                    context,
                                                    weight: 8,
                                                    textDecoration:
                                                        TextDecoration
                                                            .underline,
                                                    fontSize: 14.sp,
                                                  ),
                                                  children: [
                                                    TextSpan(
                                                      text: "& ",
                                                      style: AppTheme.textStyle(
                                                        context,
                                                        weight: 6,
                                                        fontSize: 14.sp,
                                                      ),
                                                      children: [
                                                        TextSpan(
                                                          text:
                                                              "Privacy Policy",
                                                          style: AppTheme.textStyle(
                                                            context,
                                                            weight: 6,
                                                            textDecoration:
                                                                TextDecoration
                                                                    .underline,
                                                            fontSize: 14.sp,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
