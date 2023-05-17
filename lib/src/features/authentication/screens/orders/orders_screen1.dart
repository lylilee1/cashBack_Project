import 'package:flutter/material.dart';

class CustomerOrders extends StatefulWidget {
  const CustomerOrders({Key? key}) : super(key: key);

  @override
  State<CustomerOrders> createState() => _CustomerOrdersState();
}

class _CustomerOrdersState extends State<CustomerOrders> {
  int pageIndex = 1;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),

            //Buttons for current and past orders
            Container(
              width: width,
              height: 55,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                /*boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 2,
                              offset:
                                  const Offset(0, 3), // changes position of shadow
                            ),
                          ],*/
              ),
              child: Row(
                children: [
                  pageIndex == 0
                      ? Flexible(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          pageIndex = 0;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Container(
                          width: (width - 45) / 2,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                            BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey
                                    .withOpacity(0.15),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0,
                                    5), // changes position of shadow
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Text(
                              'Current orders ',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                      : GestureDetector(
                    onTap: () {
                      setState(() {
                        pageIndex = 0;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Container(
                        width: (width - 45) / 2,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(20),
                        ),
                        child: const Center(
                          child: Text(
                            'Current orders ',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  pageIndex == 1
                      ? Flexible(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          pageIndex = 1;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Container(
                          width: (width - 45) / 2,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                            BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey
                                    .withOpacity(0.15),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0,
                                    5), // changes position of shadow
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Text(
                              'Past orders',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                      : GestureDetector(
                    onTap: () {
                      setState(() {
                        pageIndex = 1;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Container(
                        width: (width - 45) / 2,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(20),
                        ),
                        child: const Center(
                          child: Text(
                            'Past orders ',
                            style: TextStyle(
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
            const SizedBox(
              height: 30,
            ),

            //Current Orders details
            pageIndex == 0
                ? Column(
              children: [
                ExpansionTile(
                  title: Row(
                    children: [
                      Container(
                        height: 200,
                        width: width,
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color:
                              Colors.grey.withOpacity(0.15),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0,
                                  5), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'data',
                                    style: Theme.of(context).textTheme.headline6!.copyWith(
                                      //fontSize: 18,
                                      //fontWeight:
                                      //FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'data',
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
              ],
            )
                : Container(),
          ],
        ),
      ),
    );
  }
}
