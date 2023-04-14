import 'package:cashback/src/constants/colors.dart';
import 'package:flutter/material.dart';

import '../../screens/product/product_details_screen7.dart';
//import '../../screens/product/product_details_screen2.dart';

class ProductModel extends StatelessWidget {
  final dynamic products;

  const ProductModel({
    super.key,
    required this.isFavorite,
    this.products,
  });

  final bool isFavorite;

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    return Padding(
      padding: EdgeInsets.only(
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
              //builder: (context) => ProductDetailsScreen(prodList: products,
              builder: (context) => ProductDetailsScreen(
                prodList: products,
              ),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 3,
                blurRadius: 5.0,
                //offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
            color: Colors.white,
          ),
          height: 220.0,
          width: 150,
          child: Column(
            children: [
              //wishlist icon
              Padding(
                padding: EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    isFavorite
                        ? Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )
                        : Icon(
                            Icons.favorite_border,
                            color: CbColors.cbPrimaryColor2,
                          ),
                  ],
                ),
              ),

              //product image
              Hero(
                tag: products['proname'],
                child: Container(
                  height: 100.0,
                  width: 100.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    image: DecorationImage(
                      image: NetworkImage(products['proimages'][0]),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 7.0,
              ),

              //product name
              Text(
                products['proname'],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: height * 0.016), //Theme.of(context).textTheme.labelLarge,
              ),

              /*
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      products['price'].toStringAsFixed(0) + ' \XAF',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: CbColors.cbPrimaryColor2,
                        fontWeight: FontWeight.w700,
                      ), //Theme.of(context).textTheme.labelLarge,
                    ),
                    CircleAvatar(
                      backgroundColor: CbColors.cbPrimaryColor2,
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 15,
                      ),
                    )
                  ],
                ),
              ),*/

              //product price
              Text(
                products['price'].toStringAsFixed(0) +
                    ' \XAF',
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: CbColors
                        .cbPrimaryColor2), //Theme.of(context).textTheme.labelLarge,
              ),

              //add to cart button
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  color: CbColors.cbPrimaryColor2,
                  height: 1.0,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Add to cart',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(
                          color: CbColors
                              .cbPrimaryColor2), //Theme.of(context).textTheme.labelLarge,
                    ),
                    Icon(
                      Icons.shopping_basket,
                      color: CbColors.cbPrimaryColor2,
                      size: 18,
                    ),
                  ],
                  /*
                  if (addedToCart) ...[
                    Icon(
                      Icons.remove_circle_outline,
                      color: CbColors.cbPrimaryColor2,
                      size: 18,
                    ),
                    Text(
                      '3',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(
                              color: CbColors
                                  .cbPrimaryColor2), //Theme.of(context).textTheme.labelLarge,
                    ),
                    Icon(
                      Icons.add_circle_outline,
                      color: CbColors.cbPrimaryColor2,
                      size: 18,
                    ),
                  ],*/
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
