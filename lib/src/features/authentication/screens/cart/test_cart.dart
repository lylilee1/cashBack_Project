import 'package:cashback/src/common_widgets/Alert/alert_dialog.dart';
import 'package:cashback/src/common_widgets/app_bar/appBarWidget.dart';
import 'package:cashback/src/constants/colors.dart';
import 'package:cashback/src/constants/text_strings.dart';
import 'package:cashback/src/features/authentication/models/cart/cart_model.dart';
import 'package:cashback/src/features/authentication/screens/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:cashback/src/common_widgets/counter/counter.dart';

import '../../../../common_widgets/snackBar/snackBarWidget.dart';
import '../customer/customer_home_screen4.dart';

class CartScreen extends StatefulWidget {
  final Widget? back;

  const CartScreen({Key? key, this.back}) : super(key: key);
  static String routeName = '/cart';

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final Counter _counter = Counter();

  void _increment() {
    setState(() {
      _counter.increment();
    });
  }

  void _decrement() {
    setState(() {
      _counter.decrement();
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    return Scaffold(
      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GestureDetector(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
//cart page button
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CartScreen(
                        back: AppBarBackButton(),
                      ),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(
                    right: 10,
                  ),
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: CbColors.cbPrimaryColor2,
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.shopping_bag_outlined,
                      color: CbColors.cbPrimaryColor2,
                    ),
                  ),
                ),
              ),

              //add to cart button
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<Cart>().getitems.firstWhereOrNull(
                              (product) =>
                          product.documentId ==
                              widget.prodList['proid']) !=
                          null
                          ? MyMessageHandler.showSnackBar(
                          _scaffoldkey, 'produit déja ajouté au panier')
                      /*updateItem(
                            widget.prodList['proname'],
                            widget.prodList['price'],
                            1,
                            widget.prodList['instock'],
                            widget.prodList['proimages'],
                            widget.prodList['proid'],
                            widget.prodList['sid'],
                            isFavorite,
                          )*/
                          : context.read<Cart>().addItem(
                        widget.prodList['proname'],
                        widget.prodList['price'],
                        1,
                        widget.prodList['instock'],
                        widget.prodList['proimages'],
                        widget.prodList['proid'],
                        widget.prodList['sid'],
                        isFavorite,
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
                      'ajouter au panier'.toUpperCase(),
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
                MaterialPageRoute(builder: (context) => const SearchScreen()),
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
      body: Column(
        children: [
          context.watch<Cart>().getitems.isNotEmpty
              ? Consumer<Cart>(
            builder: (context, cart, child) {
              return Expanded(
                child: ListView.builder(
                  itemCount: cart.getitems.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: (size.width - 30) * 0.7,
                            height: 80,
                            child: Row(
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: AssetImage(
                                          cart.getitems[index].image),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      cart.getitems[index].name,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      cart.getitems[index].price.toString(),
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          )
              : const Center(),
        ],
      ),
    );
  }
}
