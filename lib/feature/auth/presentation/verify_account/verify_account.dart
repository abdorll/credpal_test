import 'package:credpaltest/feature/auth/presentation/signin/signin.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:credpaltest/feature/auth/presentation/verify_account/verify_acc_controller.dart';
import 'package:credpaltest/core/widgets/app_button.dart';
import 'package:credpaltest/core/widgets/spacing.dart';
import 'package:credpaltest/core/widgets/app_icon.dart';
import 'package:credpaltest/core/widgets/app_text.dart';
import 'package:credpaltest/core/theme/app_theme.dart';
import 'package:credpaltest/core/util/extensions.dart';

class VerifyAccountScreen extends ConsumerStatefulWidget {
  static const String verifyAccountScreen = '/verifyAccountScreen';
  const VerifyAccountScreen({required this.emailNumber, super.key});
  final String emailNumber;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VerifyAccountScreenState();
}

class _VerifyAccountScreenState extends ConsumerState<VerifyAccountScreen> {
  int minute = 0, seconds = 0;

  Stream<String> timer() async* {
    while (minute < 1) {
      await Future.delayed(const Duration(seconds: 1));
      seconds++;

      if (seconds == 60) {
        minute++;
        seconds = 0;
      }

      yield "${zeroPrecedes(minute, 1)}:${zeroPrecedes(seconds, 1)}";
    }
  }

  String zeroPrecedes(int numb, int zeroCount) {
    return numb.toString().padLeft(zeroCount + 1, '0');
  }

  @override
  Widget build(BuildContext context) {
    ref.handleToast(
      context: context,
      provider: resendConfirmationLinkControllerProvider,
      onSuccess: () {
        context.showInfo("Check your Email inbox", context);
      },
    );
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: AppIcon(Icons.arrow_back_ios_rounded, size: 26.sp),
        ),
        backgroundColor: AppTheme.themeColor(context).scaffoldBackgroundColor,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: StreamBuilder<String>(
          stream: timer(),
          builder: (context, snapshot) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.sp,
                vertical: 10.sp,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    "Verify your account",
                    30.sp,
                    8,
                    align: TextAlign.left,
                  ),
                  YMargin(10.sp),
                  AppText(
                    "Enter the verification code sent to your Email",
                    19.sp,
                    5,
                    color: AppTheme.colorScheme(context).onSecondary,
                    align: TextAlign.left,
                  ),
                  YMargin(45.sp),
                  SizedBox(
                    width: double.infinity,
                    height: 62.sp,
                    child: AppText('Account created', 30.sp, 6),
                  ),
                  YMargin(25.sp),
                  switch (ref.watch(
                        resendConfirmationLinkControllerProvider,
                      )
                      is AsyncLoading) {
                    true => Row(
                      children: [
                        SizedBox.square(
                          dimension: 20.sp,
                          child: CircularProgressIndicator(),
                        ),
                        XMargin(10.sp),
                        AppText("Resending...", 15.sp, 5),
                      ],
                    ),
                    _ => RichText(
                      text: TextSpan(
                        text: "Didn’t get code ",
                        style: AppTheme.textStyle(
                          context,
                          fontSize: 15.sp,
                          weight: 5,
                          color: AppTheme.colorScheme(context).onSecondary,
                        ),
                        children: [
                          TextSpan(
                            text:
                                (snapshot.data ?? "").contains("1:")
                                    ? "Send again"
                                    : 'Resend in ${!snapshot.hasData ? "00:00" : snapshot.data!}',
                            recognizer:
                                TapGestureRecognizer()
                                  ..onTap = () {
                                    if ((snapshot.data ?? "").contains(
                                      "1:",
                                    )) {
                                      setState(() {
                                        minute = 0;
                                        seconds = 0;
                                      });
                                      ref
                                          .read(
                                            resendConfirmationLinkControllerProvider
                                                .notifier,
                                          )
                                          .resendConfirmationLink(
                                            email: widget.emailNumber,
                                          );
                                    }
                                  },
                            style: AppTheme.textStyle(
                              context,
                              weight: 7,
                              textDecoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  },
                  YMargin(30.sp),
                  AppButton(
                    onPressed: () {
                      context.pushNamedAndRemoveUntil(
                        SigninScreen.signinScreen,
                      );
                    },
                    text: "Yes, done",
                    buttonType: ButtonType.enabled,
                  ),
                  YMargin(10.sp),
                  AppButton(
                    onPressed: () {
                      context.pushNamedAndRemoveUntil(
                        SigninScreen.signinScreen,
                      );
                    },
                    text: "Later, close",
                    buttonType: ButtonType.whiteEnabled,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  bool isObscure = true;
}
