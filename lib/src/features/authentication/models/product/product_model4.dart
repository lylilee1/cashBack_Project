import 'package:cashback/src/constants/colors.dart';
import 'package:cashback/src/features/authentication/controllers/cart/cart_controller.dart';
import 'package:cashback/src/features/authentication/controllers/wishlist/wishlist_controller.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

import '../../screens/product/product_details_screen7.dart';

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
        child: Column(
          children: [
            Container(
              width: (width - 50) / 2,
              height: 220,
              child: Stack(
                children: [
                  //Container
                  Positioned(
                    top: 20,
                    child: Container(
                      width: (width - 50) / 2,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                          color: CbColors.cbPrimaryColor2.withOpacity(0.2),
                          width: 1.0,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                          right: 15,
                          bottom: 10,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //Star Rating
                            Row(
                              children: const [
                                Icon(
                                  LineIcons.star,
                                  size: 18,
                                  color: CbColors.cbPrimaryColor2,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 3.0),
                                  child: Text(
                                    '5.1',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                            //Cart Icon Button
                          ],
                        ),
                      ),
                    ),
                  ),

                  //Image
                  Positioned(
                    top: 5,
                    child: Container(
                      width: (width - 50) / 2,
                      height: 180,
                      child:
                          //Image
                          Image(
                        image: NetworkImage(widget.products['proimages'][0]),
                        height: 130,
                        width: 130,
                        //fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  //Heart Icon Button
                  Positioned(
                    top: 25,
                    right: 15,
                    child:
                        //Add to Heart Button
                        Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 5.0,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Center(
                        child: IconButton(
                          onPressed: () {
                            context.read<Wish>().getWishItems.firstWhereOrNull(
                                        (product) =>
                                            product.documentId ==
                                            widget.products['proid']) !=
                                    null
                                ? context
                                    .read<Wish>()
                                    .removeThis(widget.products['proid'])
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
                          icon: context
                                      .watch<Wish>()
                                      .getWishItems
                                      .firstWhereOrNull((product) =>
                                          product.documentId ==
                                          widget.products['proid']) !=
                                  null
                              ? const Icon(
                                  LineIcons.heartAlt,
                                  color: CbColors.cbPrimaryColor2,
                                  size: 18,
                                )
                              : const Icon(
                                  LineIcons.heart,
                                  color: CbColors.cbPrimaryColor2,
                                  size: 18,
                                ),
                        ),
                      ),
                    ),
                  ),

                  //Cart Icon Button
                  Positioned(
                    top: 175,
                    right: 15,
                    child:
                        //Add to Cart Button
                        Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 5.0,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Center(
                        child: IconButton(
                          onPressed: () {
                            context.read<Cart>().getitems.firstWhereOrNull(
                                        (product) =>
                                            product.documentId ==
                                            widget.products['proid']) !=
                                    null
                                ? context
                                    .read<Cart>()
                                    .removeThis(widget.products['proid'])
                                : context.read<Cart>().addItem(
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
                          icon: context.watch<Cart>().getitems.firstWhereOrNull(
                                      (product) =>
                                          product.documentId ==
                                          widget.products['proid']) !=
                                  null
                              ? const Icon(
                                  Icons.shopping_bag,
                                  color: CbColors.cbPrimaryColor2,
                                  size: 18,
                                )
                              : const Icon(
                                  LineIcons.shoppingBag,
                                  color: CbColors.cbPrimaryColor2,
                                  size: 18,
                                ),
                        ),
                      ),
                    ),
                  ),

                  //Discount Button
                  widget.products['discount'] != 0
                      ? Positioned(
                          top: 25,
                          left: 15,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: CbColors.cbPrimaryColor2,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              ),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Moins ${widget.products['discount'].toStringAsFixed(0)} %',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container(color: Colors.transparent)
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),

            //Product Model and Product Price
            Column(
              children: [
                SizedBox(
                  width: (width - 60) / 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          //Product Model
                          Text(
                            widget.products['model'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),

                          Row(
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text: widget.products['price']
                                            .toStringAsFixed(0),
                                        style: widget.products['discount'] != 0
                                            ? Theme.of(context)
                                                .textTheme
                                                .labelSmall!
                                                .copyWith(
                                                  color: Colors.grey,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                )
                                            : Theme.of(context)
                                                .textTheme
                                                .labelSmall!
                                                .copyWith(
                                                  color: Colors.red,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w500,
                                                )),
                                    widget.products['discount'] != 0
                                        ? TextSpan(
                                            text: ((1 -
                                                        (widget.products[
                                                                'discount'] /
                                                            100)) *
                                                    widget.products['price'])
                                                .toStringAsFixed(0),
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall!
                                                .copyWith(
                                                  color: Colors.red,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                          )
                                        : const TextSpan(),
                                    TextSpan(
                                      text: ' \XAF',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall!
                                          .copyWith(
                                            color: Colors.red,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
