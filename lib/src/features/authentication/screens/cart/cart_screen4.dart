import 'package:cashback/src/common_widgets/Alert/alert_dialog.dart';
import 'package:cashback/src/common_widgets/app_bar/appBarWidget.dart';
import 'package:cashback/src/constants/colors.dart';
import 'package:cashback/src/constants/text_strings.dart';
import 'package:cashback/src/features/authentication/controllers/cart/cart_controller.dart';
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
  final GlobalKey<ScaffoldMessengerState> _scaffoldkey =
  GlobalKey<ScaffoldMessengerState>();

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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
      body: context.watch<Cart>().getitems.isNotEmpty
          ? Consumer<Cart>(
        builder: (context, cart, child) {
          return SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.getitems.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 20.0),
                        child: Row(
                          children: [
                            //image
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  //product name
                                  Text(
                                    cart.getitems[index].name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge,
                                  ),
                                  const SizedBox(height: 10),
                                  //product price
                                  Text(
                                    '\$${cart.getitems[index].price}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall,
                                  ),
                                  const SizedBox(height: 10),
                                  //product quantity
                                  Row(
                                    children: [
                                      Text(
                                        'Quantité: ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            //delete button
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                //total price
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    ],
                  ),
                ),
              ],
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
    );
  }
}
