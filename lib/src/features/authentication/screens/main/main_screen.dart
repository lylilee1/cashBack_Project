import 'package:cashback/src/constants/app_styles.dart';
import 'package:cashback/src/constants/colors.dart';
import 'package:cashback/src/constants/image_strings.dart';
import 'package:cashback/src/features/authentication/screens/cart/cart_screen.dart';
import 'package:cashback/src/features/authentication/screens/category/category_screen2.dart';
import 'package:cashback/src/features/authentication/screens/search/search_screen.dart';
import 'package:cashback/src/features/authentication/screens/wishlist/wishlist_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../constants/size_config.dart';
import '../customer/customer_home_screen4.dart';
import '../forget_password/forget_password_options/forget_password_btn_widget.dart';
import '../profile/profile_screen6.dart';
//import '../profile/profile_screen2.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  static String routeName = '/main';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _pages = [
    //CustomerHomeScreen
    {
      'page': const CustomerHomeScreen(),
      'title': 'Home Screen',
      'icon': const Icon(FontAwesomeIcons.home),
    },
    {
      'page': const CategoryScreen(),
      'title': 'Category Screen',
      'icon': const Icon(FontAwesomeIcons.list),
    },
    //WishlistScreen
    {
      'page': const WishlistScreen(),
      'title': 'wishlist Screen',
      'icon': const Icon(FontAwesomeIcons.heartCircleCheck),
    },
    //ProfileScreen
    {
      'page': ProfileScreen(
        documentId: FirebaseAuth.instance.currentUser!.uid,
      ),
      'title': 'profile Screen',
      'icon': const Icon(FontAwesomeIcons.user),
    },
  ];

  void _selectedPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      //backgroundColor: Color(0xFFF3F6FF),
      /*
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: CbColors.cbPrimaryColor2,
        //mini: true,
      ),*/

      floatingActionButton: Container(
        height: 64,
        width: 64,
        padding: const EdgeInsets.all(4),
        //margin: const EdgeInsets.only(top: 40),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              CbColors.cbPrimaryColor2.withOpacity(0.2),
              CbColors.cbPrimaryColor3.withOpacity(0.2)
            ],
          ),
        ),
        child: Container(
          height: 60,
          width: 60,
          padding: const EdgeInsets.all(4),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                CbColors.cbPrimaryColor2,
                CbColors.cbPrimaryColor3,
              ],
            ),
          ),
          child: RawMaterialButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                builder: (context) => Container(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Connexion / Inscription',
                        style: cbMontserratBold.copyWith(
                          fontSize: SizeConfig.blockSizeHorizontal! * 5,
                        ),
                      ),
                      Text(
                        'Connecter-vous ou créer un compte',
                        style: cbMontserratRegular.copyWith(
                          fontSize: SizeConfig.blockSizeHorizontal! * 3.5,
                        ),
                      ),
                      const SizedBox(
                        height: SizeConfig.kPadding32,
                      ),

                      // -- Customer SignIn Screen Btn --
                      ForgetPasswordBtnWidget(
                        btnIcon: Icons.account_circle_sharp,
                        title: 'Particulier',
                        subTitle: 'Saisissez votre identifiant',
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, '/CustomerSignIn');
                        },
                      ),
                      const SizedBox(
                        height: SizeConfig.kPadding24,
                      ),

                      // -- Supplier SingIn Screen Btn --
                      ForgetPasswordBtnWidget(
                        btnIcon: Icons.supervised_user_circle_sharp,
                        title: 'Entreprise',
                        subTitle: 'Saisissez votre identifiant',
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, '/SupplierSignIn');
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
            shape: const CircleBorder(),
            fillColor: const Color(0xff404c57),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: SvgPicture.asset(CbImageStrings.cbIconPlus),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      body: _pages[_selectedIndex]['page'],

      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          selectedItemColor: CbColors.cbPrimaryColor2,
          unselectedItemColor: const Color(0xff757575),
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: _selectedPage,
          items: _navBarItems),
    );
  }
}

const _navBarItems = [
  BottomNavigationBarItem(
    icon: Icon(Icons.home_outlined),
    activeIcon: Icon(Icons.home_rounded),
    label: 'Home',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.category_outlined),
    activeIcon: Icon(Icons.category_rounded),
    label: 'Categories',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.favorite_outline),
    activeIcon: Icon(Icons.favorite_border_rounded),
    label: 'Wishlist',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.person_outline_rounded),
    activeIcon: Icon(Icons.person_rounded),
    label: 'Profile',
  ),
];
