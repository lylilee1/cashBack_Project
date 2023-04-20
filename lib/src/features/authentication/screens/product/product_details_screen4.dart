import 'package:cashback/src/common_widgets/app_bar/appBarWidget.dart';
import 'package:cashback/src/constants/colors.dart';
import 'package:cashback/src/constants/image_strings.dart';
import 'package:cashback/src/constants/text_strings.dart';
import 'package:cashback/src/features/authentication/models/product/product_model.dart';
import 'package:cashback/src/features/authentication/screens/search/search_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class ProductDetailsScreen extends StatefulWidget {
  final dynamic prodList;

  const ProductDetailsScreen({Key? key, required this.prodList})
      : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late List<dynamic> imagesList = widget.prodList['proimages'];

  @override
  Widget build(BuildContext context) {
    bool isFavorite = false;

    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    final Stream<QuerySnapshot> _productsStream = FirebaseFirestore.instance
        .collection('products')
        .where('maincateg', isEqualTo: widget.prodList['maincateg'])
        .where('subcateg', isEqualTo: widget.prodList['subcateg'])
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: AppBarButton(
          prefixIcon: Icons.notifications,
          onTap: () {},
        ),
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
        child: Column(
          children: [
            SizedBox(
              height: size.height,
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: size.height * 0.3),
                    decoration: BoxDecoration(
                      color: CbColors.cbPrimaryColor2.withOpacity(0.3),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    height: height * 0.5,
                    width: width,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Product Details',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),

                        //product name
                        Text(
                          widget.prodList['proname'].toUpperCase(),
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(),
                        ),

                        Row(
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Prix\n",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge!
                                        .copyWith(color: Colors.black),
                                  ),
                                  TextSpan(
                                    text: widget.prodList['price']
                                        .toStringAsFixed(0),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium!
                                        .copyWith(
                                            fontSize: 20,
                                            color: CbColors.cbPrimaryColor2),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Image(
                                image: NetworkImage(
                                  widget.prodList['proimages'][0],
                                ),
                              ),
                            ), //widget.prodList['proimages'][0]
                          ],
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
    );
  }
}
