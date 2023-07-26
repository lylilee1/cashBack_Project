import 'package:cashback/src/constants/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../../common_widgets/form/auth_widget.dart';
import '../../../../../constants/app_styles.dart';
import '../../../../../constants/size_config.dart';
import 'current_orders_screen.dart';

class PastOrdersScreenWidget extends StatefulWidget {
  const PastOrdersScreenWidget({Key? key}) : super(key: key);

  @override
  State<PastOrdersScreenWidget> createState() => _PastOrdersScreenWidgetState();
}

class _PastOrdersScreenWidgetState extends State<PastOrdersScreenWidget> {
  late double _rating;
  late String _comment;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    DateTime minAgo = DateTime.now().subtract(
      const Duration(minutes: 1),
    );
    DateTime dayAgo = DateTime.now().subtract(
      const Duration(days: 1),
    );
    DateTime monthAgo = DateTime.now().subtract(
      const Duration(days: 31),
    );

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('orders')
          .where('cid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .where('deliverystatus', isEqualTo: 'livré')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text('you have not \n\n ordered anything yet!'),
          );
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            var order = snapshot.data!.docs[index];

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: CbColors.cbPrimaryColor2,
                  ),
                ),
                child: ExpansionTile(
                  title: Container(
                    constraints: const BoxConstraints(
                      maxWidth: 80,
                      maxHeight: 80,
                    ),
                    width: double.infinity,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            constraints: const BoxConstraints(
                              maxWidth: 80,
                              maxHeight: 80,
                            ),
                            child: Image.network(
                              order['orderimage'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                order['ordername'],
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                order['orderprice'].toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: order['orderprice']
                                                .toStringAsFixed(0),
                                            style: const TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                          const TextSpan(
                                            text: ' FCFA',
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          const TextSpan(
                                            text: 'x',
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                          TextSpan(
                                            text: order['orderqty'].toString(),
                                            style: const TextStyle(
                                              color: Colors.black,
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
                      ],
                    ),
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Voir plus ..',
                      ),
                      Text(
                        order['deliverystatus'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: CbColors.cbPrimaryColor2!.withOpacity(0.2),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: order['deliverystatus'] == 'livré'
                                    ? CbColors.cbPrimaryColor2!.withOpacity(0.2)
                                    : CbColors.cbOnBoardingPage3Color!
                                        .withOpacity(0.2),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                child: Column(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: SizeConfig.kPadding16,
                                        ),
                                        //order's payment status
                                        orderDetailList(
                                          order: order['paymentstatus'],
                                          orderDetail: 'Statut de paiement',
                                        ),

                                        //order's delivery status
                                        order['deliverystatus'] == 'expédition'
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5, bottom: 5, left: 5),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Statut de la commande',
                                                      style: cbMontserratBold
                                                          .copyWith(
                                                        fontSize: SizeConfig
                                                                .blockSizeHorizontal! *
                                                            3,
                                                      ),
                                                    ),
                                                    Text(
                                                      ('Date de livraison estimée') +
                                                          (order[
                                                              'deliverystatus']),
                                                      style: cbMontserratRegular
                                                          .copyWith(
                                                        fontSize: SizeConfig
                                                                .blockSizeHorizontal! *
                                                            3,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Container(),

                                        //order's delivery date
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5, bottom: 5, left: 5),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Informations sur la livraison',
                                                style:
                                                    cbMontserratBold.copyWith(
                                                  fontSize: SizeConfig
                                                          .blockSizeHorizontal! *
                                                      3,
                                                ),
                                              ),
                                              Text(
                                                order['deliverydate'] == ""
                                                    ? 'Pas encore de date de livraison'
                                                    : DateFormat('dd/MM/yyyy')
                                                        .format(
                                                        order['deliverydate']
                                                            .toDate(),
                                                      ),
                                                style: cbMontserratRegular
                                                    .copyWith(
                                                  fontSize: SizeConfig
                                                          .blockSizeHorizontal! *
                                                      3,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        //order's quantity
                                        orderDetailList(
                                          order: order['orderqty'].toString(),
                                          orderDetail: 'Quantité',
                                        ),

                                        //order's cancelation
                                        order['deliverystatus'] == 'livré'
                                            ? const SizedBox()
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 0, bottom: 5, left: 0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    TextButton(
                                                      onPressed: () {},
                                                      child: Text(
                                                        'Cliquez ici pour annuler votre commande',
                                                        style: cbMontserratBold
                                                            .copyWith(
                                                          fontSize: SizeConfig
                                                                  .blockSizeHorizontal! *
                                                              3,
                                                          color: CbColors
                                                              .cbPrimaryColor2,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                        //Write review button
                                        order['deliverystatus'] == 'livré' &&
                                                order['orderreview'] == false
                                            ? TextButton(
                                                onPressed: () {
                                                  showModalBottomSheet(
                                                    context: context,
                                                    shape:
                                                        const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(20),
                                                        topRight:
                                                            Radius.circular(20),
                                                      ),
                                                    ),
                                                    builder: (context) =>
                                                        Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              30.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          RatingBar.builder(
                                                            initialRating: 1,
                                                            minRating: 1,
                                                            allowHalfRating:
                                                                true,
                                                            itemBuilder:
                                                                (context, _) {
                                                              return const Icon(
                                                                Icons.star,
                                                                color: CbColors
                                                                    .cbPrimaryColor2,
                                                              );
                                                            },
                                                            onRatingUpdate:
                                                                (value) {
                                                              setState(() {
                                                                _rating = value;
                                                              });
                                                            },
                                                          ),
                                                          const SizedBox(
                                                            height: SizeConfig
                                                                .kPadding16,
                                                          ),

                                                          //Review Textfield
                                                          TextFieldDecoration(
                                                            label:
                                                                'Donnez votre avis',
                                                            hintLabel:
                                                                'àprpos de l\'article',
                                                            iconImage: Icons
                                                                .bookmark_add,
                                                            textType:
                                                                TextInputType
                                                                    .emailAddress,
                                                            emptyFieldError:
                                                                'please donnez votre avis',
                                                            onChanged: (value) {
                                                              _comment = value!;
                                                            },
                                                          ),

                                                          //Submit button
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 10),
                                                            child: SizedBox(
                                                              width: double
                                                                  .infinity,
                                                              child:
                                                                  ElevatedButton(
                                                                onPressed: () {},
                                                                child: Text(
                                                                  'Valider',
                                                                  style: cbMontserratBold
                                                                      .copyWith(
                                                                    fontSize:
                                                                        SizeConfig.blockSizeHorizontal! *
                                                                            3,
                                                                  ),
                                                                ),
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                  primary: CbColors
                                                                      .cbPrimaryColor2,
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),

                                                          //Cancel button
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 5),
                                                            child: Container(
                                                              width: double
                                                                  .infinity,
                                                              decoration:
                                                                  const BoxDecoration(),
                                                              child:
                                                                  ElevatedButton(
                                                                onPressed:
                                                                    () {
                                                                  Navigator.pop(context);
                                                                    },
                                                                child: Text(
                                                                  'Annuler',
                                                                  style: cbMontserratBold
                                                                      .copyWith(
                                                                    fontSize:
                                                                        SizeConfig.blockSizeHorizontal! *
                                                                            3,
                                                                    color: CbColors
                                                                        .cbBlack,
                                                                  ),
                                                                ),
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                  primary: CbColors
                                                                      .cbWhiteColor,
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Text(
                                                  'Écrire un avis',
                                                  style:
                                                      cbMontserratBold.copyWith(
                                                    fontSize: SizeConfig
                                                            .blockSizeHorizontal! *
                                                        3,
                                                    color: CbColors
                                                        .cbPrimaryColor2,
                                                  ),
                                                ))
                                            : Container(),

                                        //article's review
                                        order['deliverystatus'] == 'livré' &&
                                                order['orderreview'] == true
                                            ? Row(
                                                children: [
                                                  const Icon(Icons.check,
                                                      color: CbColors
                                                          .cbPrimaryColor2),
                                                  Text(
                                                    'Avis ajouté',
                                                    style: cbMontserratRegular
                                                        .copyWith(
                                                      fontSize: SizeConfig
                                                              .blockSizeHorizontal! *
                                                          3.5,
                                                      color: CbColors
                                                          .cbPrimaryColor2,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : Container(),
                                      ],
                                    )
                                  ],
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
            );
          },
        );
      },
    );
  }
}
