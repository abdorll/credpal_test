import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:credpaltest/core/util/app_constansts.dart';

class Utils {
  static Future initApp() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Hive.initFlutter();
    // final brightness =
    //     WidgetsBinding.instance.platformDispatcher.platformBrightness;

    // SystemChrome.setSystemUIOverlayStyle(switch (brightness) {
    //   Brightness.dark => AppTheme.darkThemeOverlay,
    //   _ => AppTheme.lightThemeOverlay,
    // });
    await Supabase.initialize(
      url: AppConsts.SUPABASE_PROJECT_URL,
      anonKey: AppConsts.SUPABSE_ANON_KEY,
    );
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    appCacheBox = await Hive.openBox(AppConsts.APP_CACHE_BOX);
  }

  static Box? appCacheBox;
}
