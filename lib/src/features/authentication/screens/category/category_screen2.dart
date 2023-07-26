import 'package:cashback/src/common_widgets/app_bar/appBarWidget.dart';
import 'package:cashback/src/constants/app_styles.dart';
import 'package:cashback/src/constants/colors.dart';
import 'package:cashback/src/constants/text_strings.dart';
import 'package:cashback/src/features/authentication/screens/category/widgets/kids_categ.dart';
import 'package:cashback/src/features/authentication/screens/category/widgets/men_categ.dart';
import 'package:cashback/src/features/authentication/screens/category/widgets/women_categ.dart';
import 'package:cashback/src/features/authentication/screens/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

import '../../../../constants/size_config.dart';
import '../../controllers/cart/cart_controller.dart';
import '../cart/cart_screen3.dart';

List<ItemsData> items = [
  ItemsData(label: 'men'),
  ItemsData(label: 'women'),
  ItemsData(label: 'kids'),
  ItemsData(label: 'electronics'),
  ItemsData(label: 'accessories'),
  ItemsData(label: 'home & garden'),
  ItemsData(label: 'sports'),
  ItemsData(label: 'automobile'),
];

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);
  static String routeName = '/category';

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    for (var element in items) {
      element.isSelected = false;
    }
    setState(() {
      items[0].isSelected = true;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    SizeConfig().init(context);

    return Scaffold(
      //app bar
      appBar: AppBar(
        elevation: 0,
        backgroundColor: CbColors.cbPrimaryColor2,
        leading: AppBarButton(
          prefixIcon: Icons.search,
          iconColor: CbColors.cbWhiteColor,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SearchScreen()),
            );
          },
        ),
        title: const AppBarTitle(
          title: 'Catégories',
          iconColor: CbColors.cbWhiteColor,
        ),
        centerTitle: true,
        actions: [
          //cart icon
          badges.Badge(
            showBadge: context.watch<Cart>().getitems.isEmpty ? false : true,
            position: badges.BadgePosition.topEnd(top: 0, end: 3),
            badgeContent: Text(
              context.watch<Cart>().getitems.length.toString(),
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontSize: 10,
                    color: CbColors.cbWhiteColor,
                  ),
            ),
            badgeAnimation: const badges.BadgeAnimation.rotation(
              animationDuration: Duration(seconds: 1),
              colorChangeAnimationDuration: Duration(seconds: 1),
              loopAnimation: false,
              curve: Curves.fastOutSlowIn,
              colorChangeAnimationCurve: Curves.easeInCubic,
            ),
            child: IconButton(
              icon: const Icon(
                Icons.shopping_bag_outlined,
                //color: CbColors.cbWhiteColor,
                color: CbColors.cbWhiteColor,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CartScreen()),
                );
              },
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            child: sideNavigator(size),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: categView(size),
          ),
        ],
      ),
    );
  }

  //sideNavigator left
  Widget sideNavigator(Size size) {
    return SizedBox(
      height: size.height * 0.85,
      width: size.width * 0.2,
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              //_pageController.jumpToPage(index);
              _pageController.animateToPage(index,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.bounceIn);
              /*for (var element in items) {
                element.isSelected = false;
              }
              setState(() {
                items[index].isSelected = true;
              });*/
            },
            child: Container(
              color: items[index].isSelected == true
                  ? Colors.white //Colors.green.shade300
                  : Colors.green.shade100, //lightBlueAccent.shade100
              height: 100,
              child: Center(
                child: Text(
                  items[index].label,
                  style: items[index].isSelected == true
                      ? cbMontserratBold.copyWith(
                          color: Colors.black,
                          fontSize: SizeConfig.blockSizeHorizontal! * 3,
                        )
                      : cbMontserratRegular.copyWith(
                          color: Colors.black,
                          fontSize: SizeConfig.blockSizeHorizontal! * 3,
                        ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  //category view right
  Widget categView(Size size) {
    return Container(
      height: size.height * 0.85,
      width: size.width * 0.8,
      color: Colors.white, //CbColors.cbPrimaryColor3,
      child: PageView(
        controller: _pageController,
        onPageChanged: (value) {
          for (var element in items) {
            element.isSelected = false;
          }
          setState(() {
            items[value].isSelected = true;
          });
        },
        scrollDirection: Axis.vertical,
        children: [
          MenCategory(),
          WomenCategory(),
          KidsCategory(),
          Center(
            child: Text(
              '4 category',
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
          Center(
            child: Text(
              '5 category',
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
          Center(
            child: Text(
              '6 category',
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
          Center(
            child: Text(
              '7 category',
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
          Center(
            child: Text(
              '8 category',
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
        ],
      ),
    );
  }
}

class ItemsData {
  String label;
  bool isSelected;

  ItemsData({
    required this.label,
    this.isSelected = false,
  });
}
