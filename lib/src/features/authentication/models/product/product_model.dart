import 'package:cashback/src/constants/colors.dart';
import 'package:cashback/src/features/authentication/controllers/wishlist/wishlist_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

import '../../screens/product/product_details_screen7.dart';
//import '../../screens/product/product_details_screen2.dart';

class ProductModel extends StatefulWidget {
  final dynamic products;

  const ProductModel({
    super.key,
    required this.isFavorite,
    this.products,
  });

  final bool isFavorite;

  @override
  State<ProductModel> createState() => _ProductModelState();
}

class _ProductModelState extends State<ProductModel> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    return Padding(
      padding: const EdgeInsets.only(
        top: 15.0,
        bottom: 5.0,
        left: 10.0,
        right: 10.0,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              //builder: (context) => ProductDetailsScreen(products: products,
              builder: (context) => ProductDetailsScreen(
                prodList: widget.products,
              ),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 5.0,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Stack(
            children: [
              //wishlist icon
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: context
                          .watch<Wish>()
                          .getWishItems
                          .firstWhereOrNull((product) =>
                      product.documentId ==
                          widget.products['proid']) !=
                          null
                          ? const Icon(
                        Icons.favorite,
                        color: CbColors.cbPrimaryColor2,
                      )
                          : const Icon(
                        Icons.favorite_border_outlined,
                        color: CbColors.cbPrimaryColor2,
                      ),
                      onPressed: () {
                        context
                            .read<Wish>()
                            .getWishItems
                            .firstWhereOrNull((product) =>
                        product.documentId ==
                            widget.products['proid']) !=
                            null
                            ? context.read<Wish>().removeThis(widget.products['proid'])
                            : context.read<Wish>().addWishItem(
                          widget.products['brand'],
                          widget.products['model'],
                          widget.products['proname'],
                          widget.products['price'],
                          1,
                          widget.products['instock'],
                          widget.products['proimages'],
                          widget.products['proid'],
                          widget.products['sid'],
                          widget.isFavorite,
                        );
                      },
                    ),
                  ],
                ),
              ),
              //Image
              Padding(
                padding: EdgeInsets.only(bottom: 110),
                child: Image(
                  image: NetworkImage(widget.products['proimages'][0]),
                  height: 200,
                  width: 100,
                  //fit: BoxFit.cover,
                ),
              ),
              //Model Name
              Positioned(
                top: 155,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.products['model'],
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(),
                  ),
                ),
              ),

              Positioned(
                top: 210,
                right: 0,
                left: 0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.products['price'].toStringAsFixed(0) + ' \XAF',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: CbColors.cbPrimaryColor2,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Container(
                        width: 40,
                          height: 40,
                        decoration: BoxDecoration(
                          color: CbColors.cbPrimaryColor2.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(15.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
