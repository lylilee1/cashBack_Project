import 'package:carousel_slider/carousel_slider.dart';
import 'package:cashback/src/common_widgets/app_bar/appBarWidget.dart';
import 'package:cashback/src/constants/colors.dart';
import 'package:cashback/src/constants/image_strings.dart';
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
import 'package:cashback/src/features/authentication/screens/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';

import '../../../../constants/app_styles.dart';
import '../../../../constants/size_config.dart';
import '../cart/cart_screen3.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({Key? key}) : super(key: key);
  static String routeName = '/customer_home';

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen>
    with SingleTickerProviderStateMixin {
  final List<AssetImage> _carouselImages = [
    const AssetImage(CbImageStrings.cbC1),
    const AssetImage(CbImageStrings.cbC2),
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
          iconColor: CbColors.cbBlack,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SearchScreen()),
            );
          },
        ),
        title: const AppBarTitle(
          title: 'CASHBACK',
        ),
        centerTitle: true,
        actions: [
          //user profile icon
          const Padding(
            padding: EdgeInsets.only(
              bottom: 5,
            ),
            child: Icon(
              Icons.person_outline_rounded,
              color: CbColors.cbBlack,
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
                  child: Column(
                    children: [
                      //show real value and attrack customers
                      Container(
                        width: double.infinity,
                        height: size.height * 0.03,
                        decoration: const BoxDecoration(
                          color: CbColors.cbPrimaryColor2,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Livraison 48h/72h offerte dès 165000 fcfa d\'achat'
                                  .toUpperCase(),
                              style: cbMontserratRegular.copyWith(
                                color: CbColors.cbWhiteColor,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),

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
                      TabBar(
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

                      //Categories Products
                      SizedBox(
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
        style: cbMontserratBold.copyWith(
          fontSize: SizeConfig.blockSizeHorizontal! * 3.5,
          color: Colors.grey.shade600,
        ),
      ),
    );
  }
}
