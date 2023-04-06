import 'package:cashback/src/common_widgets/app_bar/appBarWidget.dart';
import 'package:flutter/material.dart';

class EditBusinessScreen extends StatelessWidget {
  const EditBusinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const AppBarTitle(title: 'Modifier l\'entreprise'),
        leading: const AppBarBackButton(),
      ),
    );
  }
}
