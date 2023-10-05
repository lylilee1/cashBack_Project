import 'package:cached_network_image/cached_network_image.dart';
import 'package:cashback/src/common_widgets/Alert/alert_dialog.dart';
import 'package:cashback/src/common_widgets/app_bar/appBarWidget.dart';
import 'package:cashback/src/constants/colors.dart';
import 'package:cashback/src/features/authentication/controllers/cart/cart_controller.dart';
import 'package:cashback/src/features/authentication/controllers/wishlist/wishlist_controller.dart';
import 'package:cashback/src/features/authentication/screens/search/search_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../../../constants/size_config.dart';

import '../main/main_screen.dart';
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
    SizeConfig().init(context);

    double total = context.watch<Cart>().totalPrice;

    return SafeArea(
      child: ScaffoldMessenger(
        key: _scaffoldkey,
        child: Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: context.watch<Cart>().getitems.isNotEmpty
              ? GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        //add to cart button
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              onPressed: total == 0.0
                                  ? null
                                  : () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const PlaceOrderScreen(),
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
                )
              : const SizedBox(),
          //app bar
          appBar: AppBar(
            backgroundColor: CbColors.cbPrimaryColor2,
            elevation: 0,
            leading: widget.back,
            //AppBarButton(prefixIcon: Icons.notifications, onTap: () {},),
            title: const AppBarTitle(
              title: 'Panier',
              iconColor: CbColors.cbWhiteColor,
            ),
            centerTitle: true,
            actions: [
              AppBarButton(
                prefixIcon: Icons.search,
                iconColor: CbColors.cbWhiteColor,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SearchScreen(),
                    ),
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
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.delete_forever_sharp,
                        color: CbColors.cbWhiteColor,
                      ),
                    ),
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
                            Expanded(
                              flex: 6,
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Expanded(
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemCount: cart.getitems.length,
                                            itemBuilder: (context, index) {
                                              final product = cart.getitems[index];

                                              return Padding(
                                                padding: const EdgeInsets.symmetric(
                                                    vertical: 10),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                    BorderRadius.circular(20.0),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color:
                                                        Colors.grey.withOpacity(0.2),
                                                        spreadRadius: 2.5,
                                                        blurRadius: 5,
                                                        offset: const Offset(0,
                                                            5), // changes position of shadow
                                                      ),
                                                    ],
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(10),
                                                    child: Row(
                                                      children: [
                                                        SizedBox(
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
                                                                    CachedNetworkImage(
                                                                      imageUrl: product.imagesUrl.first,
                                                                      placeholder: (context, url) => const CircularProgressIndicator(),
                                                                      imageBuilder: (context, imageProvider) => Container(
                                                                        width: 60,
                                                                        height: 60,
                                                                        decoration: BoxDecoration(
                                                                          image: DecorationImage(
                                                                            //fit: BoxFit.cover,
                                                                            image: imageProvider,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Positioned(
                                                                      top: 10,
                                                                      child: Container(
                                                                        width: 60,
                                                                        height: 60,
                                                                        decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(5),
                                                                          border: Border.all(
                                                                            color: CbColors.cbPrimaryColor2.withOpacity(0.2),
                                                                          ),
                                                                          color: CbColors.cbPrimaryColor2.withOpacity(0.1),
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
                                                                      overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                      style: Theme.of(
                                                                          context)
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
                                                                        text: product
                                                                            .price
                                                                            .toStringAsFixed(
                                                                            0),
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
                                                                        children: <
                                                                            TextSpan>[
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
                                                                              FontWeight.bold,
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

                                                                //Quantity
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
                                                                                title:
                                                                                Text(
                                                                                  'Retirer l\'article',
                                                                                  style: Theme.of(context)
                                                                                      .textTheme
                                                                                      .labelLarge!
                                                                                      .copyWith(),
                                                                                ),
                                                                                message:
                                                                                Text(
                                                                                  'êtes-vous sûr de vouloir supprimer cet article?',
                                                                                  style: Theme.of(context)
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
                                                                                      style: Theme.of(context).textTheme.titleLarge!.copyWith(),
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
                                                                                      context.read<Cart>().removeItem(product);
                                                                                      Navigator.pop(context);
                                                                                    },
                                                                                  ),
                                                                                  CupertinoActionSheetAction(
                                                                                    child:
                                                                                    Text(
                                                                                      'Effacer l\'article',
                                                                                      style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.red),
                                                                                    ),
                                                                                    onPressed:
                                                                                        () {
                                                                                      context.read<Cart>().removeItem(product);
                                                                                      Navigator.pop(context);
                                                                                    },
                                                                                  )
                                                                                ],
                                                                                cancelButton:
                                                                                TextButton(
                                                                                  child:
                                                                                  Text(
                                                                                    'Annuler',
                                                                                    style:
                                                                                    Theme.of(context).textTheme.titleLarge!.copyWith(),
                                                                                  ),
                                                                                  onPressed:
                                                                                      () {
                                                                                    Navigator.pop(context);
                                                                                  },
                                                                                ),
                                                                              ),
                                                                        );
                                                                      },
                                                                      child:
                                                                      Container(
                                                                        height: 20,
                                                                        width: 20,
                                                                        decoration:
                                                                        BoxDecoration(
                                                                          border:
                                                                          Border
                                                                              .all(
                                                                            color: CbColors
                                                                                .cbPrimaryColor2,
                                                                            width:
                                                                            1,
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
                                                                      child:
                                                                      Container(
                                                                        height: 20,
                                                                        width: 20,
                                                                        decoration:
                                                                        BoxDecoration(
                                                                          border:
                                                                          Border
                                                                              .all(
                                                                            color: Colors
                                                                                .grey,
                                                                            width:
                                                                            1,
                                                                          ),
                                                                          shape: BoxShape
                                                                              .circle,
                                                                          color: Colors
                                                                              .white,
                                                                        ),
                                                                        child:
                                                                        const Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color: Colors
                                                                              .grey,
                                                                          size: 18,
                                                                        ),
                                                                      ),
                                                                    ),

                                                                    //Quantity Text
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
                                                                            product
                                                                                .qntty
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
                                                                          FontWeight.bold,
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
                                                                          FontWeight.bold,
                                                                        ),
                                                                      ),
                                                                    ),

                                                                    //increment button
                                                                    GestureDetector(
                                                                      onTap: product
                                                                          .quantity ==
                                                                          product
                                                                              .qntty
                                                                          ? null
                                                                          : () {
                                                                        cart.increment(
                                                                            product);
                                                                        //cart.add(cart.getitems[index]);
                                                                      },
                                                                      child: Container(
                                                                        height: 20,
                                                                        width: 20,
                                                                        decoration:
                                                                        BoxDecoration(
                                                                          border:
                                                                          Border.all(
                                                                            color: CbColors
                                                                                .cbPrimaryColor2,
                                                                            width: 1,
                                                                          ),
                                                                          shape: BoxShape
                                                                              .circle,
                                                                          color: Colors
                                                                              .white,
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
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        )
                                    ),
                                  ],
                                ),
                              ),
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
                              onPressed: () async {
                                Navigator.canPop(context)
                                    ? Navigator.pop(context)
                                    : // Navigate to the home screen
                                    await Future.delayed(
                                            const Duration(microseconds: 100))
                                        .whenComplete(() =>
                                            Navigator.pushReplacementNamed(
                                                context, MainScreen.routeName));
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
