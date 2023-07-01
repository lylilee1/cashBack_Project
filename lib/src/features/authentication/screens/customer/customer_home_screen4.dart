import 'package:carousel_slider/carousel_slider.dart';
import 'package:cashback/src/common_widgets/app_bar/appBarWidget.dart';
import 'package:cashback/src/constants/colors.dart';
import 'package:cashback/src/constants/image_strings.dart';
import 'package:cashback/src/constants/text_strings.dart';
import 'package:cashback/src/features/authentication/controllers/cart/cart_controller.dart';
import 'package:cashback/src/features/authentication/screens/customer/minor_screen/accessories_gallery_screen.dart';
import 'package:cashback/src/features/authentication/screens/customer/minor_screen/automoto_gallery_screen.dart';
import 'package:cashback/src/features/authentication/screens/customer/minor_screen/electronics_gallery_screen.dart';
import 'package:cashback/src/features/authentication/screens/customer/minor_screen/home&garden_gallery_screen.dart';
import 'package:cashback/src/features/authentication/screens/customer/minor_screen/kids_gallery_screen.dart';
import 'package:cashback/src/features/authentication/screens/customer/minor_screen/other_gallery_screen.dart';
import 'package:cashback/src/features/authentication/screens/customer/minor_screen/sport_gallery_screen.dart';
import 'package:cashback/src/features/authentication/screens/customer/minor_screen/women_gallery_screen.dart';
import 'package:cashback/src/features/authentication/screens/customer/minor_screen/men_gallery_screen.dart';
import 'package:cashback/src/features/authentication/screens/login/customer_signin_screen.dart';
import 'package:cashback/src/features/authentication/screens/search/search_screen.dart';
import 'package:cashback/src/features/authentication/screens/supplier/supplier_signin_screen2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';

import '../../../../constants/size_config.dart';
import '../cart/cart_screen3.dart';
import '../main/main_screen2.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({Key? key}) : super(key: key);
  static String routeName = '/customer_home';

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen>
    with SingleTickerProviderStateMixin {
  final List<AssetImage> _carouselImages = [
    AssetImage(CbImageStrings.cbC1),
    AssetImage(CbImageStrings.cbC2),
  ];

  late TabController tabController;
  int selectedValue = 0;
  int currentValueIndex = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 9, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      //app bar
      appBar: AppBar(
        //backgroundColor: CbColors.cbPrimaryColor2!.withOpacity(0.8),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: AppBarButton(
          prefixIcon: Icons.search,
          //iconColor: CbColors.cbWhiteColor,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SearchScreen()),
            );
          },
        ),
        title: const AppBarTitle(
          title: CbTextStrings.cbAppName,
          //iconColor: CbColors.cbWhiteColor,
        ),
        centerTitle: true,
        actions: [
          //user profile icon
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: CircleAvatar(
              child: _ProfileIcon(),
            ),
          ),

          //cart icon
          badges.Badge(
            showBadge: context.watch<Cart>().getitems.isEmpty ? false : true,
            position: badges.BadgePosition.topEnd(top: 0, end: 3),
            badgeContent: Text(
              context.watch<Cart>().getitems.length.toString(),
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                fontSize: 10,
                //color: CbColors.cbWhiteColor,
                color: CbColors.cbBlack,
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
                color: CbColors.cbBlack,
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

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
            ),
            child: Stack(
              children: [
                SafeArea(
                  top: true,
                  child: Column(
                    children: [
                      //Slider Images
                      CarouselSlider(
                        items: _carouselImages
                            .map((image) =>
                                Image(image: image, fit: BoxFit.cover))
                            .toList(),
                        options: CarouselOptions(
                          height: size.height * 0.2,
                          enlargeCenterPage: true,
                          autoPlay: true,
                          aspectRatio: 16 / 9,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enableInfiniteScroll: true,
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          viewportFraction: 0.8,
                        ),
                      ),

                      //Categories
                      Container(
                        child: TabBar(
                          isScrollable: true,
                          controller: tabController,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicatorColor: CbColors.cbPrimaryColor2,
                          indicatorWeight: 5,
                          tabs: const [
                            RepeatedTab(
                              label: 'Hommes',
                            ),
                            RepeatedTab(
                              label: 'Femmes',
                            ),
                            RepeatedTab(
                              label: 'Enfants',
                            ),
                            RepeatedTab(
                              label: 'Electroniques',
                            ),
                            RepeatedTab(
                              label: 'Accessoires',
                            ),
                            RepeatedTab(
                              label: 'Maison & Jardin',
                            ),
                            RepeatedTab(
                              label: 'Automobiles',
                            ),
                            RepeatedTab(
                              label: 'Sport & Loisirs',
                            ),
                            RepeatedTab(
                              label: 'Autres',
                            ),
                            /*Tab(
                child: Container(
                  width: double.infinity,
                  height: size.height * 0.05,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: selectedValue == 0 ? Colors.blue : Colors.grey.withOpacity(0.8),
                    //borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),*/
                          ],
                        ),
                      ),

                      //Categories Products
                      Container(
                        /*decoration: BoxDecoration(
                          color: CbColors.cbPrimaryColor2.withOpacity(0.05),  //CbColors.cbPrimaryColor2,Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(15),
                        ),*/
                        height: size.width + 40.0,
                        child: TabBarView(
                          controller: tabController,
                          children: const [
                            MenGalleryScreen(),
                            WomenGalleryScreen(),
                            KidsGalleryScreen(),
                            ElectronicsGalleryScreen(),
                            AccessoriesGalleryScreen(),
                            HomeGardenGalleryScreen(),
                            AutomotoGalleryScreen(),
                            SportGalleryScreen(),
                            OtherGalleryScreen(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RepeatedTab extends StatelessWidget {
  final String label;

  const RepeatedTab({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(
        label,
        style: TextStyle(color: Colors.grey.shade600),
      ),
    );
  }
}

final List<String> _menuItems = <String>[
  'Particulier',
  'Entreprise',
  'Sign Out',
];

enum Menu { itemOne, itemTwo, itemThree }

class _ProfileIcon extends StatelessWidget {
  const _ProfileIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Menu>(
      itemBuilder: (BuildContext context) {
        return _menuItems.map((String item) {
          Menu menu;
          switch (item) {
            case 'Particulier':
              menu = Menu.itemOne;
              break;
            case 'Entreprise':
              menu = Menu.itemTwo;
              break;
            case 'Sign Out':
              menu = Menu.itemThree;
              break;
            default:
              throw ArgumentError('Invalid menu item: $item');
          }
          return PopupMenuItem<Menu>(
            value: menu,
            child: Text(item),
          );
        }).toList();
      },
      icon: const Icon(
        FontAwesomeIcons.user,
        color: Colors.white,
      ),
      onSelected: (Menu result) async {
        switch (result) {
          case Menu.itemOne:
            Navigator.pushReplacementNamed(
                context, CustomerSignInScreen.routeName);
            //Navigator.push(context, MaterialPageRoute(builder: (context) => const CustomerSignInScreen()));
            break;
          case Menu.itemTwo:
            // navigate to screen for Entreprise
            Navigator.pushReplacementNamed(
                context, SupplierSignInScreen.routeName);
            //Navigator.push(context, MaterialPageRoute(builder: (context) => const SupplierSignInScreen()));
            break;
          case Menu.itemThree:
            // perform sign out action
            await FirebaseAuth.instance.signOut();
            //Navigator.pop(context);
            Navigator.pushReplacementNamed(context, MainScreen.routeName);
            break;
        }
      },
    );
  }
}
