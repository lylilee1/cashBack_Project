import 'dart:ui';

import 'package:cashback/src/common_widgets/counter/counter.dart';
import 'package:cashback/src/constants/colors.dart';
import 'package:cashback/src/constants/image_strings.dart';
import 'package:cashback/src/constants/text_strings.dart';
import 'package:cashback/src/features/authentication/models/product/product_model.dart';
import 'package:cashback/src/features/authentication/screens/customer/minor_screen/full_screen_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:readmore/readmore.dart';
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
  final Counter _counter = Counter();
  late List<dynamic> imagesList = widget.prodList['proimages'];

  void _increment() {
    setState(() {
      _counter.increment();
    });
  }

  void _decrement() {
    setState(() {
      _counter.decrement();
    });
  }

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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GestureDetector(
        onTap: () {
          debugPrint('Add to Cart button pressed!');
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          height: 60,
          width: double.infinity,
          margin: EdgeInsets.symmetric(
            horizontal: 24,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color(0xff404c57),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /*
              SvgPicture.asset(
                'assets/images/svg/add_to_cart.svg',
              ),
              SizedBox(
                width: (width! / 100) * 1,
              ),*/
              RichText(
                text: TextSpan(
                  text: 'Ajouter au panier'.toUpperCase(),
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: Colors.white,
                        fontSize: (height! / 100) * 2.5,
                      ),
                  children: <TextSpan>[
                    TextSpan(
                      text: ' * ',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: Colors.red,
                            fontSize: (height! / 100) * 2.5,
                          ),
                    ),
                    TextSpan(
                      text: widget.prodList['price'].toStringAsFixed(0),
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: Colors.white,
                            fontSize: (height! / 100) * 2.5,
                            //decoration: TextDecoration.lineThrough,
                            /*decorationThickness:
                        (height! / 100) * 1,*/
                            decorationColor: Colors.white,
                          ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
          ),
          //padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              SizedBox(
                height: height * 0.5,
                child: Stack(
                  children: [
                    //products images slider
                    ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Swiper(
                        itemCount: imagesList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FullScreenView(
                                    imagesList: imagesList,
                                  ),
                                ),
                              );
                            },
                            child: Image.network(
                              imagesList[index],
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                        pagination: const SwiperPagination(
                          builder: DotSwiperPaginationBuilder(
                            color: Colors.grey,
                            activeColor: CbColors.cbPrimaryColor2,
                          ),
                        ),
                        control: const SwiperControl(
                          color: CbColors.cbPrimaryColor2,
                        ),
                        autoplay: true,
                        autoplayDelay: 5000,
                        autoplayDisableOnInteraction: true,
                        loop: true,
                      ),
                    ),


                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //go back share
                            Container(
                              height: height * 0.05,
                              width: height * 0.05,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.brown.withOpacity(0.2),
                                    spreadRadius: 0.0,
                                    blurRadius: 12,
                                    offset: const Offset(
                                        0, 5), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: IconButton(
                                icon: SvgPicture.asset(
                                  CbImageStrings.cbIconBack,
                                  color: CbColors.cbPrimaryColor2,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),

                            //menu or share button
                            Container(
                              height: height * 0.05,
                              width: height * 0.05,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.brown.withOpacity(0.2),
                                    spreadRadius: 0.0,
                                    blurRadius: 12,
                                    offset: const Offset(
                                        0, 5), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: IconButton(
                                icon: SvgPicture.asset(
                                  CbImageStrings.cbIconMenu,
                                  color: CbColors.cbPrimaryColor2,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),

              //product name and quantity
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.prodList['proname'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .copyWith(fontSize: 20),
                    ),
                  ),

                  //quantity
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //decrement button
                      GestureDetector(
                        onTap: _decrement,
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: const Icon(Icons.remove, color: Colors.grey),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          _counter.value.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(fontSize: 20),
                        ),
                      ),

                      //increment button
                      GestureDetector(
                        onTap: _increment,
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: const Icon(Icons.add, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              //rating bar
              Row(
                children: [
                  RatingBar.builder(
                    initialRating: 3.5,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 18,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      debugPrint(rating.toString());
                    },
                  ),
                  const SizedBox(width: 8),
                  RichText(
                    text: TextSpan(
                      text:
                          /*'(${widget.prodList['proreviews'].length} Reviews)',*/
                          '5.0',
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                            fontSize: height * 0.02,
                            color: Colors.grey,
                          ),
                      children: <TextSpan>[
                        TextSpan(
                          text: ' (5 Reviews)',
                          style: TextStyle(
                            color: Colors.blue.shade300,
                            fontSize: height * 0.02,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16),

              //product description for now (will be changed to product speech of sales)
              ReadMoreText(
                widget.prodList['prodesc'],
                trimLines: 3,
                colorClickableText: Colors.blue,
                trimMode: TrimMode.Line,
                trimCollapsedText: 'Voir plus',
                trimExpandedText: 'Voir moins',
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontSize: height * 0.02,
                      color: Colors.grey.shade700,
                    ),
              ),

              const SizedBox(height: 16),
              //product's price, visitors and instock
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      //price
                      Text(
                        widget.prodList['price'].toStringAsFixed(0),
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(
                                fontSize: 20, color: CbColors.cbPrimaryColor2),
                      ),
                      Text(
                        ' \XAF',
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(
                                fontSize: 18, color: CbColors.cbPrimaryColor2),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //visitors
                      Text(
                        '24 visiteurs regardent ce produit',
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(fontSize: 10, color: Colors.grey),
                      ),

                      //instock
                      Text(
                        (widget.prodList['instock'].toString()) +
                            ('14 unités restantes'),
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(fontSize: 10, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 16),
              Divider(height: 1, color: Colors.grey.shade300),
              const SizedBox(height: 16),

              //product's size and color
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //size
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Taille',
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(fontSize: height * 0.02)),
                      const SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: height * 0.035,
                            width: height * 0.035,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 1,
                              ),
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Center(
                              child: Text(
                                'S',
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .copyWith(
                                        fontSize: height * 0.02,
                                        color: Colors.grey),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: height * 0.01,
                          ),
                          Container(
                            height: height * 0.035,
                            width: height * 0.035,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 1,
                              ),
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Center(
                              child: Text(
                                'M',
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .copyWith(
                                        fontSize: height * 0.02,
                                        color: Colors.grey),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: height * 0.01,
                          ),
                          Container(
                            height: height * 0.035,
                            width: height * 0.035,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 1,
                              ),
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Center(
                              child: Text(
                                'L',
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .copyWith(
                                        fontSize: height * 0.02,
                                        color: Colors.grey),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: height * 0.01,
                          ),
                          Container(
                            height: height * 0.035,
                            width: height * 0.035,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 1,
                              ),
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Center(
                              child: Text(
                                'XL',
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .copyWith(
                                        fontSize: height * 0.02,
                                        color: Colors.grey),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  //color
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Couleur',
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(fontSize: height * 0.02)),
                      const SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: height * 0.035,
                            width: height * 0.035,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 1,
                              ),
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: height * 0.01,
                          ),
                          Container(
                            height: height * 0.035,
                            width: height * 0.035,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 1,
                              ),
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: height * 0.01,
                          ),
                          Container(
                            height: height * 0.035,
                            width: height * 0.035,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 1,
                              ),
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: height * 0.01,
                          ),
                          Container(
                            height: height * 0.035,
                            width: height * 0.035,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 1,
                              ),
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
