import 'package:cashback/src/common_widgets/Alert/alert_dialog.dart';
import 'package:cashback/src/common_widgets/app_bar/appBarWidget.dart';
import 'package:cashback/src/constants/colors.dart';
import 'package:cashback/src/constants/text_strings.dart';
import 'package:cashback/src/features/authentication/controllers/cart/cart_controller.dart';
import 'package:cashback/src/features/authentication/screens/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cashback/src/common_widgets/counter/counter.dart';

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
          return ListView.builder(
            itemCount: cart.getitems.length, //cart.itemCount,
            itemBuilder: (context, index) {
              final product = cart.getitems[index];

              return SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 15,),
                    child: Column(
                      children: [
                        Container(
                          height: 110,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Row(
                            children: [
                              //radio button
                              Radio(
                                value: '',
                                groupValue: '',
                                activeColor: CbColors.cbPrimaryColor2,
                                onChanged: (index) {},
                              ),

                              //Product image
                              Container(
                                height: 70,
                                width: 70,
                                margin: const EdgeInsets.only(right: 15.0),
                                child: Image.network(
                                  product.imagesUrl.first,
                                ),
                              ),

                              //product name and price
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(vertical: 15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    //Product name
                                    Text(
                                      product.name,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayLarge!
                                          .copyWith(fontSize: height * 0.019),
                                    ),

                                    //Price
                                    RichText(
                                      text: TextSpan(
                                        text: product.price.toStringAsFixed(0),
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
                                            text: ' FCFA',
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayLarge!
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
                              ),
                              const Spacer(),

                              //delete button and quantity
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                        Icons.delete_forever,
                                        color: Colors.red,
                                        //size: 14,
                                      ),
                                      onPressed: () {
                                        cart.removeItem(product);
                                      },
                                    ),

                                    //quantity
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        //decrement button
                                        product.quantity == 1
                                            ? GestureDetector(
                                          onTap: () {
                                            cart.removeItem(product);
                                          },
                                          child: Container(
                                            height: 25,
                                            width: 25,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: CbColors
                                                    .cbPrimaryColor2,
                                                width: 1,
                                              ),
                                              shape: BoxShape.circle,
                                              color: Colors.white,
                                            ),
                                            child: const Icon(
                                              Icons.delete_forever,
                                              color: CbColors
                                                  .cbPrimaryColor2,
                                              size: 15,
                                            ),
                                          ),
                                        )
                                            : GestureDetector(
                                          onTap: () {
                                            cart.decrement(product);
                                          },
                                          child: Container(
                                            height: 25,
                                            width: 25,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.grey,
                                                width: 1,
                                              ),
                                              shape: BoxShape.circle,
                                              color: Colors.white,
                                            ),
                                            child: const Icon(
                                              Icons.remove,
                                              color: Colors.grey,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Text(
                                            product.quantity.toString(),
                                            style: product.quantity ==
                                                product.qntty
                                                ? Theme.of(context)
                                                .textTheme
                                                .displayLarge!
                                                .copyWith(
                                              fontSize: height * 0.02,
                                              color: Colors.red,
                                              fontWeight:
                                              FontWeight.bold,
                                            )
                                                : Theme.of(context)
                                                .textTheme
                                                .displayLarge!
                                                .copyWith(
                                              fontSize: height * 0.02,
                                              color: CbColors
                                                  .cbPrimaryColor2,
                                              fontWeight:
                                              FontWeight.bold,
                                            ),
                                          ),
                                        ),

                                        //increment button
                                        GestureDetector(
                                          onTap:
                                          product.quantity == product.qntty
                                              ? null
                                              : () {
                                            cart.increment(product);
                                            //cart.add(cart.getitems[index]);
                                          },
                                          child: Container(
                                            height: 25,
                                            width: 25,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: CbColors.cbPrimaryColor2,
                                                width: 1,
                                              ),
                                              shape: BoxShape.circle,
                                              color: Colors.white,
                                            ),
                                            child: const Icon(
                                              Icons.add,
                                              color: CbColors.cbPrimaryColor2,
                                              size: 18,
                                            ),
                                          ),
                                        ),
                                      ],
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
                ),
              );
            },
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
