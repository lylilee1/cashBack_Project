import 'package:cashback/src/common_widgets/app_bar/appBarWidget.dart';
import 'package:flutter/material.dart';

class ManageProductsScreen extends StatelessWidget {
  const ManageProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const AppBarTitle(title: 'Gestion de Produits'),
        leading: const AppBarBackButton(),
      ),
    );
  }
}
