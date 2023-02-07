import 'package:cashback/src/constants/sizes.dart';
import 'package:cashback/src/features/authentication/models/onboarding_screen_model.dart';
import 'package:flutter/material.dart';

class onBoardingPageWidget extends StatelessWidget {
  const onBoardingPageWidget({
    Key? key,
    required this.model,
  }) : super(key: key);

  final OnBoardingModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(CbSizings.cbDefaultSize),
        color: model.bgColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(
              image: AssetImage(model.image),
              height: model.height * 0.4,
            ),
            Column(
              children: [
                Text(
                    model.title,
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      fontSize: 23,
                    ),
                ),
                Text(
                  model.subTitle,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: model.textColor,
                  ),
                ),
              ],
            ),
            Text(model.counterText,style: Theme.of(context).textTheme.titleLarge,),
            SizedBox(height: 50.0)
          ],
        )
    );
  }
}