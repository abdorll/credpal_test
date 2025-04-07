import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:credpaltest/feature/auth/presentation/welcome_auth/welcome_auth_screen.dart';
import 'package:credpaltest/feature/home/presentation/home_page/home_page.dart';
import 'package:credpaltest/core/util/extensions.dart';

final navigatorKeyProvider = Provider<GlobalKey<NavigatorState>>((ref) {
  return GlobalKey<NavigatorState>();
});

class AuthStateNavObserver extends NavigatorObserver {
  late final StreamSubscription authSubscription;
  final WidgetRef ref;
  AuthStateNavObserver(this.ref);

  void listen() {
    final context = ref.watch(navigatorKeyProvider).currentContext;
    authSubscription = Supabase.instance.client.auth.onAuthStateChange.listen((
      data,
    ) {
      final AuthChangeEvent event = data.event;
      final Session? session = data.session;
      debugPrint('Auth event: $event, session: $session');

      if (context != null && context.mounted) {
        switch (event) {
          case AuthChangeEvent.initialSession:
            context.pushNamedAndRemoveUntil(
              WelcomeAuthScreen.welcomeAuthScreen,
            );
            break;
          case AuthChangeEvent.signedIn:
            context.pushNamedAndRemoveUntil(HomePage.homePage);
            break;
          case AuthChangeEvent.signedOut:
            context.pushNamedAndRemoveUntil(
              WelcomeAuthScreen.welcomeAuthScreen,
            );
            break;
          case AuthChangeEvent.mfaChallengeVerified:
            context.showSuccess("MFA Challenge Verified", context);
            break;
          case AuthChangeEvent.tokenRefreshed:
            context.showSuccess("Token Refreshed", context);
            break;
          case AuthChangeEvent.userUpdated:
            context.showSuccess("Your profile has been updated", context);
            break;
          case AuthChangeEvent.passwordRecovery:
            context.showSuccess("Password recovery event triggered", context);
            break;
          default:
            break;
        }
      }
    });
  }

  void disposeObserver() {
    authSubscription.cancel();
  }
}
