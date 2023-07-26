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

class CurrentOrdersScreenWidget extends StatefulWidget {
  const CurrentOrdersScreenWidget({Key? key}) : super(key: key);

  @override
  State<CurrentOrdersScreenWidget> createState() =>
      _CurrentOrdersScreenWidgetState();
}

class _CurrentOrdersScreenWidgetState extends State<CurrentOrdersScreenWidget> {
  DateTime now = DateTime.now();

  void _CancelOrder() {
    FirebaseFirestore.instance.collection('orders').doc().update({
      'deliverystatus': 'annulé',
    });
  }

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
          .where('deliverystatus', isEqualTo: 'préparer la livraison')
          //.where('deliverystatus', isEqualTo: 'expédié')
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

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey!.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: CbColors.cbPrimaryColor2),
                  ),
                  child: ExpansionTile(
                    title: Container(
                      constraints: const BoxConstraints(
                        maxWidth: 80,
                        maxHeight: 80,
                      ),
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Commande: ',
                            style: cbMontserratBold.copyWith(
                              fontSize: SizeConfig.blockSizeHorizontal! * 3,
                            ),
                          ),
                          Text(
                            'Effectuée le: ',
                            style: cbMontserratBold.copyWith(
                              fontSize: SizeConfig.blockSizeHorizontal! * 3,
                            ),
                          ),
                          Text(
                            'Prix: ',
                            style: cbMontserratBold.copyWith(
                              fontSize: SizeConfig.blockSizeHorizontal! * 3,
                            ),
                          ),
                        ],
                      ),
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //order's name
                        Text(
                          '${order['ordername']}',
                          style: cbMontserratBold.copyWith(
                            fontSize: SizeConfig.blockSizeHorizontal! * 3,
                            color: CbColors.cbPrimaryColor2,
                          ),
                        ),

                        //order date
                        Text(
                          DateFormat('dd/MM/yyyy').format(
                            order['orderdate'].toDate(),
                          ),
                          style: cbMontserratBold.copyWith(
                            fontSize: SizeConfig.blockSizeHorizontal! * 3,
                            color: CbColors.cbPrimaryColor2,
                          ),
                        ),

                        //prix
                        Text(
                          '${order['orderprice'].toStringAsFixed(0)}',
                          style: cbMontserratBold.copyWith(
                            fontSize: SizeConfig.blockSizeHorizontal! * 3,
                            color: CbColors.cbPrimaryColor2,
                          ),
                        ),
                      ],
                    ),
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: order['deliverystatus'] == 'livré'
                              ? CbColors.cbPrimaryColor2!.withOpacity(0.2)
                              : CbColors.cbOnBoardingPage3Color!
                                  .withOpacity(0.2),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Column(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                                style:
                                                    cbMontserratBold.copyWith(
                                                  fontSize: SizeConfig
                                                          .blockSizeHorizontal! *
                                                      3,
                                                ),
                                              ),
                                              Text(
                                                ('Date de livraison estimée') +
                                                    (order['deliverystatus']),
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
                                          style: cbMontserratBold.copyWith(
                                            fontSize: SizeConfig
                                                    .blockSizeHorizontal! *
                                                3,
                                          ),
                                        ),
                                        Text(
                                          order['deliverydate'] == ""
                                              ? 'Pas encore de date de livraison'
                                              : DateFormat('dd/MM/yyyy').format(
                                                  order['deliverydate']
                                                      .toDate(),
                                                ),
                                          style: cbMontserratRegular.copyWith(
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
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 0, bottom: 5, left: 0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextButton(
                                          onPressed: _CancelOrder,
                                          child: Text(
                                            'Cliquez ici pour annuler votre commande',
                                            style: cbMontserratBold.copyWith(
                                              fontSize: SizeConfig
                                                      .blockSizeHorizontal! *
                                                  3,
                                              color: CbColors.cbPrimaryColor2,
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
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  topRight: Radius.circular(20),
                                                ),
                                              ),
                                              builder: (context) => Container(
                                                padding:
                                                    const EdgeInsets.all(30.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    RatingBar.builder(
                                                      initialRating: 1,
                                                      minRating: 1,
                                                      allowHalfRating: true,
                                                      itemBuilder:
                                                          (context, _) {
                                                        return const Icon(
                                                          Icons.star,
                                                          color: CbColors
                                                              .cbPrimaryColor2,
                                                        );
                                                      },
                                                      onRatingUpdate: (value) {
                                                        setState(() {
                                                          _rating = value;
                                                        });
                                                      },
                                                    ),
                                                    const SizedBox(
                                                      height:
                                                          SizeConfig.kPadding16,
                                                    ),
                                                    TextFieldDecoration(
                                                      label:
                                                          'enter your review',
                                                      hintLabel:
                                                          'about the article',
                                                      iconImage:
                                                          Icons.bookmark_add,
                                                      textType: TextInputType
                                                          .emailAddress,
                                                      emptyFieldError:
                                                          'please enter your email address',
                                                      onChanged: (value) {
                                                        _comment = value!;
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            'Écrire un avis',
                                            style: cbMontserratBold.copyWith(
                                              fontSize: SizeConfig
                                                      .blockSizeHorizontal! *
                                                  3,
                                              color: CbColors.cbPrimaryColor2,
                                            ),
                                          ))
                                      : Container(),

                                  //article's review
                                  order['deliverystatus'] == 'livré' &&
                                          order['orderreview'] == true
                                      ? Row(
                                          children: [
                                            const Icon(Icons.check,
                                                color:
                                                    CbColors.cbPrimaryColor2),
                                            Text(
                                              'Avis ajouté',
                                              style:
                                                  cbMontserratRegular.copyWith(
                                                fontSize: SizeConfig
                                                        .blockSizeHorizontal! *
                                                    3.5,
                                                color: CbColors.cbPrimaryColor2,
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
            );
          },
        );
      },
    );
  }
}

class orderDetailList extends StatelessWidget {
  const orderDetailList({
    super.key,
    required this.order,
    required this.orderDetail,
  });

  final String order;
  final String orderDetail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5, left: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            orderDetail,
            style: cbMontserratBold.copyWith(
              fontSize: SizeConfig.blockSizeHorizontal! * 3,
            ),
          ),
          Text(
            order,
            style: cbMontserratRegular.copyWith(
              fontSize: SizeConfig.blockSizeHorizontal! * 3,
            ),
          ),
        ],
      ),
    );
  }
}
