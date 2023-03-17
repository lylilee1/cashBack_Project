import 'package:carousel_slider/carousel_slider.dart';
import 'package:cashback/src/constants/colors.dart';
import 'package:cashback/src/constants/image_strings.dart';
import 'package:flutter/material.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({Key? key}) : super(key: key);

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
    final size = MediaQuery.of(context).size;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: SizedBox(
            height: size.height * 0.2,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: _carouselImages.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  width: size.width * 0.95,
                  decoration: BoxDecoration(
                    //borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: _carouselImages[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),

            /*
           ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: _carouselImages.length,
              itemBuilder: (context, index) {
                return PromoBox();
                /*return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: size.width * 0.2,
                    height: size.height * 0.1,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );*/
              },
            ),
            * */

          ),
        ),/*
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
        SizedBox(
          height: 10,
        ),*/
        /*
        TabBar(
          controller: tabController,
          indicatorSize: TabBarIndicatorSize.label,
          tabs: [
            Container(
              width: double.infinity,
              height: size.height * 0.05,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selectedValue == 0 ? Colors.blue : Colors.grey.withOpacity(0.8),
                //borderRadius: BorderRadius.circular(10),
              ),
            ),
            Container(
              width: double.infinity,
              height: size.height * 0.05,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selectedValue == 0 ? Colors.blue : Colors.grey.withOpacity(0.8),
                //borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        ),*/
        TabBar(
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
              label: 'Shoes',
            ),
            RepeatedTab(
              label: 'Bags',
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
            RepeatedTab(
              label: 'Kids',
            ),
            RepeatedTab(
              label: 'Beauty',
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
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: [
              Center(
                child: Text('Men Screen'),
              ),
              Center(
                child: Text('Women Screen'),
              ),
              Center(
                child: Text('Shoes Screen'),
              ),
              Center(
                child: Text('Bags Screen'),
              ),
              Center(
                child: Text('Electronics Screen'),
              ),
              Center(
                child: Text('Accessories Screen'),
              ),
              Center(
                child: Text('Home & Garden Screen'),
              ),
              Center(
                child: Text('Kids Screen'),
              ),
              Center(
                child: Text('Beauty Screen'),
              ),
            ],
          ),
        ),
      ],
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

class PromoBox extends StatelessWidget {
  const PromoBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(right: 5.0),
          width: MediaQuery.of(context).size.width - 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            image: DecorationImage(
              image: AssetImage(CbImageStrings.cbC2),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 5.0),
          width: MediaQuery.of(context).size.width - 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: CbColors.cbPrimaryColor2,
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 15.0, right: 125.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Get 50% Off',
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(height: 15.0),
                Text(
                  'On All Products',
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
