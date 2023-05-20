import 'package:cashback/src/constants/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class CurrentOrdersScreenWidget extends StatefulWidget {
  const CurrentOrdersScreenWidget({Key? key}) : super(key: key);

  @override
  State<CurrentOrdersScreenWidget> createState() =>
      _CurrentOrdersScreenWidgetState();
}

class _CurrentOrdersScreenWidgetState extends State<CurrentOrdersScreenWidget> {
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
          .where('deliverystatus', isEqualTo: 'en préparation')
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
                padding: const EdgeInsets.only(bottom: 20),
                child: Container(
                  height: 160,
                  width: width,
                  decoration: BoxDecoration(
                    color: Colors.grey!.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: CbColors.cbPrimaryColor2),
                  ),
                  child: ExpansionTile(
                    title: Container(
                      constraints: const BoxConstraints(maxHeight: 130, maxWidth: 130),
                      width: double.infinity,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                timeago.format(order['orderdate'].toDate(),
                                    locale: 'fr'),
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(fontSize: height * 0.015),
                              ),
                              Text(
                                order['deliverystatus'],
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(fontSize: height * 0.016),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Container(
                                width: width * 0.6,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 90,
                                      height: 90,
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            top: 10,
                                            child: Container(
                                              width: 80,
                                              height: 80,
                                              decoration: BoxDecoration(
                                                //color: CbColors.cbPrimaryColor2!.withOpacity(0.5),
                                                borderRadius:
                                                BorderRadius.circular(20),
                                                border: Border.all(
                                                  color: CbColors.cbPrimaryColor2!
                                                      .withOpacity(0.5),
                                                  //width: 2,
                                                ),
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),

                                          //Image
                                          Container(
                                            width: 80,
                                            height: 80,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(20),
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  order['orderimage'],
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),

                                    //Order Name and Order Price
                                    Flexible(
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            order['ordername'],
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayLarge!
                                                .copyWith(
                                                fontSize: height * 0.017),
                                          ),
                                          Row(
                                            children: [
                                              RichText(
                                                text: TextSpan(
                                                  text: order['orderprice']
                                                      .toStringAsFixed(0),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displayLarge!
                                                      .copyWith(
                                                    fontSize: height * 0.017,
                                                    color: CbColors
                                                        .cbPrimaryColor2,
                                                    fontWeight:
                                                    FontWeight.bold,
                                                  ),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: ' FCFA',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .displayLarge!
                                                          .copyWith(
                                                        fontSize:
                                                        height * 0.017,
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
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              //Separator and Total Items
                              Flexible(
                                child: Row(
                                  children: [
                                    //Separator
                                    Container(
                                      width: 1,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: CbColors.cbPrimaryColor2!.withOpacity(0.15),),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),

                                    //Total Items and Time of order
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              text: 'Total : ',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displayLarge!
                                                  .copyWith(
                                                fontSize: height * 0.015,
                                              ),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: order['orderqty']
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displayLarge!
                                                      .copyWith(
                                                    fontSize: height * 0.016,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                          //Time of order
                                          Text( '21:40',
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium!
                                                .copyWith(fontSize: height * 0.015),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Voir plus ..',
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(
                            fontSize: height * 0.015,
                          ),
                        ),
                        Text(
                          order['deliverystatus'],
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(
                            fontSize: height * 0.015,
                          ),
                        ),
                      ],
                    ),
                    children: [
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          color: CbColors.cbPrimaryColor2!.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: CbColors.cbPrimaryColor2),
                        ),
                        child: Column(
                          children: [
                            //Order Name and Order Price
                            Container(
                              width: width,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    order['ordername'],
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge!
                                        .copyWith(
                                        fontSize: height * 0.017),
                                  ),
                                  Row(
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          text: order['orderprice']
                                              .toStringAsFixed(0),
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayLarge!
                                              .copyWith(
                                            fontSize: height * 0.017,
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
                                                fontSize: height * 0.017,
                                                color: CbColors.cbPrimaryColor2,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
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
    );
  }
}
