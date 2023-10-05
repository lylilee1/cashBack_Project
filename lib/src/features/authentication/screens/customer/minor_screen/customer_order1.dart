import 'package:cashback/src/constants/colors.dart';
import 'package:cashback/src/features/authentication/screens/customer/minor_screen/current_orders_screen.dart';
import 'package:cashback/src/features/authentication/screens/customer/minor_screen/past_orders_screen.dart';
import 'package:flutter/material.dart';

import '../../../../../common_widgets/app_bar/appBarWidget.dart';
import '../../../../../constants/app_styles.dart';
import '../../../../../constants/size_config.dart';
import '../../search/search_screen.dart';

class CustomerOrders extends StatefulWidget {
  final Widget? back;
  const CustomerOrders({Key? key, this.back}) : super(key: key);
  static String routeName = '/customerOrders';

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
    SizeConfig().init(context);

    return Scaffold(
      //app bar
      appBar: AppBar(
        backgroundColor: CbColors.cbPrimaryColor2,
        elevation: 0,
        leading: widget.back,
        title: const AppBarTitle(
          title: 'Mes commandes',
          iconColor: CbColors.cbWhiteColor,
        ),
        centerTitle: true,
        actions: [
          AppBarButton(
            prefixIcon: Icons.search,
            iconColor: CbColors.cbWhiteColor,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchScreen(),
                ),
              );
            },
          ),
        ],
      ),
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
                          indicatorColor: Colors.grey.withOpacity(0.8),
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
                          unselectedLabelColor: Colors.white.withOpacity(0.5),
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
                                    ? CbColors.cbPrimaryColor2.withOpacity(0.5)
                                    : Colors.grey.withOpacity(0.8),
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
                              child: Text(
                                'En cours',
                                style: cbMontserratBold,
                              ),
                            ),

                            //Past Orders
                            Container(
                              width: width * 0.6,
                              height: 55,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: selectedValue == 1
                                    ? CbColors.cbPrimaryColor2.withOpacity(0.5)
                                    : Colors.grey.withOpacity(0.8),
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
                              child: Text(
                                'Passées',
                                style: cbMontserratBold,
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
