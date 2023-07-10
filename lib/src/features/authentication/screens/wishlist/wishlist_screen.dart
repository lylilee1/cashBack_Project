import 'package:cashback/src/common_widgets/Alert/alert_dialog.dart';
import 'package:cashback/src/common_widgets/app_bar/appBarWidget.dart';
import 'package:cashback/src/common_widgets/form/auth_widget.dart';
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

import '../../../../common_widgets/snackBar/snackBarWidget.dart';
import '../../../../constants/app_styles.dart';
import '../../../../constants/size_config.dart';
import '../customer/customer_home_screen4.dart';
import 'package:collection/collection.dart';

import '../main/main_screen.dart';

class WishlistScreen extends StatefulWidget {
  final Widget? back;

  const WishlistScreen({Key? key, this.back}) : super(key: key);
  static String routeName = '/cart';

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldkey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    SizeConfig().init(context);

    return SafeArea(
      child: ScaffoldMessenger(
        key: _scaffoldkey,
        child: Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: context.watch<Wish>().getWishItems.isNotEmpty
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
                        onPressed: () {},
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
            title: Text(
              'Wishlist',
              style: cbMontserratBold.copyWith(
                fontSize: SizeConfig.blockSizeHorizontal! * 3.5,
                color: CbColors.cbWhiteColor,
              ),
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
                        builder: (context) => const SearchScreen()),
                  );
                },
              ),
              context.watch<Wish>().getWishItems.isEmpty
                  ? const SizedBox()
                  : IconButton(
                      onPressed: () {
                        MyAlertDialog.showMyDialog(
                            context: context,
                            title: 'Vider la Wishlist',
                            content:
                                'êtes vous sur de vouloir vider la Wishlist?',
                            onPressedNo: () {
                              Navigator.pop(context);
                            },
                            onPressedYes: () {
                              context.read<Wish>().clearWishlist();
                              Navigator.pop(context);
                            });
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.black,
                      ))
            ],
          ),
          body: context.watch<Wish>().getWishItems.isNotEmpty
              ? Consumer<Wish>(
                  builder: (context, wish, child) {
                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //wishlist items
                            Column(
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: wish.getWishItems.length,
                                  itemBuilder: (context, index) {
                                    final product = wish.getWishItems[index];

                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
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
                                                  InkWell(
                                                    onTap: () {
                                                      context
                                                          .read<Wish>()
                                                          .removeWishItem(
                                                              product);
                                                    },
                                                    child: const Align(
                                                      alignment:
                                                          Alignment.topRight,
                                                      child: Icon(
                                                        Icons.close,
                                                        color: CbColors
                                                            .cbPrimaryColor2,
                                                        size: 20,
                                                      ),
                                                    ),
                                                  ),
                                                  context
                                                              .watch<Cart>()
                                                              .getitems
                                                              .firstWhereOrNull(
                                                                  (element) =>
                                                                      element
                                                                          .documentId ==
                                                                      product
                                                                          .documentId) !=
                                                          null
                                                      ? const SizedBox()
                                                      : InkWell(
                                                          onTap: () {
                                                            /* context.read<Cart>().getitems.firstWhereOrNull(
                                                                    (product) =>
                                                                product.documentId ==
                                                                    product.documentId) !=
                                                                null
                                                                ? print('already in cart')
                                                                : */
                                                            context
                                                                .read<Cart>()
                                                                .addItem(
                                                                  product.brand,
                                                                  product.model,
                                                                  product.name,
                                                                  product.price,
                                                                  1,
                                                                  product.qntty,
                                                                  product
                                                                      .imagesUrl,
                                                                  product
                                                                      .documentId,
                                                                  product
                                                                      .suppId,
                                                                  product
                                                                      .isFavorite,
                                                                );
                                                          },
                                                          child: const Align(
                                                            alignment: Alignment
                                                                .bottomRight,
                                                            child: Icon(
                                                              Icons
                                                                  .shopping_bag_outlined,
                                                              color: CbColors
                                                                  .cbPrimaryColor2,
                                                              size: 20,
                                                            ),
                                                          ),
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
                            'Wishlist vide',
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
                                    :
                                    // Navigate to the home screen
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
