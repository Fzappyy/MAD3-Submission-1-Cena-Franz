import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const String route = '/home';
  static const String path = '/home';
  static const String name = 'Home Screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: const SafeArea(
          child: Center(
        child: Text("Home Screen"),
      )),
    );
  }
}
