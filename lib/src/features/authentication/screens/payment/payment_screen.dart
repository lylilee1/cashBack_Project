
import 'package:cashback/src/common_widgets/app_bar/appBarWidget.dart';
import 'package:cashback/src/constants/colors.dart';
import 'package:cashback/src/features/authentication/controllers/cart/cart_controller.dart';
import 'package:cashback/src/features/authentication/screens/main/main_screen2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:uuid/uuid.dart';

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

  void showProgress () {
    ProgressDialog progress = ProgressDialog(context: context);
    progress.show(max: 100, msg: 'S\'il vous plaît, attendez...', progressBgColor: CbColors.cbPrimaryColor2, /*msgColor: Colors.white, backgroundColor: Colors.white*/);
  }

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
          return Material(
            color: Colors.grey.shade200, //CbColors.cbPrimaryColor2,
            child: SafeArea(
              child: Scaffold(
                backgroundColor: Colors.grey.shade200,
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
                                        padding: const EdgeInsets.only(
                                            bottom: 100.0),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              'Payer à domicile ${totalPaid.toStringAsFixed(0)} XAF',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displaySmall!
                                                  .copyWith(
                                                  color: Colors.black),
                                            ),
                                            /*
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      _selectedValue = 1;
                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    height: 50,
                                                    width: 50,
                                                    decoration: BoxDecoration(
                                                      color: _selectedValue == 1
                                                          ? CbColors
                                                              .cbPrimaryColor2
                                                          : Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      boxShadow: const [
                                                        BoxShadow(
                                                          color: Colors.grey,
                                                          blurRadius: 1,
                                                          offset: Offset(0, 1),
                                                        ),
                                                      ],
                                                    ),
                                                    child: const Icon(
                                                      FontAwesomeIcons
                                                          .moneyBill,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      _selectedValue = 2;
                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    height: 50,
                                                    width: 50,
                                                    decoration: BoxDecoration(
                                                      color: _selectedValue == 2
                                                          ? CbColors
                                                              .cbPrimaryColor2
                                                          : Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      boxShadow: const [
                                                        BoxShadow(
                                                          color: Colors.grey,
                                                          blurRadius: 1,
                                                          offset: Offset(0, 1),
                                                        ),
                                                      ],
                                                    ),
                                                    child: const Icon(
                                                      FontAwesomeIcons
                                                          .creditCard,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),*/
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(top: 30.0, bottom: 30.0, left: 8.0, right: 8.0),
                                                child: SizedBox(
                                                  height: 50,
                                                  width: double.infinity,
                                                  child: ElevatedButton(
                                                    onPressed: () async {
                                                      showProgress();
                                                      for (var item in context.read<Cart>().getitems) {
                                                        CollectionReference orderRef  =
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                            'orders');
                                                        //give a value to the order id
                                                        _orderId = const Uuid().v4();//generate

                                                        await orderRef.doc(_orderId).set(
                                                            {
                                                              //Order information
                                                              'orderid':_orderId,
                                                              'ordername':item.name,
                                                              'orderimage':item.imagesUrl.first,
                                                              'orderqty':item.quantity,
                                                              'orderprice':item.quantity * item.price,
                                                              'orderdate':DateTime.now(),

                                                              //customer information
                                                              'cid':data['cid'],
                                                              'custname':data['name'],
                                                              'email':data['email'],
                                                              'phone':data['phone'],
                                                              'address':data['address'],
                                                              'profileimage':data['profileImage'],

                                                              //supplier information
                                                              'sid':item.suppId,

                                                              //product information
                                                              'proid':item.documentId,

                                                              //Quantity customer willing to buy
                                                              //Delivery status
                                                              'deliverystatus':'préparer la livraison',
                                                              'deliverydate':'',

                                                              //Payment status
                                                              'paymentstatus':'paiement à la livraison',
                                                              'paymentdate':'',
                                                              'paymentmethod':'',
                                                              'orderreview':false,
                                                              'orderreviewdate':'',
                                                            }).whenComplete(() async {
                                                          await FirebaseFirestore.instance.runTransaction((transaction) async {
                                                            DocumentReference documentReference = FirebaseFirestore.instance.collection('products').doc(item.documentId);
                                                            DocumentSnapshot snapshot2 = await transaction.get(documentReference);
                                                            transaction.update(documentReference, {
                                                              'instock': snapshot2['instock'] - item.quantity,
                                                            });
                                                          });
                                                        });
                                                      }

                                                      await Future.delayed(const Duration(microseconds: 100),).whenComplete((){
                                                        context.read<Cart>().clearCart();
                                                        Navigator.popUntil(context, ModalRoute.withName(MainScreen.routeName));
                                                      });


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
                  backgroundColor: Colors.transparent,
                  leading: const AppBarBackButton(),
                  title: const AppBarTitle(title: 'Paiement'),
                  centerTitle: true,
                ),

                body: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 60),
                  child: Column(
                    children: [
                      Container(
                        height: 120,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 1,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 16.0),
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
                      const SizedBox(height: 20),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 1,
                                offset: Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              RadioListTile(
                                value: 1,
                                groupValue: _selectedValue,
                                onChanged: (int? value) {
                                  setState(() {
                                    _selectedValue = value!;
                                  });
                                },
                                title: const Text('Paiement à la livraison'),
                                subtitle: const Text(
                                  /*'Payer à la livraison de votre commande'*/
                                    'Payer cash à domicile'),
                              ),
                              RadioListTile(
                                value: 2,
                                groupValue: _selectedValue,
                                onChanged: (int? value) {
                                  setState(() {
                                    _selectedValue = value!;
                                  });
                                },
                                title:
                                const Text('Payer par Visa ou Mastercard'),
                                subtitle: Row(
                                  children: const [
                                    Icon(
                                      Icons.payment,
                                      color: CbColors.cbPrimaryColor2,
                                    ),
                                    Icon(
                                      FontAwesomeIcons.ccMastercard,
                                      color: CbColors.cbPrimaryColor2,
                                    ),
                                    Icon(
                                      FontAwesomeIcons.ccVisa,
                                      color: CbColors.cbPrimaryColor2,
                                    ),
                                  ],
                                ),
                              ),
                              RadioListTile(
                                value: 3,
                                groupValue: _selectedValue,
                                onChanged: (int? value) {
                                  setState(() {
                                    _selectedValue = value!;
                                  });
                                },
                                title: const Text('Paiement par Paypal'),
                                subtitle: Row(
                                  children: const [
                                    Icon(
                                      FontAwesomeIcons.paypal,
                                      color: CbColors.cbPrimaryColor2,
                                    ),
                                    SizedBox(width: 10),
                                    Icon(
                                      FontAwesomeIcons.ccPaypal,
                                      color: CbColors.cbPrimaryColor2,
                                    ),
                                  ],
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
