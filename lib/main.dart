import 'package:flutter/material.dart';
import 'package:mad3_submission_1/src/controllers/auth_controller.dart';
import 'package:mad3_submission_1/src/routing/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize AuthController and load session
  AuthController.initialize();
  await AuthController.instance.loadSession();

  // Initialize router after session is loaded
  GlobalRouter.initialize();

  // Run the app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: GlobalRouter.instance.router,
      debugShowCheckedModeBanner: false,
      title: 'MAD3 Submission 1 Cena Pueblos',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
