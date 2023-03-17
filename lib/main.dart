
import 'package:cashback/firebase_options.dart';
import 'package:cashback/src/features/authentication/screens/customer/customer_home_screen4.dart';
import 'package:cashback/src/features/authentication/screens/login/login_screen.dart';
import 'package:cashback/src/features/authentication/screens/onboarding/on_boarding_screen.dart';
import 'package:cashback/src/features/authentication/screens/signup/signup_screen.dart';
import 'package:cashback/src/features/authentication/screens/signup/signup_screen2.dart';
import 'package:cashback/src/utils/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'src/features/authentication/screens/cart/cart_screen.dart';
import 'src/features/authentication/screens/category/category_screen2.dart';
import 'src/features/authentication/screens/dashboard/dashboard_screen.dart';
import 'src/features/authentication/screens/main/main_screen.dart';
import 'src/features/authentication/screens/profile/Profile_screen3.dart';
import 'src/features/authentication/screens/wishlist/wishlist_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //await Firebase.initializeApp();
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
      //initialRoute: OnBoardingScreen.routeName,
      initialRoute: CustomerSignUp.routeName,
      routes: {
        OnBoardingScreen.routeName: (context) => const OnBoardingScreen(),
        MainScreen.routeName: (context) => const MainScreen(),
        CategoryScreen.routeName: (context) => const CategoryScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        SignUpScreen.routeName: (context) => const SignUpScreen(),
        CustomerSignUp.routeName: (context) => const CustomerSignUp(),
        //ProfileScreen.routeName: (context) => const ProfileScreen(),
        ProfileScreen.routeName: (context) => const ProfileScreen(),
        CartScreen.routeName: (context) => const CartScreen(),
        WishlistScreen.routeName: (context) => const WishlistScreen(),
        CustomerHomeScreen.routeName: (context) => const CustomerHomeScreen(),
      },
    );
  }
}
