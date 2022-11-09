import 'package:cashback/src/features/authentication/screens/onboarding/on_boarding_screen.dart';
import 'package:cashback/src/features/authentication/screens/welcome_screen/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CashBack',
      themeMode: ThemeMode.system,
      home: OnBoardingScreen(),
    );
  }
}
