import 'package:cashback/src/common_widgets/app_bar/appBarWidget.dart';
import 'package:cashback/src/constants/colors.dart';
import 'package:cashback/src/constants/image_strings.dart';
import 'package:cashback/src/constants/image_strings.dart';
import 'package:cashback/src/constants/image_strings.dart';
import 'package:cashback/src/constants/image_strings.dart';
import 'package:cashback/src/constants/text_strings.dart';
import 'package:cashback/src/features/authentication/screens/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../customer/customer_home_screen4.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({Key? key}) : super(key: key);
  static String routeName = '/wishlist';

  @override
  State<WishlistScreen> createState() => _WishlistScreen();
}

class _WishlistScreen extends State<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    return Scaffold(
      //app bar
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading:
        AppBarButton(prefixIcon: Icons.notifications, onTap: () {},),
        title: AppBarTitle(title: CbTextStrings.cbAppName,),
        centerTitle: true,
        actions: [
          AppBarButton(prefixIcon: Icons.search, onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SearchScreen()),
            );
          },),
          AppBarButton(prefixIcon: Icons.shopping_cart, onTap: () {},),
        ],
      ),
      body: SafeArea(
        child: Text('Wishlist'),
      ),
    );
  }
}
