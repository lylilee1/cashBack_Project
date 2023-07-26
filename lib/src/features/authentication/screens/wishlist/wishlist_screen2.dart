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

import '../../../../constants/app_styles.dart';
import '../../../../constants/size_config.dart';

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
                    Icons.delete_forever_sharp,
                    color: CbColors.cbWhiteColor,
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
                                                      imageUrl: product
                                                          .imagesUrl
                                                          .first,
                                                      placeholder: (context,
                                                          url) =>
                                                      const CircularProgressIndicator(),
                                                      imageBuilder: (context,
                                                          imageProvider) =>
                                                          Container(
                                                            width: 60,
                                                            height: 60,
                                                            decoration:
                                                            BoxDecoration(
                                                              image:
                                                              DecorationImage(
                                                                //fit: BoxFit.cover,
                                                                image:
                                                                imageProvider,
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
                                                          border:
                                                          Border.all(
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
                                                InkWell(
                                                  onTap: () {
                                                    context
                                                        .read<Wish>()
                                                        .removeWishItem(
                                                        product);
                                                  },
                                                  child: const Align(
                                                    alignment: Alignment
                                                        .topRight,
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
                                                    .firstWhereOrNull((element) =>
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
                                                        .read<
                                                        Cart>()
                                                        .addItem(
                                                      product
                                                          .brand,
                                                      product
                                                          .model,
                                                      product
                                                          .name,
                                                      product
                                                          .price,
                                                      1,
                                                      product
                                                          .qntty,
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
                                                  child:
                                                  const Align(
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
                                  ),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: SizeConfig.kPadding24),
                  Center(
                    child: Column(
                      children: [
                        //empty Wishlist image
                        Icon(
                          Icons.favorite_border,
                          size: height * 0.1,
                          color: CbColors.cbPrimaryColor2.withOpacity(0.2),
                        ),
                        SizedBox(height: SizeConfig.blockSizeVertical! * 2),
                        Text(
                          'Votre wishlist est vide',
                          style: cbMontserratBold.copyWith(
                            fontSize: SizeConfig.blockSizeHorizontal! * 5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: SizeConfig.kPadding16,
                  ),

                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Divider(
                      height: 0.05,
                      color: CbColors.cbPrimaryColor2.withOpacity(0.2),
                      thickness: 1,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 15,),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: SizeConfig.blockSizeVertical! * 2),
                        Text(
                          'Réglons ça !',
                          textAlign: TextAlign.start,
                          style: cbMontserratBold.copyWith(
                            fontSize: SizeConfig.blockSizeHorizontal! * 5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 40.0),
                    child: Text(
                      'La page que vous recherchez n\'existe pas ou a été déplacée.',
                      style: Theme.of(context).textTheme.displaySmall,
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
    );
  }
}
