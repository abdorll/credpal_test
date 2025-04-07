import 'package:flutter/material.dart';
import 'package:credpaltest/core/widgets/spacing.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:credpaltest/feature/auth/presentation/create_account/create_acc_controller.dart';
import 'package:credpaltest/feature/auth/presentation/verify_account/verify_account.dart';
import 'package:credpaltest/core/widgets/app_button.dart';
import 'package:credpaltest/core/widgets/app_icon.dart';
import 'package:credpaltest/core/widgets/app_text.dart';
import 'package:credpaltest/core/widgets/app_text_field.dart';
import 'package:credpaltest/core/theme/app_theme.dart';
import 'package:credpaltest/core/util/extensions.dart';

class CreateAccount extends ConsumerStatefulWidget {
  static const String createAccount = '/createAccount';
  const CreateAccount({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateAccountState();
}

class _CreateAccountState extends ConsumerState<CreateAccount> {
  late TextEditingController _emailController,
      _passwordController,
      _confirmPasswordController;
  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.handleToast(
      context: context,
      provider: signupControllerProvider,
      onSuccess: () {
        context.showInfo("Check your message inbox for an OTP", context);
        context.pushNamed(
          VerifyAccountScreen.verifyAccountScreen,
          arguments: _emailController.text,
        );
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
              AppText("Create account", 30.sp, 8, align: TextAlign.left),
              YMargin(10.sp),
              AppText(
                "We will send a text with a verification link to your email address.",
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
              YMargin(15.sp),
              AppTextField(
                controller: _confirmPasswordController,
                hintText: "Confirm password",
                labelText: "Confirm password",
                isObscure: true,
                onChanged: (v) {
                  setState(() {});
                },
                inputType: TextInputType.text,
              ),

              YMargin(40.sp),
              switch (ref.watch(signupControllerProvider)) {
                AsyncLoading() => CircularProgressIndicator(),
                _ => AppButton(
                  onPressed: () {
                    ref
                        .read(signupControllerProvider.notifier)
                        .signup(
                          email: _emailController.text,
                          password: _passwordController.text,
                        );
                  },
                  text: "Signup",
                  buttonType:
                      _emailController.text.length >= 6 &&
                              (_passwordController.text ==
                                  _confirmPasswordController.text) &&
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
