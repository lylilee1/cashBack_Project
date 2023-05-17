import 'package:cashback/src/constants/colors.dart';
import 'package:cashback/src/features/authentication/screens/customer/minor_screen/current_orders_screen.dart';
import 'package:cashback/src/features/authentication/screens/customer/minor_screen/past_orders_screen.dart';
import 'package:flutter/material.dart';

class CustomerOrders extends StatefulWidget {
  const CustomerOrders({Key? key}) : super(key: key);

  @override
  State<CustomerOrders> createState() => _CustomerOrdersState();
}

class _CustomerOrdersState extends State<CustomerOrders>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int selectedValue = 0;
  int currentValueIndex = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
            ),
            child: Stack(
              children: [
                SafeArea(
                  //top: true,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: width,
                        height: 55,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TabBar(
                          isScrollable: false,
                          controller: tabController,
                          indicatorColor: Colors.grey!.withOpacity(0.8),
                          indicator: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 2,
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.white!.withOpacity(0.5),
                          indicatorSize: TabBarIndicatorSize.label,
                          onTap: (value) {
                            setState(() {
                              selectedValue = value;
                            });
                            tabController.animateTo(value);
                          },
                          //indicatorWeight: 5,
                          tabs: [
                            //Current Orders
                            Container(
                              width: width * 0.6,
                              height: 55,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: selectedValue == 0
                                    ? CbColors.cbPrimaryColor2!.withOpacity(0.5)
                                    : Colors.grey!.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: selectedValue == 0
                                    ? [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.3),
                                          blurRadius: 5,
                                          spreadRadius: 1,
                                          offset: const Offset(0, 1),
                                        ),
                                      ]
                                    : null,
                              ),
                              child: const Text(
                                'Current Orders',
                              ),
                            ),

                            //Past Orders
                            Container(
                              width: width * 0.6,
                              height: 55,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: selectedValue == 1
                                    ? CbColors.cbPrimaryColor2!.withOpacity(0.5)
                                    : Colors.grey!.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: selectedValue == 1
                                    ? [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.3),
                                          blurRadius: 5,
                                          spreadRadius: 1,
                                          offset: const Offset(0, 1),
                                        ),
                                      ]
                                    : null,
                              ),
                              child: const Text(
                                'Past Orders',
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      //
                      SizedBox(
                        //
                        height: height * 0.9,
                        child: TabBarView(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: tabController,
                          children: const [
                            CurrentOrdersScreenWidget(),
                            PastOrdersScreenWidget(),
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
      ),
    );
  }
}
