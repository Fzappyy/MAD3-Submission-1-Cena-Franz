import 'package:flutter/material.dart';
import 'package:mad3_submission_1/src/controllers/auth_controller.dart';
import 'package:mad3_submission_1/src/dialogs/waiting_dialog.dart';
import 'package:mad3_submission_1/src/routing/router.dart';
import 'package:mad3_submission_1/src/screens/login_screen.dart';

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
      body: SafeArea(
        child: Center(
            child: ElevatedButton(
                onPressed: () => logoutUser(context),
                child: const Text("Log out"))),
      ),
    );
  }

  void logoutUser(BuildContext context) {
    WaitingDialog.show(
      context,
      future: AuthController.I.logout(),
      prompt: "Logging out. . .",
    ).then((value) {
      GlobalRouter.I.router.go(LoginScreen.route);
    }).catchError(
      (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Logout failed: $error')),
        );
      },
    );
  }
}
