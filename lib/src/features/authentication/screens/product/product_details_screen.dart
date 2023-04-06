import 'package:cashback/src/constants/colors.dart';
import 'package:cashback/src/features/authentication/models/product/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../../../../constants/image_strings.dart';

class ProductDetailsScreen extends StatefulWidget {
  final dynamic prodList;

  const ProductDetailsScreen({Key? key, required this.prodList}) : super(key: key);
  //static String routeName = '/product_details';

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {

  final Stream<QuerySnapshot> _productsStream =
  FirebaseFirestore.instance.collection('products').snapshots();
  bool isFavorite = false;
  late List<dynamic> imagesList = widget.prodList['proImages'];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.45,
                child: Swiper(
                  pagination: const SwiperPagination(
                    builder: DotSwiperPaginationBuilder(
                      color: Colors.white,
                      activeColor: CbColors.cbPrimaryColor2,
                    ),
                  ),
                  itemBuilder: (context, index) {
                    return Image.network(
                      'https://picsum.photos/250?image=9',
                      fit: BoxFit.fill,
                    );
                  },
                  itemCount: imagesList.length,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.prodList['proname'].toUpperCase(),
                        style: Theme
                            .of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(fontSize: 20),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: CbColors.cbPrimaryColor2,
                            size: 20,
                          ),
                          Icon(
                            Icons.star,
                            color: CbColors.cbPrimaryColor2,
                            size: 20,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.grey,
                            size: 20,
                          ),
                          Text(
                            '(116)',
                            style: Theme
                                .of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    widget.prodList['prodesc'],
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(),
                  ),
                  SizedBox(height: 25),
                  /*
                  Row(
                    children: [
                      Text(
                        '99',
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(fontSize: 20, color: CbColors.cbPrimaryColor2),
                      ),
                      Text(
                        ' \XAF',
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(fontSize: 18, color: CbColors.cbPrimaryColor2),
                      ),
                      Container(
                        child: Text(
                          '99 \XAF',
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(fontSize: 12, color: Colors.grey,decoration: TextDecoration.lineThrough),
                        ),

                      ),
                      /*
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: CbColors.cbPrimaryColor2,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          'Cashback 10%',
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(fontSize: 12, color: Colors.white),
                        ),
                      ),*/
                    ],
                  ),*/

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                  widget.prodList['price'].toStringAsFixed(0),
                            style: Theme
                                .of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(
                                fontSize: 20,
                                color: CbColors.cbPrimaryColor2),
                          ),
                          Text(
                            ' \XAF',
                            style: Theme
                                .of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(
                                fontSize: 18,
                                color: CbColors.cbPrimaryColor2),
                          ),
                          Container(
                            child: Text(
                              '99 \XAF',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .displayLarge!
                                  .copyWith(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough),
                            ),
                          ),
                          /*
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: CbColors.cbPrimaryColor2,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              'Cashback 10%',
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .copyWith(fontSize: 12, color: Colors.white),
                            ),
                          ),*/
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '24 visiteurs regardent ce produit',
                            style: Theme
                                .of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(fontSize: 10, color: Colors.grey),
                          ),
                          Text(
                            (widget.prodList['instock'].toString()) + ('14 unités restantes'),
                            style: Theme
                                .of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(fontSize: 10, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 25),

                  //devilery time process
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.delivery_dining_outlined,
                        color: CbColors.cbPrimaryColor2,
                        size: 22,
                      ),
                      Text(
                        'Chez vous sous 48h, prêt à offrir',
                        style:
                        Theme
                            .of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(),
                      ),
                    ],
                  ),
                  SizedBox(height: 25),

                  //item description title
                  ProDetailsHeaderWidget(
                    label: '  Description  ',
                  ),
                  Text(
                    'product description',
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(),
                  ),
                  SizedBox(height: 25),

                  //recommended item title
                  ProDetailsHeaderWidget(label: '  Recommandés  ',),
                  SizedBox(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: _productsStream,
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return const Text('Something went wrong');
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (snapshot.data!.docs.isEmpty) {
                            return const Center(
                              child: Text('No products yet'),
                            );
                          }

                          return StaggeredGridView.countBuilder(
                            itemCount: snapshot.data!.docs.length,
                            crossAxisCount: 2,
                            itemBuilder: (context, index) {
                              return ProductModel(
                                  products: snapshot.data!.docs[index],
                                  isFavorite: isFavorite);

                              /*Padding(
                padding: EdgeInsets.only(
                  left: 10.0,
                  right: 10.0,
                  top: 10.0,
                ),
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF262B34),
                          Colors.grey.withOpacity(0.2),
                        ],
                      ),
                    ),
                    height: 220.0,
                    width: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          //image container
                          height: 140.0,
                          width: 155.0,
                          child: Stack(
                            children: [
                              Positioned(
                                //image position
                                top: 15.0,
                                left: 15.0,
                                child: Hero(
                                  tag: snapshot.data!.docs[index]['proimages'][0],
                                  child: Container(
                                    //image size
                                    height: 120.0,
                                    width: 140.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.0),
                                      image: DecorationImage(
                                        image: NetworkImage(snapshot
                                            .data!.docs[index]['proimages'][0]),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 0.0,
                                top: 15.0,
                                child: Container(
                                  height: 25.0,
                                  width: 50.0,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF342520).withOpacity(0.7),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(15.0),
                                      bottomLeft: Radius.circular(15.0),
                                    ),
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.yellow,
                                          size: 15.0,
                                        ),
                                        /* Text(
                                            snapshot.data!.docs[index]['proRating']
                                                .toString(),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.0,
                                            ),
                                          ),*/
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 16.0),
                          child: Text(
                            snapshot.data!.docs[index]['proname'],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 16.0, right: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 40.0,
                                width: 60.0,
                                child: Row(
                                  children: [
                                    Text(
                                      snapshot.data!.docs[index]['price']
                                          .toString(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10.0,
                                      ),
                                    ),
                                    Text(
                                      '\XAF',
                                      style: TextStyle(
                                        color: Colors.yellow,
                                        fontSize: 10.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  height: 30.0,
                                  width: 30.0,
                                  decoration: BoxDecoration(
                                    color: Colors.yellow,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.add,
                                      size: 11,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );*/
                            },
                            staggeredTileBuilder: (context) =>
                            const StaggeredTile.fit(1),
                          );
                        },
                      ),
                  ),
                ],
              ),

              /*Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.products['image']),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.products['name'],
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.products['price'],
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.products['description'],
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),*/
            ],
          ),
        ),
      ),
      bottomSheet: Row(
        children: [
          Container(
            height: height * 0.05,
            width: width * 0.5,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SvgPicture.asset(
                  CbImageStrings.cbSvgCart,
                  height: height * 0.03,
                  color: Colors.black87,
                ),
                /*Text(
                  'Panier',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: CbColors.cbPrimaryColor2, //Colors.white,
                      ),
                ),*/
                Text(
                  '00.00',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    color: CbColors.cbPrimaryColor2,//Colors.white,
                  ),
                ),
                Text(
                  '\XAF',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    color: CbColors.cbPrimaryColor2,//Colors.white,
                  ),
                ),
              ],
            ),
          ),

          //order button
          Container(
            height: height * 0.05,
            width: width * 0.5,
            decoration: BoxDecoration(
              color: CbColors.cbPrimaryColor2,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Commander',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    color: Colors.white,
                  ),
                ),
                SvgPicture.asset(
                  CbImageStrings.cbSvgArrow,
                  height: height * 0.02,
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
