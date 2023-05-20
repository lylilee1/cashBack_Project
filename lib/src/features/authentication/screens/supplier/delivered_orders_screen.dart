import 'package:cashback/src/constants/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class DeliveredOrdersScreen extends StatelessWidget {
  const DeliveredOrdersScreen({Key? key}) : super(key: key);

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
          .where('sid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .where('deliverystatus', isEqualTo: 'délivré')
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
                      const Text(
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
                      width: double.infinity,
                      height: height * 0.2,
                      decoration: BoxDecoration(
                        color: CbColors.cbPrimaryColor2!.withOpacity(0.2),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ('Nom: ' + order['ordername']),
                            ),

                            //Order Status
                            Row(
                              children: [
                                const Text(
                                  'statut de livraison: ',
                                ),
                                Text(
                                  order['deliverystatus'],
                                ),
                              ],
                            ),

                            //Order Date
                            Row(
                              children: [
                                const Text(
                                  'date de commande: ',
                                ),
                                Text(
                                  (DateFormat('dd/MM/yyyy').format(
                                    order['orderdate'].toDate(),
                                  )).toString(),
                                ),
                              ],
                            ),

                            order['deliverystatus'] == 'délivré'
                                ? const Text('Cette commande a déjà été livrée')
                                :
                                //Delivery Status Change
                                Row(
                                    children: [
                                      const Text(
                                        'modifier le statut de la livraison: ',
                                      ),
                                      order['deliverystatus'] ==
                                              'en preparation'
                                          ? TextButton(
                                              onPressed: () {
                                                DatePicker.showDatePicker(
                                                  context,
                                                  maxTime: DateTime.now(),
                                                  minTime: DateTime.now().add(
                                                    const Duration(days: 365),
                                                  ),
                                                  onConfirm: (date) async {
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection('orders')
                                                        .doc(order['orderid'])
                                                        .update({
                                                      'deliverystatus':
                                                          'expédié',
                                                      'deliverydate': date,
                                                    });
                                                  },
                                                );
                                              },
                                              child: const Text('expédié ?'),
                                            )
                                          : TextButton(
                                              onPressed: () {},
                                              child: const Text('délivré ?'),
                                            ),
                                    ],
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
