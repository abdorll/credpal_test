import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:credpaltest/core/util/supabase_provider.dart';
import 'package:credpaltest/core/util/app_exception.dart';

class AuthService {
  static Future<AuthResponse> service(
    Ref ref, {
    required Future<AuthResponse> authFunction,
  }) async {
    try {
      final res = await authFunction;
      ref
          .watch(userSessionProvider.notifier)
          .updateUserSession(res.user, res.session);
      return res;
    } on SocketException {
      throw Exception("No internet connection. Please check your network.");
    } on AuthApiException catch (e) {
      throw AppException(message: e.message, statusCode: e.statusCode!);
    } catch (e) {
      throw AppException(message: 'Some errors occured, try again!');
    }
  }
}
