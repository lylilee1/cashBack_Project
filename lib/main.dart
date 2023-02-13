
import 'package:cashback/src/features/authentication/screens/login/login_screen.dart';
import 'package:cashback/src/features/authentication/screens/onboarding/on_boarding_screen.dart';
import 'package:cashback/src/features/authentication/screens/signup/signup_screen.dart';
import 'package:cashback/src/utils/theme/theme.dart';
import 'package:flutter/material.dart';

import 'src/features/authentication/screens/dashboard/dashboard_screen.dart';
import 'src/features/authentication/screens/main/main_screen.dart';
import 'src/features/authentication/screens/profile/profile_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CashBack',
      themeMode: ThemeMode.system,
      theme: CbAppTheme.lightTheme,
      darkTheme: CbAppTheme.darkTheme,
      initialRoute: OnBoardingScreen.routeName,
      routes: {
        OnBoardingScreen.routeName: (context) => const OnBoardingScreen(),
        MainScreen.routeName: (context) => const MainScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        SignUpScreen.routeName: (context) => const SignUpScreen(),
        ProfileScreen.routeName: (context) => const ProfileScreen(),
      },
    );
  }
}
