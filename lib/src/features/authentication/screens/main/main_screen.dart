import 'package:cashback/src/constants/colors.dart';
import 'package:cashback/src/constants/image_strings.dart';
import 'package:cashback/src/constants/text_strings.dart';
import 'package:cashback/src/features/authentication/screens/cart/cart_screen.dart';
import 'package:cashback/src/features/authentication/screens/category/category_screen2.dart';
import 'package:cashback/src/features/authentication/screens/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../customer/customer_home_screen4.dart';
import '../profile/profile_screen2.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  static String routeName = '/main';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _pages = [
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
    {
      'page': const CartScreen(),
      'title': 'cart Screen',
      'icon': const Icon(FontAwesomeIcons.cartShopping),
    },
    {
      'page': const ProfileScreen(),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: CbColors.cbPrimaryColor2,
        //mini: true,
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
    icon: Icon(Icons.shopping_bag_outlined),
    activeIcon: Icon(Icons.shopping_bag),
    label: 'Cart',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.person_outline_rounded),
    activeIcon: Icon(Icons.person_rounded),
    label: 'Profile',
  ),
];