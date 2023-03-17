

import 'package:cashback/src/constants/colors.dart';
import 'package:cashback/src/features/authentication/screens/subcategory/subcategory_products.dart';
import 'package:flutter/material.dart';

class SliderBar extends StatelessWidget {
  const SliderBar({
    super.key,
    required this.height,
    required this.width, required this.mainCategoryName,
  });

  final double height;
  final double width;
  final String mainCategoryName;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height * 0.8,
      width: width * 0.05,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade200.withOpacity(0.5),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: RotatedBox(
            quarterTurns: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                mainCategoryName == 'automobile'? const Text('') :
                Text(
                  '<<',
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Colors.black, letterSpacing: 10),
                ),
                Text(
                  mainCategoryName.toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(
                      color: CbColors.cbPrimaryColor2,
                      letterSpacing: 10),
                ),
                mainCategoryName == 'men'? const Text('') :
                Text(
                  '>>',
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Colors.black, letterSpacing: 10),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SubCategoryModel extends StatelessWidget {
  final String mainCategName;
  final String subCategName;
  final String assetName;
  final String subCategLabel;

  const SubCategoryModel({
    super.key,
    required this.subCategName,
    required this.mainCategName,
    required this.assetName,
    required this.subCategLabel,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SubCategoryProducts(
              mainCategName: mainCategName,
              subCategName: subCategName,
            ),
          ),
        );
      },
      child: Column(
        children: [
          SizedBox(
            height: 70,
            width: 70,
            child: Image(
              image: AssetImage(
                assetName,
              ),
            ),
          ),
          Text(
            subCategLabel,
          )
        ],
      ),
    );
  }
}

class CategoryHeaderLabel extends StatelessWidget {
  final String headerLabel;

  const CategoryHeaderLabel({
    super.key,
    required this.headerLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Text(
        headerLabel,
        style: Theme.of(context)
            .textTheme
            .displayMedium!
            .copyWith(color: CbColors.cbPrimaryColor2, letterSpacing: 1.5),
      ),
    );
  }
}