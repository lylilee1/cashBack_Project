import 'package:cashback/firebase_options.dart';
import 'package:cashback/src/features/authentication/controllers/cart/cart_controller.dart';
import 'package:cashback/src/features/authentication/controllers/wishlist/wishlist_controller.dart';
import 'package:cashback/src/features/authentication/screens/customer/customer_home_screen4.dart';
import 'package:cashback/src/features/authentication/screens/dashboard/dashboard_screen2.dart';
import 'package:cashback/src/features/authentication/screens/login/customer_signin_screen.dart';
import 'package:cashback/src/features/authentication/screens/onboarding/on_boarding_screen4.dart';
import 'package:cashback/src/features/authentication/screens/profile/profile_screen2.dart';
import 'package:cashback/src/features/authentication/screens/signup/customer_signup_screen.dart';
import 'package:cashback/src/features/authentication/screens/supplier/supplier_home_screen2.dart';
import 'package:cashback/src/features/authentication/screens/supplier/supplier_signin_screen2.dart';
import 'package:cashback/src/features/authentication/screens/supplier/supplier_signup_screen2.dart';
import 'package:cashback/src/utils/theme/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/features/authentication/screens/cart/cart_screen.dart';
import 'src/features/authentication/screens/category/category_screen2.dart';
import 'src/features/authentication/screens/main/main_screen.dart';
import 'src/features/authentication/screens/wishlist/wishlist_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProvider(create: (_) => Wish()),
      ],
      child: const MyApp(),
    ),
  );
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
      //initialRoute: DashboardScreen.routeName,
      initialRoute: OnBoardingScreen.routeName,
      routes: {
        OnBoardingScreen.routeName: (context) => const OnBoardingScreen(),
        DashboardScreen.routeName: (context) => const DashboardScreen(),
        MainScreen.routeName: (context) => const MainScreen(),
        CategoryScreen.routeName: (context) => const CategoryScreen(),
        ProfileScreen.routeName: (context) => ProfileScreen(
              documentId: FirebaseAuth.instance.currentUser!.uid,
            ),
        CartScreen.routeName: (context) => const CartScreen(),
        WishlistScreen.routeName: (context) => const WishlistScreen(),
        CustomerHomeScreen.routeName: (context) => const CustomerHomeScreen(),
        CustomerSignUpScreen.routeName: (context) =>
            const CustomerSignUpScreen(),
        CustomerSignInScreen.routeName: (context) =>
            const CustomerSignInScreen(),
        SupplierSignInScreen.routeName: (context) =>
            const SupplierSignInScreen(),
        SupplierSignUpScreen.routeName: (context) =>
            const SupplierSignUpScreen(),
        SupplierHomeScreen.routeName: (context) => const SupplierHomeScreen(),
      },
    );
  }
}
