import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SubCategoryProducts extends StatelessWidget {
  final String mainCategName;
  final String subCategName;
  const SubCategoryProducts({Key? key, required this.subCategName, required this.mainCategName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
        title: Text(subCategName, style: Theme.of(context).textTheme.headlineMedium!
            .copyWith(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Text(mainCategName),
      ),
    );
  }
}
