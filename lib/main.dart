import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:video_downloader/utils/sp_utils.dart';

import 'database/app_database.dart';
import 'route/app_pages.dart';
import 'theme/app_theme.dart';
import 'theme/theme_state.dart';

late AppDatabase db;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await SpUtils.init();
  db = AppDatabase();
  final deviceLocale = WidgetsBinding.instance.platformDispatcher.locale;
  final deviceLanguage = deviceLocale.languageCode;
  Locale defaultLocale;
  if (deviceLanguage == 'zh') {
    defaultLocale = const Locale('zh', 'CN');
  } else {
    defaultLocale = const Locale('en', 'US');
  }
  runApp(
    EasyLocalization(
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('zh', 'CN'),
        ],
        path: 'assets/translations',
        fallbackLocale: defaultLocale,
        child: ProviderScope(child: const MyApp())),
  );
  doWhenWindowReady(() {
    appWindow.title = "video_downloader".tr();
  });
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeNotifierProvider);
    return MaterialApp.router(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: whiteThemeData,
      darkTheme: blackThemeData,
      themeMode: themeState.themeMode,
      routerConfig: AppPages.routes,
    );
  }
}
