import 'package:cashback/src/common_widgets/app_bar/appBarWidget.dart';
import 'package:cashback/src/constants/colors.dart';
import 'package:cashback/src/features/authentication/screens/supplier/delivered_orders_screen.dart';
import 'package:cashback/src/features/authentication/screens/supplier/preparing_orders_screen.dart';
import 'package:cashback/src/features/authentication/screens/supplier/shipping_orders_screen.dart';
import 'package:flutter/material.dart';

class SupplierOrder extends StatelessWidget {
  const SupplierOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: const AppBarBackButton(),
          backgroundColor: Colors.transparent,
          title: const AppBarTitle(title: 'Commande',),
          bottom: const TabBar(
            indicatorColor: CbColors.cbPrimaryColor2,
            indicatorWeight: 8,
            tabs: [
              Tab(
                text: 'En préparation',
              ),
              Tab(
                text: 'Expédition',
              ),
              Tab(
                text: 'Livré',
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            PreparingOrdersScreen(),
            ShippingOrdersScreen(),
            DeliveredOrdersScreen(),
          ],
        ),
      ),
    );
  }
}
