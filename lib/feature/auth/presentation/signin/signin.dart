import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:credpaltest/feature/auth/presentation/signin/signin_controller.dart';
import 'package:credpaltest/feature/auth/presentation/verify_account/verify_acc_controller.dart';
import 'package:credpaltest/feature/auth/presentation/verify_account/verify_account.dart';
import 'package:credpaltest/core/widgets/app_button.dart';
import 'package:credpaltest/core/widgets/spacing.dart';
import 'package:credpaltest/core/widgets/app_icon.dart';
import 'package:credpaltest/core/widgets/app_text.dart';
import 'package:credpaltest/core/widgets/app_text_field.dart';
import 'package:credpaltest/core/theme/app_theme.dart';
import 'package:credpaltest/core/util/app_exception.dart';
import 'package:credpaltest/core/util/extensions.dart';

class SigninScreen extends ConsumerStatefulWidget {
  static const String signinScreen = '/signinScreen';
  const SigninScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SigninScreenState();
}

class _SigninScreenState extends ConsumerState<SigninScreen> {
  late TextEditingController _emailController, _passwordController;
  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.handleToast(
      context: context,
      provider: signinControllerProvider,
      onSuccess: () {
        context.showInfo("Signin successful", context);
      },
      onError: () {
        AppException exp =
            ref.read(signinControllerProvider).error as AppException;
        if (exp.message.toLowerCase() == 'email not confirmed') {
          ref
              .read(resendConfirmationLinkControllerProvider.notifier)
              .resendConfirmationLink(email: _emailController.text);
          context.pushNamed(
            VerifyAccountScreen.verifyAccountScreen,
            arguments: _emailController.text,
          );
        }
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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 10.sp),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText("Welcome Back!", 30.sp, 8, align: TextAlign.left),
              YMargin(10.sp),
              AppText(
                "Log in to continue exploring amazing features and stay connected!",
                19.sp,
                5,
                color: AppTheme.colorScheme(context).onSecondary,
                align: TextAlign.left,
              ),
              YMargin(45.sp),
              AppTextField(
                controller: _emailController,
                hintText: "Email",
                labelText: "Email",
                inputType: TextInputType.emailAddress,
              ),
              YMargin(15.sp),
              AppTextField(
                controller: _passwordController,
                hintText: "Password",
                isPassword: true,
                labelText: "Password",
                isObscure: isObscure,
                toggleObscurity: (value) {
                  setState(() {
                    isObscure = !isObscure;
                    value = isObscure;
                  });
                },
                onChanged: (v) {
                  setState(() {});
                },
                inputType: TextInputType.text,
              ),

              YMargin(40.sp),
              switch (ref.watch(signinControllerProvider)) {
                AsyncLoading() => CircularProgressIndicator(),
                _ => AppButton(
                  onPressed: () {
                    ref
                        .read(signinControllerProvider.notifier)
                        .signup(
                          email: _emailController.text,
                          password: _passwordController.text,
                        );
                  },
                  text: "SignIn",
                  buttonType:
                      _emailController.text.length >= 6 &&
                              _passwordController.text.length > 5
                          ? ButtonType.enabled
                          : ButtonType.disabled,
                ),
              },
            ],
          ),
        ),
      ),
    );
  }

  bool isObscure = true;
}
