import 'package:cashback/src/common_widgets/app_bar/appBarWidget.dart';
import 'package:cashback/src/constants/colors.dart';
import 'package:cashback/src/constants/image_strings.dart';
import 'package:cashback/src/constants/text_strings.dart';
import 'package:cashback/src/features/authentication/screens/customer/customer_orders.dart';
import 'package:cashback/src/features/authentication/screens/main/main_screen2.dart';
import 'package:cashback/src/features/authentication/screens/search/search_screen.dart';
import 'package:cashback/src/features/authentication/screens/wishlist/wishlist_screen.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  static String routeName = '/profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    return Scaffold(
      //app bar
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: AppBarButton(
          prefixIcon: Icons.notifications,
          onTap: () {},
        ),
        title: AppBarTitle(
          title: CbTextStrings.cbAppName,
        ),
        centerTitle: true,
        actions: [
          AppBarButton(
            prefixIcon: Icons.search,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchScreen()),
              );
            },
          ),
          AppBarButton(
            prefixIcon: Icons.shopping_cart,
            onTap: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Center(
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage: AssetImage(
                    'assets/images/user_images/user.gif',
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text('Elvis NDONG ESSONO'),
              Text('superAdmin@cashback.com'),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),

      ),
    );
  }
}
