import 'package:cashback/src/common_widgets/Alert/alert_dialog.dart';
import 'package:cashback/src/common_widgets/app_bar/appBarWidget.dart';
import 'package:cashback/src/features/authentication/screens/dashboard/screens/edit_business_screen.dart';
import 'package:cashback/src/features/authentication/screens/dashboard/screens/manage_products_screen.dart';
import 'package:cashback/src/features/authentication/screens/dashboard/screens/my_store_screen.dart';
import 'package:cashback/src/features/authentication/screens/dashboard/screens/suppl_orders_screen.dart';
import 'package:cashback/src/features/authentication/screens/dashboard/screens/supplier_statics_screen.dart';
import 'package:cashback/src/features/authentication/screens/supplier/supplier_balance_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../main/main_screen2.dart';

List<String> label = [
  'magasin',
  'commandes',
  'profile',
  'gestion produits',
  'statistiques',
];

List<IconData> icons = [
  Icons.store,
  Icons.shopping_cart,
  Icons.edit,
  Icons.settings,
  Icons.attach_money,
  Icons.show_chart,
];

List<Widget> pages = [
  //MyStoreScreen(),
  SupplierOrdersScreen(),
  EditBusinessScreen(),
  ManageProductsScreen(),
  SupplierBalanceScreen(),
  SupplierStaticsScreen(),
];

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);
  static String routeName = '/Supplier_Dashboard';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: AppBarTitle(title: 'Dashboard'.toUpperCase()),
        actions: [
IconButton(
            onPressed: () {
              MyAlertDialog.showMyDialog(
                context: context,
                title: 'Log Out',
                content: 'Are you sure you want to logout?',
                onPressedNo: () {
                  Navigator.pop(context);
                },
                onPressedYes: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(
                      context, MainScreen.routeName);
                },
              );
            },
            icon: Icon(
              Icons.logout,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: height * 0.015, vertical: height * 0.03),
        child: GridView.count(
          childAspectRatio: 1.0,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          crossAxisCount: 2,
          children: List.generate(
            label.length,
            (index) => InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => pages[index],
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      icons[index],
                      color: Colors.black,
                      size: 50,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      label[index].toUpperCase(),
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
