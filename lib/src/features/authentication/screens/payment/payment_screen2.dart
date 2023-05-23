import 'package:cashback/src/common_widgets/app_bar/appBarWidget.dart';
import 'package:cashback/src/features/authentication/controllers/cart/cart_controller.dart';
import 'package:cashback/src/features/authentication/screens/main/main_screen2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:uuid/uuid.dart';

import '../../../../constants/colors.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int _selectedValue = 1;
  late String _orderId;
  CollectionReference customers =
      FirebaseFirestore.instance.collection('customers');

  void showProgress() {
    ProgressDialog progress = ProgressDialog(context: context);
    progress.show(
      max: 100,
      msg: 'S\'il vous plaît, attendez...',
      progressBgColor: CbColors
          .cbPrimaryColor2, /*msgColor: Colors.white, backgroundColor: Colors.white*/
    );
  }

  final GlobalKey<ScaffoldMessengerState> _scaffoldskey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    double totalPrice = context.watch<Cart>().totalPrice;
    double totalPaid = context.watch<Cart>().totalPrice + 2000.0;
    double shippingCoast = 2000.0;

    return FutureBuilder<DocumentSnapshot>(
      future: customers.doc(FirebaseAuth.instance.currentUser!.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Material(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          return Scaffold(
            //CbColors.cbPrimaryColor2,
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
                          onPressed: () {
                            if (_selectedValue == 1) {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) => SizedBox(
                                  height: height * 0.3,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 100.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          'Payer à domicile ${totalPaid.toStringAsFixed(0)} XAF',
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall!
                                              .copyWith(color: Colors.black),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 30.0,
                                                bottom: 30.0,
                                                left: 8.0,
                                                right: 8.0),
                                            child: SizedBox(
                                              height: 50,
                                              width: double.infinity,
                                              child: ElevatedButton(
                                                onPressed: () async {
                                                  showProgress();
                                                  for (var item in context
                                                      .read<Cart>()
                                                      .getitems) {
                                                    CollectionReference
                                                        orderRef =
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'orders');
                                                    //give a value to the order id
                                                    _orderId = const Uuid()
                                                        .v4(); //generate

                                                    await orderRef
                                                        .doc(_orderId)
                                                        .set({
                                                      //Order information
                                                      'orderid': _orderId,
                                                      'ordername': item.name,
                                                      'orderimage':
                                                          item.imagesUrl.first,
                                                      'orderqty': item.quantity,
                                                      'orderprice':
                                                          item.quantity *
                                                              item.price,
                                                      'orderdate':
                                                          DateTime.now(),

                                                      //customer information
                                                      'cid': data['cid'],
                                                      'custname': data['name'],
                                                      'email': data['email'],
                                                      'phone': data['phone'],
                                                      'address':
                                                          data['address'],
                                                      'profileimage':
                                                          data['profileImage'],

                                                      //supplier information
                                                      'sid': item.suppId,

                                                      //product information
                                                      'proid': item.documentId,

                                                      //Quantity customer willing to buy
                                                      //Delivery status
                                                      'deliverystatus':
                                                          'préparer la livraison',
                                                      'deliverydate': '',

                                                      //Payment status
                                                      'paymentstatus':
                                                          'paiement à la livraison',
                                                      'paymentdate': '',
                                                      'paymentmethod': '',
                                                      'orderreview': false,
                                                      'orderreviewdate': '',
                                                    }).whenComplete(() async {
                                                      await FirebaseFirestore
                                                          .instance
                                                          .runTransaction(
                                                              (transaction) async {
                                                        DocumentReference
                                                            documentReference =
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'products')
                                                                .doc(item
                                                                    .documentId);
                                                        DocumentSnapshot
                                                            snapshot2 =
                                                            await transaction.get(
                                                                documentReference);
                                                        transaction.update(
                                                            documentReference, {
                                                          'instock': snapshot2[
                                                                  'instock'] -
                                                              item.quantity,
                                                        });
                                                      });
                                                    });
                                                  }

                                                  await Future.delayed(
                                                    const Duration(
                                                        microseconds: 100),
                                                  ).whenComplete(() {
                                                    context
                                                        .read<Cart>()
                                                        .clearCart();
                                                    Navigator.popUntil(
                                                        context,
                                                        ModalRoute.withName(
                                                            MainScreen
                                                                .routeName));
                                                  });
                                                },
                                                style: ButtonStyle(
                                                  shape:
                                                      MaterialStateProperty.all(
                                                    RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                  ),
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                    CbColors.cbPrimaryColor2,
                                                  ),
                                                ),
                                                child: Text(
                                                  'Confirmer ${totalPaid.toStringAsFixed(0)} XAF',
                                                  style: const TextStyle(
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
                                ),
                              );
                            } else {}
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
                            'confirmer ${totalPaid.toStringAsFixed(0)} XAF'
                                .toUpperCase(),
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

            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.grey.shade200,
              leading: const AppBarBackButton(),
              centerTitle: true,
              title: const AppBarTitle(title: 'Paiement'),
            ),

            body: SafeArea(
              child: ScaffoldMessenger(
                key: _scaffoldskey,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 60),
                  child: Column(
                    children: [
                      //Payment info
                      Container(
                        height: 120,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2.5,
                              blurRadius: 5,
                              offset: const Offset(
                                  0, 5), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall!
                                        .copyWith(
                                          color: Colors.black,
                                        ),
                                  ),
                                  Text(
                                    totalPaid.toStringAsFixed(0) + ' XAF',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall!
                                        .copyWith(
                                          color: Colors.black,
                                        ),
                                  ),
                                ],
                              ),
                              const Divider(
                                color: CbColors.cbPrimaryColor2,
                                thickness: 2,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Commande totale',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall!
                                        .copyWith(
                                          color: Colors.black,
                                        ),
                                  ),
                                  Text(
                                    totalPrice.toStringAsFixed(0) + ' XAF',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall!
                                        .copyWith(
                                          color: Colors.black,
                                        ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Livraison',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall!
                                        .copyWith(
                                          color: Colors.black,
                                        ),
                                  ),
                                  Text(
                                    shippingCoast.toStringAsFixed(0) + ' XAF',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall!
                                        .copyWith(
                                          color: Colors.black,
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),

                      //cart items
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2.5,
                                blurRadius: 5,
                                offset: const Offset(
                                    0, 5), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              //Cash on delivery
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 10,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 2.5,
                                        blurRadius: 5,
                                        offset: const Offset(
                                            0, 5), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: RadioListTile(
                                    value: 1,
                                    groupValue: _selectedValue,
                                    onChanged: (int? value) {
                                      setState(() {
                                        _selectedValue = value!;
                                      });
                                    },
                                    title:Row(
                                      children: const [
                                        Icon(
                                          FontAwesomeIcons.cashRegister,
                                          //size: 35,
                                        ),
                                        SizedBox(width: 20),
                                        Text('Cash à la livraison'),
                                      ],
                                    ),
                                    /*subtitle: const Text(
                                        /*'Payer à la livraison de votre commande'*/
                                        'Payer cash à domicile'),*/
                                  ),
                                ),
                              ),

                              //Cash payment
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 10,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 2.5,
                                        blurRadius: 5,
                                        offset: const Offset(
                                            0, 5), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child:
                                  RadioListTile(
                                    value: 2,
                                    groupValue: _selectedValue,
                                    onChanged: (int? value) {
                                      setState(() {
                                        _selectedValue = value!;
                                      });
                                    },
                                    title: Row(
                                      children: const [
                                        Icon(
                                          FontAwesomeIcons.ccVisa,
                                        ),
                                        Icon(
                                          FontAwesomeIcons.ccMastercard,
                                        ),
                                        SizedBox(width: 20),
                                        Text('Visa/Mastercard'),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              //Paypal payment
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 10,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 2.5,
                                        blurRadius: 5,
                                        offset: const Offset(
                                            0, 5), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child:RadioListTile(
                                    value: 3,
                                    groupValue: _selectedValue,
                                    onChanged: (int? value) {
                                      setState(() {
                                        _selectedValue = value!;
                                      });
                                    },
                                    title: Row(
                                      children: const [
                                        Icon(
                                          FontAwesomeIcons.paypal,
                                        ),
                                        SizedBox(width: 10),
                                        Text('Paypal'),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              //Google payment
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 10,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 2.5,
                                        blurRadius: 5,
                                        offset: const Offset(
                                            0, 5), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child:RadioListTile(
                                    value: 4,
                                    groupValue: _selectedValue,
                                    onChanged: (int? value) {
                                      setState(() {
                                        _selectedValue = value!;
                                      });
                                    },
                                    title: Row(
                                      children: const [
                                        Icon(
                                          FontAwesomeIcons.googlePay,
                                          size: 35,
                                        ),
                                        SizedBox(width: 20),
                                        Text('Google Pay'),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              //Apple payment
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 10,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 2.5,
                                        blurRadius: 5,
                                        offset: const Offset(
                                            0, 5), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child:RadioListTile(
                                    value: 5,
                                    groupValue: _selectedValue,
                                    onChanged: (int? value) {
                                      setState(() {
                                        _selectedValue = value!;
                                      });
                                    },
                                    title: Row(
                                      children: const [
                                        Icon(
                                          FontAwesomeIcons.applePay,
                                          size: 35,
                                        ),
                                        SizedBox(width: 20),
                                        Text('Apple Pay'),
                                      ],
                                    ),
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
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
