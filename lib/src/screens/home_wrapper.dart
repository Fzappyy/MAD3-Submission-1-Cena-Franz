import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mad3_submission_1/src/screens/account_screen.dart';
import 'package:mad3_submission_1/src/screens/home_screen.dart';

class HomeWrapper extends StatefulWidget {
  final Widget? child;
  const HomeWrapper({super.key, this.child});

  @override
  State<HomeWrapper> createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomeWrapper> {
  int index = 0;

  List<String> routes = [HomeScreen.route, AccountScreen.path];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child ?? const Placeholder(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (i) {
          setState(() {
            index = i;
            GoRouter.of(context).go(routes[i]);
          });
        },
        items: const [
          BottomNavigationBarItem(
              label: "Home",
              icon: Icon(
                Icons.home,
              )),
          BottomNavigationBarItem(
              label: "Account",
              icon: Icon(
                Icons.person,
              ))
        ],
      ),
    );
  }
}
