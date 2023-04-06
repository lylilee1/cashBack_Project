import 'package:cashback/src/common_widgets/app_bar/appBarWidget.dart';
import 'package:flutter/material.dart';

class SupplierStaticsScreen extends StatelessWidget {
  const SupplierStaticsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: AppBarTitle(title: 'Statistiques Fournisseur'.toUpperCase()),
        leading: const AppBarBackButton(),
      ),
    );
  }
}
