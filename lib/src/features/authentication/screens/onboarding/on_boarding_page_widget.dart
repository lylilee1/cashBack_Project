
import 'package:flutter/material.dart';
import 'package:splash_screen_with_animation/src/constants/sizes.dart';

import '../../models/onboarding_screen_model.dart';

class OnBoardingPageWidget extends StatelessWidget {
  const OnBoardingPageWidget({
    Key? key,
    required this.model,
  }) : super(key: key);

  final OnBoardingModel model;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(cbDefaultSize),
      color: model.bgColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image(
            image: AssetImage(model.image),
            height: size.height * 0.55,
          ),
          Column(
            children: [
              Text(
                model.title,
                style: Theme.of(context).textTheme.headline6,
              ),
              Text(
                model.subTitle,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              SizedBox(height: 30.0,)
            ],
          ),
          Text(
              model.counterText,
              style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(
            height: 90.0,
          )
        ],
      ),
    );
  }
}