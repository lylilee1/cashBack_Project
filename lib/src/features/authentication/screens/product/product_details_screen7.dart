import 'dart:ui';

import 'package:cashback/src/common_widgets/app_bar/appBarWidget.dart';
import 'package:cashback/src/common_widgets/counter/counter.dart';
import 'package:cashback/src/common_widgets/snackBar/snackBarWidget.dart';
import 'package:cashback/src/constants/colors.dart';
import 'package:cashback/src/constants/image_strings.dart';
import 'package:cashback/src/constants/text_strings.dart';
import 'package:cashback/src/features/authentication/controllers/cart/cart_controller.dart';
import 'package:cashback/src/features/authentication/models/product/product_model.dart';

//import 'package:cashback/src/features/authentication/screens/cart/cart_screen.dart';
import 'package:cashback/src/features/authentication/screens/customer/minor_screen/full_screen_view.dart';
import 'package:cashback/src/features/authentication/screens/wishlist/wishlist_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:collection/collection.dart';

import '../cart/cart_screen3.dart';

class ProductDetailsScreen extends StatefulWidget {
  final dynamic prodList;

  const ProductDetailsScreen({Key? key, required this.prodList})
      : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldkey =
      GlobalKey<ScaffoldMessengerState>();

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

    return SafeArea(
      child: ScaffoldMessenger(
        key: _scaffoldkey,
        child: Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
//cart page button
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CartScreen(
                            back: AppBarBackButton(),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(
                        right: 10,
                      ),
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: CbColors.cbPrimaryColor2,
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.shopping_bag_outlined,
                          color: CbColors.cbPrimaryColor2,
                        ),
                      ),
                    ),
                  ),

                  //add to cart button
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<Cart>().getitems.firstWhereOrNull(
                                      (product) =>
                                          product.documentId ==
                                          widget.prodList['proid']) !=
                                  null
                              ? MyMessageHandler.showSnackBar(
                                  _scaffoldkey, 'produit déja ajouté au panier')
                              /*updateItem(
                            widget.prodList['proname'],
                            widget.prodList['price'],
                            1,
                            widget.prodList['instock'],
                            widget.prodList['proimages'],
                            widget.prodList['proid'],
                            widget.prodList['sid'],
                            isFavorite,
                          )*/
                              : context.read<Cart>().addItem(
                                    widget.prodList['probrand'],
                                    widget.prodList['promodelqq'],
                                    widget.prodList['proname'],
                                    widget.prodList['price'],
                                    1,
                                    widget.prodList['instock'],
                                    widget.prodList['proimages'],
                                    widget.prodList['proid'],
                                    widget.prodList['sid'],
                                    isFavorite,
                                  );
                        },
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                            CbColors.cbPrimaryColor2,
                          ),
                        ),

                        /*ElevatedButton.styleFrom(
                          primary: CbColors.cbPrimaryColor2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 15,
                          ),
                        ),*/
                        child: Text(
                          'ajouter au panier'.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          body: SingleChildScrollView(
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

                      //top buttons
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
                                  icon: const Icon(
                                    Icons.favorite_border,
                                    color: CbColors.cbPrimaryColor2,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const WishlistScreen(),),
                                    );
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
                //space
                const SizedBox(height: 24),

                //product name and quantity
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //product name
                    Expanded(
                      child: Text(
                        widget.prodList['proname'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(fontSize: height * 0.019),
                      ),
                    ),

                    //price and rating bar
                    Column(
                      children: [
                        //price
                        RichText(
                          text: TextSpan(
                            text: widget.prodList['price'].toStringAsFixed(0),
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(
                                  fontSize: height * 0.02,
                                  color: CbColors.cbPrimaryColor2,
                                  fontWeight: FontWeight.bold,
                                ),
                            children: <TextSpan>[
                              TextSpan(
                                text: ' FCFA',
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .copyWith(
                                      fontSize: height * 0.02,
                                      color: CbColors.cbPrimaryColor2,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 2),

                        //rating
                        Row(
                          children: [
                            RatingBar.builder(
                              initialRating: 3.5,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 12,
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 0.2),
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                debugPrint(rating.toString());
                              },
                            ),
                            const SizedBox(width: 3),
                            RichText(
                              text: TextSpan(
                                text:
                                    /*'(${widget.prodList['proreviews'].length} Reviews)',*/
                                    '5.0',
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .copyWith(
                                      fontSize: height * 0.016,
                                      color: Colors.grey,
                                    ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: ' (5 Reviews)',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                            fontSize: height * 0.016,
                                            color: Colors.blue.shade300),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
/* voir tous les avis
                        Text(
                          'voir tous les avis',
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(
                                  fontSize: height * 0.012, color: Colors.grey),
                        ),*/

                        //quantity
                        /*
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //decrement button
                            GestureDetector(
                              onTap: _decrement,
                              child: Container(
                                height: 25,
                                width: 25,
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
                                height: 25,
                                width: 25,
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
                        ),*/
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 5),

                //product description for now (will be changed to product speech of sales)
                ReadMoreText(
                  widget.prodList['prodesc'],
                  trimLines: 3,
                  colorClickableText: Colors.blue,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'Voir plus',
                  trimExpandedText: 'Voir moins',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize: height * 0.018,
                        color: Colors.grey.shade700,
                      ),
                ),

                const SizedBox(height: 16),

                //visitors and instock
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [],
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
                              .copyWith(
                                  fontSize: height * 0.012, color: Colors.grey),
                        ),

                        //in stock
                        Text(
                          (widget.prodList['instock'].toString()) +
                              ('14 unités restantes'),
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(
                                  fontSize: height * 0.012, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
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
                                .copyWith(fontSize: height * 0.018)),
                        const SizedBox(height: 8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: height * 0.030,
                              width: height * 0.030,
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
                                          fontSize: height * 0.013,
                                          color: Colors.grey),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: height * 0.01,
                            ),
                            Container(
                              height: height * 0.030,
                              width: height * 0.030,
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
                                          fontSize: height * 0.013,
                                          color: Colors.grey),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: height * 0.01,
                            ),
                            Container(
                              height: height * 0.030,
                              width: height * 0.030,
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
                                          fontSize: height * 0.013,
                                          color: Colors.grey),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: height * 0.01,
                            ),
                            Container(
                              height: height * 0.030,
                              width: height * 0.030,
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
                                          fontSize: height * 0.013,
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
                                .copyWith(fontSize: height * 0.018)),
                        const SizedBox(height: 8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: height * 0.030,
                              width: height * 0.030,
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
                              height: height * 0.030,
                              width: height * 0.030,
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
                              height: height * 0.030,
                              width: height * 0.030,
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
                              height: height * 0.030,
                              width: height * 0.030,
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

                const SizedBox(height: 16),
                Divider(height: 1, color: Colors.grey.shade300),

                const SizedBox(height: 15),
                ProDetailsHeaderWidget(
                  label: '  Produits similaires  ',
                ),

                //Similar items
                SizedBox(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: _productsStream,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return const Text('Something went wrong');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (snapshot.data!.docs.isEmpty) {
                        return const Center(
                          child: Text('No products yet'),
                        );
                      }

                      return SingleChildScrollView(
                        child: StaggeredGridView.countBuilder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          crossAxisCount: 2,
                          itemBuilder: (context, index) {
                            return ProductModel(
                                products: snapshot.data!.docs[index],
                                isFavorite: isFavorite);
                          },
                          staggeredTileBuilder: (context) =>
                              const StaggeredTile.fit(1),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProDetailsHeaderWidget extends StatelessWidget {
  final String label;

  const ProDetailsHeaderWidget({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
            width: 30,
            child: Divider(
              color: CbColors.cbPrimaryColor2,
              thickness: 2,
            ),
          ),
          Text(
            label,
            style: Theme.of(context)
                .textTheme
                .displayLarge!
                .copyWith(fontSize: 20),
          ),
          SizedBox(
            height: 20,
            width: 30,
            child: Divider(
              color: CbColors.cbPrimaryColor2,
              thickness: 2,
            ),
          ),
        ],
      ),
    );
  }
}

