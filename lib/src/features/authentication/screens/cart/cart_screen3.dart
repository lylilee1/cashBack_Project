import 'package:cashback/src/common_widgets/Alert/alert_dialog.dart';
import 'package:cashback/src/common_widgets/app_bar/appBarWidget.dart';
import 'package:cashback/src/constants/colors.dart';
import 'package:cashback/src/constants/text_strings.dart';
import 'package:cashback/src/features/authentication/controllers/cart/cart_controller.dart';
import 'package:cashback/src/features/authentication/controllers/wishlist/wishlist_controller.dart';
import 'package:cashback/src/features/authentication/screens/search/search_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../customer/customer_home_screen4.dart';
import 'package:collection/collection.dart';

import '../orders/orders_screen2.dart';

class CartScreen extends StatefulWidget {
  final Widget? back;

  const CartScreen({Key? key, this.back}) : super(key: key);
  static String routeName = '/cart';

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldkey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    double total = context.watch<Cart>().totalPrice;

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
                  //add to cart button
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: total == 0.0 ? null : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PlaceOrderScreen(),
                            ),
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
                        child: Text(
                          'passer à la caisse'.toUpperCase(),
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
          //app bar
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: widget.back,
            //AppBarButton(prefixIcon: Icons.notifications, onTap: () {},),
            title: const AppBarTitle(
              title: CbTextStrings.cbAppName,
            ),
            centerTitle: true,
            actions: [
              AppBarButton(
                prefixIcon: Icons.search,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchScreen()),
                  );
                },
              ),
              context.watch<Cart>().getitems.isEmpty
                  ? const SizedBox()
                  : IconButton(
                      onPressed: () {
                        MyAlertDialog.showMyDialog(
                            context: context,
                            title: 'Vider le panier',
                            content: 'êtes vous sur de vider le panier?',
                            onPressedNo: () {
                              Navigator.pop(context);
                            },
                            onPressedYes: () {
                              context.read<Cart>().clearCart();
                              Navigator.pop(context);
                            });
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.black,
                      ))
            ],
          ),
          body: context.watch<Cart>().getitems.isNotEmpty
              ? Consumer<Cart>(
                  builder: (context, cart, child) {
                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //cart items
                            Column(
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: cart.getitems.length,
                                  itemBuilder: (context, index) {
                                    final product = cart.getitems[index];

                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: (size.width - 30) * 0.7,
                                            height: 80,
                                            child: Row(
                                              children: [
                                                //product image
                                                SizedBox(
                                                  width: 70,
                                                  height: 70,
                                                  child: Stack(
                                                    children: [
                                                      Container(
                                                        width: 60,
                                                        height: 60,
                                                        decoration:
                                                            BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                            image: NetworkImage(
                                                              product.imagesUrl
                                                                  .first,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        top: 10,
                                                        child: Container(
                                                          width: 60,
                                                          height: 60,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            border: Border.all(
                                                              color: CbColors
                                                                  .cbPrimaryColor2
                                                                  .withOpacity(
                                                                      0.2),
                                                            ),
                                                            color: CbColors
                                                                .cbPrimaryColor2
                                                                .withOpacity(
                                                                    0.1),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Flexible(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      //product name
                                                      Text(
                                                        product.name,
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .displayLarge!
                                                            .copyWith(
                                                                fontSize:
                                                                    height *
                                                                        0.017),
                                                      ),

                                                      //Price
                                                      RichText(
                                                        text: TextSpan(
                                                          text: product.price
                                                              .toStringAsFixed(
                                                                  0),
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .displayLarge!
                                                                  .copyWith(
                                                                    fontSize:
                                                                        height *
                                                                            0.02,
                                                                    color: CbColors
                                                                        .cbPrimaryColor2,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                          children: <TextSpan>[
                                                            TextSpan(
                                                              text: ' FCFA',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .displayLarge!
                                                                  .copyWith(
                                                                    fontSize:
                                                                        height *
                                                                            0.02,
                                                                    color: CbColors
                                                                        .cbPrimaryColor2,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
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
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Flexible(
                                            child: SizedBox(
                                              height: 80,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: Icon(
                                                      Icons.close,
                                                      color: CbColors
                                                          .cbPrimaryColor2,
                                                      size: 15,
                                                    ),
                                                  ),

                                                  //quantity
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      //decrement button
                                                      product.quantity == 1
                                                          ? GestureDetector(
                                                              onTap: () {
                                                                showCupertinoModalPopup<
                                                                    void>(
                                                                  context:
                                                                      context,
                                                                  builder: (BuildContext
                                                                          context) =>
                                                                      CupertinoActionSheet(
                                                                    title: Text(
                                                                      'Retirer l\'article',
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .labelLarge!
                                                                          .copyWith(),
                                                                    ),
                                                                    message:
                                                                        Text(
                                                                      'êtes-vous sûr de vouloir supprimer cet article?',
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .titleLarge!
                                                                          .copyWith(),
                                                                    ),
                                                                    actions: <
                                                                        CupertinoActionSheetAction>[
                                                                      CupertinoActionSheetAction(
                                                                        child:
                                                                            Text(
                                                                          'Placer dans la Wishlist',
                                                                          style: Theme.of(context)
                                                                              .textTheme
                                                                              .titleLarge!
                                                                              .copyWith(),
                                                                        ),
                                                                        onPressed:
                                                                            () async {
                                                                          context.read<Wish>().getWishItems.firstWhereOrNull((element) => element.documentId == product.documentId) != null
                                                                              ? context.read<Cart>().removeItem(product)
                                                                              : await context.read<Wish>().addWishItem(
                                                                                    product.brand,
                                                                                    product.model,
                                                                                    product.name,
                                                                                    product.price,
                                                                                    1,
                                                                                    product.qntty,
                                                                                    product.imagesUrl,
                                                                                    product.documentId,
                                                                                    product.suppId,
                                                                                    product.isFavorite,
                                                                                  );
                                                                          context
                                                                              .read<Cart>()
                                                                              .removeItem(product);
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                      ),
                                                                      CupertinoActionSheetAction(
                                                                        child:
                                                                            Text(
                                                                          'Effacer l\'article',
                                                                          style: Theme.of(context)
                                                                              .textTheme
                                                                              .titleLarge!
                                                                              .copyWith(color: Colors.red),
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          context
                                                                              .read<Cart>()
                                                                              .removeItem(product);
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                      )
                                                                    ],
                                                                    cancelButton:
                                                                        TextButton(
                                                                      child:
                                                                          Text(
                                                                        'Annuler',
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .titleLarge!
                                                                            .copyWith(),
                                                                      ),
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                    ),
                                                                  ),
                                                                );


                                                              },
                                                              child: Container(
                                                                height: 25,
                                                                width: 25,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border: Border
                                                                      .all(
                                                                    color: CbColors
                                                                        .cbPrimaryColor2,
                                                                    width: 1,
                                                                  ),
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                child:
                                                                    const Icon(
                                                                  Icons
                                                                      .delete_forever,
                                                                  color: CbColors
                                                                      .cbPrimaryColor2,
                                                                  size: 14,
                                                                ),
                                                              ),
                                                            )
                                                          : GestureDetector(
                                                              onTap: () {
                                                                cart.decrement(
                                                                    product);
                                                              },
                                                              child: Container(
                                                                height: 25,
                                                                width: 25,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border: Border
                                                                      .all(
                                                                    color: Colors
                                                                        .grey,
                                                                    width: 1,
                                                                  ),
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                child:
                                                                    const Icon(
                                                                  Icons.remove,
                                                                  color: Colors
                                                                      .grey,
                                                                  size: 18,
                                                                ),
                                                              ),
                                                            ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal:
                                                                    8.0),
                                                        child: Text(
                                                          product.quantity
                                                              .toString(),
                                                          style: product
                                                                      .quantity ==
                                                                  product.qntty
                                                              ? Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .displayLarge!
                                                                  .copyWith(
                                                                    fontSize:
                                                                        height *
                                                                            0.02,
                                                                    color: Colors
                                                                        .red,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  )
                                                              : Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .displayLarge!
                                                                  .copyWith(
                                                                    fontSize:
                                                                        height *
                                                                            0.02,
                                                                    color: CbColors
                                                                        .cbPrimaryColor2,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                        ),
                                                      ),

                                                      //increment button
                                                      GestureDetector(
                                                        onTap: product
                                                                    .quantity ==
                                                                product.qntty
                                                            ? null
                                                            : () {
                                                                cart.increment(
                                                                    product);
                                                                //cart.add(cart.getitems[index]);
                                                              },
                                                        child: Container(
                                                          height: 25,
                                                          width: 25,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                              color: CbColors
                                                                  .cbPrimaryColor2,
                                                              width: 1,
                                                            ),
                                                            shape:
                                                                BoxShape.circle,
                                                            color: Colors.white,
                                                          ),
                                                          child: const Icon(
                                                            Icons.add,
                                                            color: CbColors
                                                                .cbPrimaryColor2,
                                                            size: 18,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),

                            const SizedBox(
                              height: 20,
                            ),

                            //Code Promo
                            Container(
                              height: 55,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color:
                                    CbColors.cbPrimaryColor2.withOpacity(0.05),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color:
                                      CbColors.cbPrimaryColor2.withOpacity(0.3),
                                ),
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: (size.width - 30) * 0.7,
                                    height: 55,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: TextField(
                                        cursorColor: CbColors.cbPrimaryColor2,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Code Promo',
                                          hintStyle: TextStyle(
                                            color: CbColors.cbPrimaryColor2
                                                .withOpacity(0.5),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding: EdgeInsets.all(3.0),
                                      child: Container(
                                        height: 55,
                                        decoration: BoxDecoration(
                                          color: CbColors.cbPrimaryColor2,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Appliquer',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),

                            //Cart Items Price Summary
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text: "Subtotal ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall!
                                            .copyWith(
                                              color: Colors.black,
                                            ),
                                        children: [
                                          TextSpan(
                                            text:
                                                " (${cart.getitems.length} produits)",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall!
                                                .copyWith(fontSize: 15),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Dash(
                                      direction: Axis.horizontal,
                                      length: 50,
                                      dashLength: 10,
                                      dashColor: CbColors.cbPrimaryColor2
                                          .withOpacity(0.5),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    //total price
                                    RichText(
                                      text: TextSpan(
                                        text: total.toStringAsFixed(0),
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
                                            text: ' XAF',
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall!
                                                .copyWith(
                                                  fontSize: height * 0.02,
                                                  color:
                                                      CbColors.cbPrimaryColor2,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 30,
                                ),

                                //Delivery fee
                                Row(
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text: "Frais de livraison ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall!
                                            .copyWith(
                                              color: Colors.black,
                                            ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Dash(
                                      direction: Axis.horizontal,
                                      length: 80,
                                      dashLength: 10,
                                      dashColor: CbColors.cbPrimaryColor2
                                          .withOpacity(0.5),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),

                                    //total price delivery fee
                                    RichText(
                                      text: TextSpan(
                                        text: '500',
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
                                            text: ' XAF',
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall!
                                                .copyWith(
                                                  fontSize: height * 0.02,
                                                  color:
                                                      CbColors.cbPrimaryColor2,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 30,
                                ),

                                //Total price
                                Row(
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text: "Total",
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall!
                                            .copyWith(
                                              color: Colors.black,
                                            ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Dash(
                                      direction: Axis.horizontal,
                                      length: 180,
                                      dashLength: 10,
                                      dashColor: CbColors.cbPrimaryColor2
                                          .withOpacity(0.5),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    //total price
                                    RichText(
                                      text: TextSpan(
                                        text: '500',
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
                                            text: ' XAF',
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall!
                                                .copyWith(
                                                  fontSize: height * 0.02,
                                                  color:
                                                      CbColors.cbPrimaryColor2,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )

              //empty cart view
              : Material(
                  child: SafeArea(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Panier vide',
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 40.0),
                            child: Text(
                              'La page que vous recherchez n\'existe pas ou a été déplacée.',
                              style: Theme.of(context).textTheme.displaySmall,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: height * 0.05),

                          //continue shopping button
                          SizedBox(
                            width: width * 0.8,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.canPop(context)
                                    ? Navigator.pop(context)
                                    : Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const CustomerHomeScreen()));
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
                                'Continuer vos achats'.toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
