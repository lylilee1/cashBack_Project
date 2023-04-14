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
            onTap: () {},
          ),
        ],
      ),
      body: Consumer<Cart>(
        builder: (context, cart, child) {
          return cart.getitems.isEmpty
              ? const Center(
            child: Text('Panier vide'),
          )
              : ListView.builder(
            itemCount: cart.getitems.length, //cart.itemCount,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    height: 110,
                    margin: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 15.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 4,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
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

                        //image
                        SizedBox(
                          height: 80,
                          width: 80,
                          child: Image.network(
                            cart.getitems[index].imagesUrl.first,
                            fit: BoxFit.cover,
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 25.0),

                          //product name and price
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              //product name
                              Text(
                                cart.getitems[index].name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .copyWith(fontSize: height * 0.019),
                              ),

                              //product price
                              RichText(
                                text: TextSpan(
                                  text: cart.getitems[index].price
                                      .toStringAsFixed(0),
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
                          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),

                              //quantity
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  //decrement button
                                  GestureDetector(
                                    onTap: _decrement,
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
                                          color: Colors.grey),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text(
                                      _counter.value.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayLarge!
                                          .copyWith(fontSize: 20),
                                    ),
                                  ),

                                  //increment button
                                  GestureDetector(
                                    onTap: _increment,
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
                                      child: const Icon(Icons.add,
                                          color: Colors.grey),
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

              /*
                    return ListTile(
                      title: Text(cart.getitems[index].name),
                      subtitle: Text(cart.getitems[index].price.toString()),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          //cart.remove(cart.getitems[index]);
                        },
                      ),
                    );*/
            },
          );
        },
      ),

      /*Consumer<Cart>(
          builder: (context, cart, child) {
            return ListView.builder(
              itemCount: cart.itemCount,
              itemBuilder: (context, index) {
                return Text(cart.getitems[index].name);
              },
            );
            /*
        return cart.getitems.isEmpty ? Center(child: Text('Panier vide'),) : ListView.builder(
          itemCount: cart.getitems.length,
          itemBuilder: (context, index){
            return ListTile(
              title: Text(cart.getitems[index].name),
              subtitle: Text(cart.getitems[index].price.toString()),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: (){
                  cart.remove(cart.getitems[index]);
                },
              ),
            );
          },
        );*/
          },
        )*/

      /*Material(
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 40.0),
                  child: Text(
                    'La page que vous recherchez n\'existe pas ou a été déplacée.',
                    style: Theme.of(context).textTheme.displaySmall,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: height * 0.05),
                MaterialButton(
                  onPressed: () {
                    Navigator.canPop(context)
                        ? Navigator.pop(context)
                        :
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const CustomerHomeScreen()));
                  },
                  color: CbColors.cbPrimaryColor2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Text(
                    'Continuer vos achats',
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),*/

      /*
      bottomSheet: Row(
        children: [
          Container(
            height: height * 0.05,
            width: width * 0.5,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SvgPicture.asset(
                  CbImageStrings.cbSvgCart,
                  height: height * 0.03,
                  color: Colors.black87,
                ),
                /*Text(
                  'Panier',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: CbColors.cbPrimaryColor2, //Colors.white,
                      ),
                ),*/
                Text(
                  '00.00',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    color: CbColors.cbPrimaryColor2,//Colors.white,
                  ),
                ),
                Text(
                  '\XAF',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    color: CbColors.cbPrimaryColor2,//Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: height * 0.05,
            width: width * 0.5,
            decoration: BoxDecoration(
              color: CbColors.cbPrimaryColor2,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Commander',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: Colors.white,
                      ),
                ),
                SvgPicture.asset(
                  CbImageStrings.cbSvgBackArrow,
                  height: height * 0.02,
                ),
              ],
            ),
          ),
        ],
      ),*/
    );
  }
}
