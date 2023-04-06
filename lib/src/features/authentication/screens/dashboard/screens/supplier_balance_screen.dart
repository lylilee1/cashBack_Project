import 'package:cashback/src/common_widgets/app_bar/appBarWidget.dart';
import 'package:flutter/material.dart';

class BalanceScreen extends StatelessWidget {
  const BalanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const AppBarTitle(title: 'Solde Fournisseur'),
        leading: const AppBarBackButton(),
      ),
    );
  }
}
