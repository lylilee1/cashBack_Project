import 'package:cashback/src/constants/colors.dart';
import 'package:cashback/src/features/authentication/screens/category/category_screen2.dart';
import 'package:cashback/src/features/authentication/screens/dashboard/screens/my_store_screen.dart';
import 'package:cashback/src/features/authentication/screens/supplier/upload_product_screen_walty.dart';
//import 'package:cashback/src/features/authentication/screens/supplier/upload_product_screen2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../customer/customer_home_screen4.dart';
import '../dashboard/dashboard_screen2.dart';


class SupplierHomeScreen extends StatefulWidget {
  const SupplierHomeScreen({Key? key}) : super(key: key);
  static String routeName = '/supplierHome';

  @override
  State<SupplierHomeScreen> createState() => _SupplierHomeScreenState();
}

class _SupplierHomeScreenState extends State<SupplierHomeScreen> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _pages = [
    {
      'page': const CustomerHomeScreen(),
      'title': 'Accueil',
      'icon': const Icon(FontAwesomeIcons.home),
    },
    {
      'page': const CategoryScreen(),
      'title': 'Categories',
      'icon': const Icon(FontAwesomeIcons.list),
    },
    {
      'page': const MyStoreScreen(),
      'title': 'Magasins',
      'icon': const Icon(FontAwesomeIcons.list),
    },
    {
      'page': const DashboardScreen(),
      'title': 'Dashboard',
      'icon': const Icon(FontAwesomeIcons.dashboard),
    },
    {
      'page': const UploadProductScreen(),
      //'page': ManageProductsScreen(documentId: FirebaseAuth.instance.currentUser!.uid,),
      'title': 'Chargement',
      'icon': Svg,
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
    icon: Icon(Icons.store_outlined),
    activeIcon: Icon(Icons.store_rounded),
    label: 'Magasin',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.dashboard_customize_outlined),
    activeIcon: Icon(Icons.dashboard_customize_rounded),
    label: 'Dashboard',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.upload_outlined),
    activeIcon: Icon(Icons.upload_rounded),
    label: 'Profile',
  ),
];
