import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:credpaltest/feature/auth/data/auth_repository.dart';

class ResendConfirmationLinkController extends StateNotifier<AsyncValue> {
  ResendConfirmationLinkController(this.ref) : super(AsyncValue.data(null));
  Ref ref;
  Future<void> resendConfirmationLink({required String email}) async {
    state = AsyncLoading();
    try {
      await ref
          .read(authRepositoryProvider)
          .resendConfirmationLink(email: email);
      state = AsyncData(null);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}

final resendConfirmationLinkControllerProvider =
    StateNotifierProvider<ResendConfirmationLinkController, AsyncValue>(
      (ref) => ResendConfirmationLinkController(ref),
    );




