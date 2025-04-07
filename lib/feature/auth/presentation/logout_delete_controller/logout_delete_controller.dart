import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:credpaltest/feature/auth/data/auth_repository.dart';

class LogoutController extends StateNotifier<AsyncValue> {
  LogoutController(this.ref) : super(AsyncData(null));
  Ref ref;
  Future<void> logout() async {
    state = AsyncLoading();
    try {
      await ref.read(authRepositoryProvider).logout();
      state = AsyncData(null);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}

final logoutControllerProvider =
    StateNotifierProvider<LogoutController, AsyncValue>(
      (ref) => LogoutController(ref),
    );

class DeleteAccountController extends StateNotifier<AsyncValue> {
  DeleteAccountController(this.ref) : super(AsyncData(null));
  Ref ref;
  Future<void> deleteAccount() async {
    state = AsyncLoading();
    try {
      await ref.read(authRepositoryProvider).deleteAccount(ref: ref);
      state = AsyncData(null);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}

final deleteAccountControllerProvider =
    StateNotifierProvider<DeleteAccountController, AsyncValue>(
      (ref) => DeleteAccountController(ref),
    );
