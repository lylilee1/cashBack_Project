
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../../../models/product/product_model4.dart';

class WomenGalleryScreen extends StatefulWidget {
  const WomenGalleryScreen({Key? key}) : super(key: key);

  @override
  State<WomenGalleryScreen> createState() => _WomenGalleryScreenState();
}

class _WomenGalleryScreenState extends State<WomenGalleryScreen> {
  final Stream<QuerySnapshot> _productsStream =
  FirebaseFirestore.instance.collection('products').where('maincateg',isEqualTo: 'femmes').snapshots();
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _productsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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

        return StaggeredGridView.countBuilder(
          itemCount: snapshot.data!.docs.length,
          crossAxisCount: 2,
          itemBuilder: (context, index) {
            return ProductModel(products: snapshot.data!.docs[index] ,isFavorite: isFavorite );

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
          staggeredTileBuilder: (context) => const StaggeredTile.fit(1),
        );
      },
    );
  }
}
