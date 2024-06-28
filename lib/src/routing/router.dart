import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:mad3_submission_1/src/controllers/auth_controller.dart';
import 'package:mad3_submission_1/src/enum/enum.dart';
import 'package:mad3_submission_1/src/screens/account_screen.dart';
import 'package:mad3_submission_1/src/screens/home_screen.dart';
import 'package:mad3_submission_1/src/screens/home_wrapper.dart';
import 'package:mad3_submission_1/src/screens/login_screen.dart';

class GlobalRouter {
  static void initialize() {
    GetIt.instance.registerSingleton<GlobalRouter>(GlobalRouter());
  }

  static GlobalRouter get instance => GetIt.instance<GlobalRouter>();

  static GlobalRouter get I => GetIt.instance<GlobalRouter>();

  late GoRouter router;
  late GlobalKey<NavigatorState> _rootNavigatorKey;
  late GlobalKey<NavigatorState> _shellNavigatorKey;

  GlobalRouter() {
    _rootNavigatorKey = GlobalKey<NavigatorState>();
    _shellNavigatorKey = GlobalKey<NavigatorState>();
    router = GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: LoginScreen.route,
      redirect: handleRedirect,
      refreshListenable: AuthController.instance,
      routes: [
        GoRoute(
          path: LoginScreen.route,
          builder: (context, state) {
            return const LoginScreen();
          },
        ),
        ShellRoute(
          navigatorKey: _shellNavigatorKey,
          routes: [
            GoRoute(
              path: HomeScreen.route,
              builder: (context, state) {
                return const HomeScreen();
              },
            ),
            GoRoute(
              path: AccountScreen.route,
              builder: (context, state) {
                return const AccountScreen();
              },
            ),
          ],
          builder: (context, state, child) {
            if (AuthController.instance.state == AuthState.authenticated) {
              return HomeWrapper(
                child: child,
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }

  Future<String?> handleRedirect(
      BuildContext context, GoRouterState state) async {
    if (AuthController.instance.state == AuthState.authenticated) {
      if (state.matchedLocation == LoginScreen.route) {
        return HomeScreen.route;
      }
      return null;
    } else {
      if (state.matchedLocation == LoginScreen.route) {
        return null;
      }
      return LoginScreen.route;
    }
  }
}
