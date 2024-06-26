import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  static const String route = '/account';
  static const String path = '/account';
  static const String name = 'Account Screen';
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account"),
      ),
      body: const SafeArea(
        child: Center(child: Text("Account Screen")),
      ),
    );
  }
}
