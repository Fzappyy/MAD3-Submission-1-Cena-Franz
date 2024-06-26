import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mad3_submission_1/src/screens/account_screen.dart';
import 'package:mad3_submission_1/src/screens/home_screen.dart';
import 'package:mad3_submission_1/src/screens/home_wrapper.dart';

class GlobalRouter {
  late GoRouter router;
  late GlobalKey<NavigatorState> _rootNavigatorKey;
  late GlobalKey<NavigatorState> _shellNavigatorKey;

  GlobalRouter() {
    _rootNavigatorKey = GlobalKey<NavigatorState>();
    _shellNavigatorKey = GlobalKey<NavigatorState>();
    router = GoRouter(
        navigatorKey: _rootNavigatorKey,
        initialLocation: HomeScreen.route,
        routes: [
          ShellRoute(
            navigatorKey: _shellNavigatorKey,
            routes: [
              GoRoute(
                parentNavigatorKey: _shellNavigatorKey,
                path: HomeScreen.route,
                name: HomeScreen.name,
                builder: (context, state) {
                  return const HomeScreen();
                },
              ),
              GoRoute(
                parentNavigatorKey: _shellNavigatorKey,
                path: AccountScreen.route,
                name: AccountScreen.name,
                builder: (context, state) {
                  return const AccountScreen();
                },
              ),
            ],
            builder: (context, state, child) {
              return HomeWrapper(
                child: child,
              );
            },
          ),
          // GoRoute(
          //   parentNavigatorKey: _rootNavigatorKey,
          //   path: AccountScreen.route,
          //   name: AccountScreen.name,
          //   builder: (context, state) {
          //     return const AccountScreen();
          //   },
          // )
        ]);
  }
}
