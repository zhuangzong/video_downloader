
import 'package:go_router/go_router.dart';

import '../pages/add_download/add_download_page.dart';
import '../pages/home/home_page.dart';
import '../pages/login/login_page.dart';
import '../pages/settings/setting_page.dart';

part 'app_routes.dart';

DateTime? lastPressedTime;

abstract class AppPages {
  static final routes = GoRouter(
    initialLocation: Routes.home,
    routes: [
      GoRoute(
        path: Routes.login,
        builder: (context, state) => LoginPage(),
      ),
      GoRoute(
        path: Routes.home,
        builder: (context, state) => HomePage(),
      ),
      GoRoute(
        path: Routes.settings,
        builder: (context, state) => SettingPage(),
      ),
      GoRoute(
        path: Routes.addDownload,
        builder: (context, state) => AddDownloadPage(),
      ),
    ],
  );
}
