import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sup;
import 'package:credpaltest/core/util/app_constansts.dart';

ProviderListenable<sup.SupabaseClient> supabaseProvider({
  bool allowAdmin = false,
}) => Provider<sup.SupabaseClient>(
  (ref) => switch (allowAdmin) {
    false => sup.Supabase.instance.client,
    _ => sup.SupabaseClient(
      AppConsts.SUPABASE_PROJECT_URL,
      AppConsts.SUPABASE_SERVICE_ROLE_KEY,
    ),
  },
);

class UserSessionProvider
    extends StateNotifier<({sup.User? user, sup.Session? session})> {
  UserSessionProvider() : super((user: null, session: null));

  void updateUserSession(sup.User? user, sup.Session? session) {
    state = (user: user, session: session);
  }
}

final userSessionProvider = StateNotifierProvider<
  UserSessionProvider,
  ({sup.User? user, sup.Session? session})
>((ref) => UserSessionProvider());
