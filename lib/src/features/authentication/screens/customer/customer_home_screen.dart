import 'package:cashback/src/common_widgets/search/search.dart';
import 'package:cashback/src/common_widgets/search/search_bar_widget.dart';
import 'package:cashback/src/constants/colors.dart';
import 'package:cashback/src/constants/image_strings.dart';
import 'package:cashback/src/constants/sizes.dart';
import 'package:cashback/src/constants/text_strings.dart';
import 'package:flutter/material.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({Key? key}) : super(key: key);

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: const Icon(
            Icons.menu,
            color: Colors.black,
          ),
          title: Text(
            CbTextStrings.cbAppName,
            style: Theme.of(context).textTheme.headline4,
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          actions: [
            /*Container(
              margin: const EdgeInsets.only(right: 20, top: 10, bottom: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: cbCardBgColor,
              ),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.person,
                  color: Colors.black,
                ),
                /*  icon: const Image(
                  image: AssetImage(CbImageStrings.cbUserProfileImage),
                ),*/
              ),
            ),*/
            IconButton(
              onPressed: () => showSearch(
                context: context,
                delegate: Search(),
              ),
              icon: const Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.black,
              ),
            ),
          ],
          bottom: const TabBar(
            isScrollable: true,
            indicatorColor: CbColors.cbPrimaryColor2,
            indicatorWeight: 4,
            tabs: [
              CategoryTabWidget(label: 'Men',),
              CategoryTabWidget(label: 'Women',),
              CategoryTabWidget(label: 'Kids',),
              CategoryTabWidget(label: 'Shoes',),
              CategoryTabWidget(label: 'Home & Garden',),
            ],
          ),
        ),

        body: const TabBarView(
          children: [
            Center(
              child: Text('men screen'),
            ),
            Center(
              child: Text('Women screen'),
            ),
            Center(
              child: Text('Kids screen'),
            ),
            Center(
              child: Text('Shoes screen'),
            ),
            Center(
              child: Text('Home & Garden screen'),
            ),
          ],
        ),

        /*
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(CbSizings.cbDashboardPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Search Box
                //SearchBoxWidget(),
              ],
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  //spreadRadius: 5,
                  blurRadius: 30,
                  offset: const Offset(0, 4), // changes position of shadow
                ),
              ],
            ),
          ),
        ),*/
      ),
    );
  }
}

class CategoryTabWidget extends StatelessWidget {
  const CategoryTabWidget({
    super.key, required this.label,
  });
  final String label;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(
        label,
        style: Theme.of(context).textTheme.headline5,
      ),
    );
  }
}
