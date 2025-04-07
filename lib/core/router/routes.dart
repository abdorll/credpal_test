import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:credpaltest/feature/auth/presentation/create_account/create_account.dart';
import 'package:credpaltest/feature/auth/presentation/signin/signin.dart';
import 'package:credpaltest/feature/auth/presentation/verify_account/verify_account.dart';
import 'package:credpaltest/feature/auth/presentation/welcome_auth/welcome_auth_screen.dart';
import 'package:credpaltest/core/theme/change_theme.dart';
import 'package:credpaltest/feature/home/presentation/home_page/home_page.dart';
import 'package:credpaltest/core/page_not_found.dart';

class AppRoutes {
  static Route onGenerateRoute(RouteSettings settings) {
    var argument = settings.arguments;
    return switch (settings.name) {
      WelcomeAuthScreen.welcomeAuthScreen => screenOf(
        screenName: WelcomeAuthScreen(),
      ),
      SigninScreen.signinScreen => screenOf(screenName: const SigninScreen()),
      CreateAccount.createAccount => screenOf(screenName: CreateAccount()),
      HomePage.homePage => screenOf(screenName: HomePage()),
      VerifyAccountScreen.verifyAccountScreen => screenOf(
        screenName: VerifyAccountScreen(emailNumber: argument as String),
      ),
      ChangeThemeScreen.changeThemeScreen => screenOf(
        screenName: ChangeThemeScreen(),
      ),
      _ => screenOf(screenName: PageNotFound()),
    };
  }
}

PageRoute screenOf({required Widget screenName}) {
  return switch (Platform.isIOS) {
    true => CupertinoPageRoute(builder: (context) => screenName),
    _ => MaterialPageRoute(builder: (context) => screenName),
  };
}
