import 'package:cashback/src/common_widgets/app_bar/appBarWidget.dart';
import 'package:cashback/src/constants/colors.dart';
import 'package:cashback/src/constants/text_strings.dart';
import 'package:cashback/src/features/authentication/models/cart/cart_model.dart';
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
          AppBarButton(
            prefixIcon: Icons.delete,
            onTap: () {
              context.read<Cart>().clearCart();
            },
          ),
        ],
      ),
      body: Consumer<Cart>(
        builder: (context, cart, child) {
          return cart.getitems.isEmpty
          //View if cart empty
              ? const Center(
            child: Text('Panier vide'),
          )

          //View if cart not empty
              : ListView.builder(
            itemCount: cart.getitems.length, //cart.itemCount,
            itemBuilder: (context, index) {
              final product = cart.getitems[index];

              return Column(
                children: [
                  Container(
                    height: 110,
                    margin: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 15.0),
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
                                        color: CbColors.cbPrimaryColor2,
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
                          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
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
                                      ?GestureDetector(
                                    onTap: () {
                                      cart.removeItem(product);
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
                                      child: const Icon(Icons.delete_forever,
                                        color: CbColors.cbPrimaryColor2, size: 15,),
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
                                      child: const Icon(Icons.remove,
                                        color: Colors.grey, size: 20,),
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
                                        color: CbColors.cbPrimaryColor2,
                                        fontWeight:
                                        FontWeight.bold,
                                      ),
                                    ),
                                  ),

                                  //increment button
                                  GestureDetector(
                                    onTap: product.quantity ==
                                        product.qntty
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
                                      child: const Icon(Icons.add,
                                        color: CbColors.cbPrimaryColor2, size: 18,),
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
              );
            },
          );
        },
      ),
    );
  }
}
