
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../../../models/product/product_model4.dart';

class SportGalleryScreen extends StatefulWidget {
  const SportGalleryScreen({Key? key}) : super(key: key);

  @override
  State<SportGalleryScreen> createState() => _SportGalleryScreenState();
}

class _SportGalleryScreenState extends State<SportGalleryScreen> {
  final Stream<QuerySnapshot> _productsStream =
  FirebaseFirestore.instance.collection('products').where('maincateg',isEqualTo: 'sport & loisirs').snapshots();
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
            return ProductModel(products: snapshot.data!.docs[index],
                isFavorite: isFavorite);
          },
          staggeredTileBuilder: (context) => const StaggeredTile.fit(1),
        );
      },
    );
  }
}
