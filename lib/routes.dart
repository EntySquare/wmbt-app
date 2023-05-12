import 'package:flutter/widgets.dart';
import 'package:wmbt/widgets/home/home.dart';
import 'package:wmbt/widgets/login/login.dart';

enum Routes { splash, login, home }

class _Paths {
  static const String splash = '/';
  static const String home = '/home';
  static const String login = '/login';

  static const Map<Routes, String> _pathMap = {
    Routes.splash: _Paths.splash,
    Routes.login: _Paths.login,
    Routes.home: _Paths.home,
  };

  static String of(Routes route) => _pathMap[route] ?? splash;
}

//路由
class AppNavigator {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case _Paths.splash:
      //   return FadeRoute(page: SplashScreen());
      case _Paths.login:
        return FadeRoute(page: Login());

      case _Paths.home:
      default:
        return FadeRoute(page: Home());
    }
  }

  static Future? push<T>(Routes route, [T? arguments]) =>
      state?.pushNamed(_Paths.of(route), arguments: arguments);

  static Future? replaceWith<T>(Routes route, [T? arguments]) =>
      state?.pushReplacementNamed(_Paths.of(route), arguments: arguments);

  static void pop() => state?.pop();

  static NavigatorState? get state => navigatorKey.currentState;
}

class FadeRoute extends PageRouteBuilder {
  FadeRoute({required this.page})
      : super(
          pageBuilder: (_, __, ___) => page,
          transitionsBuilder: (_, animation, __, child) => FadeTransition(
            opacity: animation,
            child: child,
          ),
        );

  final Widget page;
}
