import 'package:carousel_slider/carousel_slider.dart';
import 'package:cashback/src/common_widgets/app_bar/appBarWidget.dart';
import 'package:cashback/src/constants/colors.dart';
import 'package:cashback/src/constants/image_strings.dart';
import 'package:cashback/src/constants/text_strings.dart';
import 'package:cashback/src/features/authentication/screens/search/search_screen.dart';
import 'package:flutter/material.dart';

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
    tabController = TabController(length: 6, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      //app bar
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading:
        AppBarButton(prefixIcon: Icons.notifications, onTap: () {},),
        /*Container(
          margin: const EdgeInsets.only(left: 10),
          child: Image.asset(
            CbImageStrings.cbLogo,
            height: height * 0.05,
            width: width * 0.1,
          ),
        ),*/
        /*IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
          color: Colors.black,
        ),*/
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
                      CarouselSlider(
                        items: _carouselImages
                            .map((image) => Image(image: image, fit: BoxFit.cover))
                            .toList(),
                        options: CarouselOptions(
                          height: size.height * 0.2,
                          enlargeCenterPage: true,
                          autoPlay: true,
                          aspectRatio: 16 / 9,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enableInfiniteScroll: true,
                          autoPlayAnimationDuration: Duration(milliseconds: 800),
                          viewportFraction: 0.8,
                        ),
                      ),
                      Container(
                        child:TabBar(
                          isScrollable: true,
                          controller: tabController,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicatorColor: CbColors.cbPrimaryColor2,
                          indicatorWeight: 5,
                          tabs: [
                            RepeatedTab(
                              label: 'Men',
                            ),
                            RepeatedTab(
                              label: 'Women',
                            ),
                            RepeatedTab(
                              label: 'Kids',
                            ),
                            RepeatedTab(
                              label: 'Electronics',
                            ),
                            RepeatedTab(
                              label: 'Accessories',
                            ),
                            RepeatedTab(
                              label: 'Home & Garden',
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
                      Container(
                        height: size.height,
                        child: TabBarView(
                          controller: tabController,
                          children: [
                            Container(
                              color: Colors.red,
                            ),
                            Container(
                              color: Colors.blue,
                            ),
                            Container(
                              color: Colors.yellow,
                            ),
                            Container(
                              color: Colors.pink,
                            ),
                            Container(
                              color: Colors.orange,
                            ),
                            Container(
                              color: Colors.purple,
                            ),
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
