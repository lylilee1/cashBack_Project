import 'package:cashback/src/constants/colors.dart';
import 'package:cashback/src/constants/image_strings.dart';
import 'package:cashback/src/features/authentication/screens/category/category_screen2.dart';
import 'package:cashback/src/features/authentication/screens/customer/customer_home_screen.dart';
import 'package:cashback/src/features/authentication/screens/profile/Profile_screen3.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  static String routeName = '/main';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    PageController myPage = PageController(initialPage: _selectedIndex);

    final size = MediaQuery
        .of(context)
        .size;
    final height = MediaQuery
        .of(context)
        .size
        .height;
    final width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      //bottom navigation bar
      bottomNavigationBar: BottomAppBar(
        notchMargin: 5.0,
        shape: const CircularNotchedRectangle(),
        child: Container(
          width: width,
          height: height * 0.08,
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomBottomBar(
                onTap: () {
                  setState(
                        () {
                      _selectedIndex = 0;
                      myPage.jumpToPage(_selectedIndex);
                    },
                  );
                },
                title: 'Accueil',
                iconColor: _selectedIndex == 0
                    ? CbColors.cbPrimaryColor2
                    : CbColors.cbSecondaryColor,
                textColor: _selectedIndex == 0
                    ? CbColors.cbPrimaryColor2
                    : CbColors.cbSecondaryColor,
                iconData: Icons.home,
              ),
              CustomBottomBar(
                onTap: () {
                  setState(
                        () /* {
                      _selectedIndex = 1;
                      myPage.animateToPage(_selectedIndex,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease);
                    },*/ {
                      _selectedIndex = 1;
                      myPage.jumpToPage(_selectedIndex);
                    },
                  );
                },
                title: 'Categories',
                iconColor: _selectedIndex == 1
                    ? CbColors.cbPrimaryColor2
                    : CbColors.cbSecondaryColor,
                textColor: _selectedIndex == 1
                    ? CbColors.cbPrimaryColor2
                    : CbColors.cbSecondaryColor,
                iconData: Icons.search,
              ),
              /*
              CustomBottomBar(
                onTap: () {},
                title: 'Magasins',
                iconColor: CbColors.cbPrimaryColor2,
                textColor: CbColors.cbPrimaryColor2,
                iconData: Icons.shop_outlined,
              ),*/
              CustomBottomBar(
                onTap: () {
                  setState(
                        () {
                      _selectedIndex = 2;
                      myPage.jumpToPage(_selectedIndex);
                    },
                  );
                },
                title: 'Panier',
                iconColor: _selectedIndex == 2
                    ? CbColors.cbPrimaryColor2
                    : CbColors.cbSecondaryColor,
                textColor: _selectedIndex == 2
                    ? CbColors.cbPrimaryColor2
                    : CbColors.cbSecondaryColor,
                iconData: Icons.shopping_cart,
              ),
              //profile page button
              CustomBottomBar(
                onTap: () {
                  setState(
                        () {
                      _selectedIndex = 3;
                      myPage.jumpToPage(_selectedIndex);
                    },
                  );
                },
                title: 'Profile',
                iconColor: _selectedIndex == 3
                    ? CbColors.cbPrimaryColor2
                    : CbColors.cbSecondaryColor,
                textColor: _selectedIndex == 3
                    ? CbColors.cbPrimaryColor2
                    : CbColors.cbSecondaryColor,
                iconData: Icons.person,
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: PageView(
          controller: myPage,
          physics: const NeverScrollableScrollPhysics(),
          children: <Widget>[
            //pages
            CustomerHomeScreen(),
            CategoryScreen(),
            Center(
              child: Text('Panier'),
            ),
            //profile page
            ProfileScreen(),
          ],
        ),
      ),

      //middle floating button
      floatingActionButton: Container(
        height: 64,
        width: 64,
        padding: const EdgeInsets.all(4),
        margin: const EdgeInsets.only(top: 40),
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
            onPressed: () {},
            shape: const CircleBorder(),
            fillColor: const Color(0xff404c57),
            //child: SvgPicture.asset(CbImageStrings.cbIconPlus),
          ),
        ),
      ),

      //middle floating button
      /*floatingActionButton: SizedBox(
        height: height * 0.08,
        width: width * 0.16,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {},
            backgroundColor: CbColors.cbPrimaryColor2,
            child: const Icon(Icons.add),
          ),
        ),
      ),*/
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({Key? key,
    required this.onTap,
    required this.title,
    required this.iconColor,
    required this.textColor,
    required this.iconData})
      : super(key: key);
  final VoidCallback onTap;
  final String title;
  final Color iconColor;
  final Color textColor;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(iconData, color: iconColor),
          SizedBox(height: 5),
          Text(title,
              style: Theme
                  .of(context)
                  .textTheme
                  .subtitle2!
                  .copyWith(color: textColor)),
        ],
      ),
    );
  }
}
