import 'package:flutter/material.dart';
import 'package:mad3_submission_1/src/routing/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: GlobalRouter().router,
      debugShowCheckedModeBanner: false,
      title: 'MAD3 Submission 1 Cena Franz',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
