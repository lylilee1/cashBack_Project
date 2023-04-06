import 'package:cashback/src/constants/colors.dart';
import 'package:cashback/src/constants/image_strings.dart';
import 'package:cashback/src/features/authentication/models/product/product_model.dart';
import 'package:cashback/src/features/authentication/screens/customer/minor_screen/full_screen_view.dart';
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
            ),
            child: Column(
              children: [
                //product carousel image
                InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FullScreenView(imagesList: imagesList,
                        ),
                      ),
                    );
                  },
                  child: Stack(
                    children: [
                      SizedBox(
                        height: height * 0.40,
                        child: Swiper(
                          pagination: const SwiperPagination(
                            builder: DotSwiperPaginationBuilder(
                              color: Colors.grey,
                              activeColor: CbColors.cbPrimaryColor2,
                              size: 10.0,
                              activeSize: 10.0,
                              space: 15.0,
                            ),
                          ),
                          itemBuilder: (context, index) {
                            return Image(
                              image: NetworkImage(
                                imagesList[index],
                              ),
                              //fit: BoxFit.fill,
                            );
                          },
                          itemCount: 1,
                        ),
                      ),

                      //back button
                      Positioned(
                        top: 30,
                        left: 10,
                        child: CircleAvatar(
                          backgroundColor: CbColors.cbPrimaryColor2,
                          radius: 20,
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon:
                            SvgPicture.asset(
                              CbImageStrings.cbSvgBackArrow,
                              height: height * 0.02,
                            ),
                          ),
                        ),
                      ),

                      //back button
                      Positioned(
                        top: 30,
                        right: 10,
                        child: CircleAvatar(
                          backgroundColor: CbColors.cbPrimaryColor2,
                          radius: 20,
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.share, color: Colors.white, size: 15,),
                                /*
                            SvgPicture.asset(
                              CbImageStrings.cbSvgFrontArrow,
                              height: height * 0.01,
                            ),*/
                          ),
                        ),
                      ),
                    ],
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
                          style: Theme.of(context)
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
                              style: Theme.of(context)
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
                      style:
                          Theme.of(context).textTheme.titleMedium!.copyWith(),
                    ),
                    SizedBox(height: 25),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              widget.prodList['price'].toStringAsFixed(0),
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .copyWith(
                                      fontSize: 20,
                                      color: CbColors.cbPrimaryColor2),
                            ),
                            Text(
                              ' \XAF',
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .copyWith(
                                      fontSize: 18,
                                      color: CbColors.cbPrimaryColor2),
                            ),
                            /*
                            Container(
                              child: Text(
                                '99 \XAF',
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .copyWith(
                                        fontSize: 12,
                                        color: Colors.grey,
                                        decoration: TextDecoration.lineThrough),
                              ),
                            ),*/
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
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .copyWith(fontSize: 10, color: Colors.grey),
                            ),
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
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(),
                        ),
                      ],
                    ),
                    SizedBox(height: 25),

                    //item description title
                    /* ProDetailsHeaderWidget(
                      label: '  Description  ',
                    ),*/
                    Text(
                      'Description',
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .copyWith(fontSize: 20),
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      'product description',
                      style:
                          Theme.of(context).textTheme.titleMedium!.copyWith(),
                    ),
                    SizedBox(height: 25),

                    //recommended item title
                    /* ProDetailsHeaderWidget(
                      label: '  Recommandés  ',
                    ),*/
                    Text(
                      'Recommandés',
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .copyWith(fontSize: 20),
                    ),
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
                            },
                            staggeredTileBuilder: (context) =>
                                const StaggeredTile.fit(1),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
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
                        color: CbColors.cbPrimaryColor2, //Colors.white,
                      ),
                ),
                Text(
                  '\XAF',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: CbColors.cbPrimaryColor2, //Colors.white,
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
                  CbImageStrings.cbSvgFrontArrow,
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
