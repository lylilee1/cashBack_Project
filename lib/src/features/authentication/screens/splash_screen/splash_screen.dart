

import 'package:cashback/src/common_widgets/fade_in_animation/animation_design.dart';
import 'package:cashback/src/constants/colors.dart';
import 'package:cashback/src/constants/image_strings.dart';
import 'package:cashback/src/constants/sizes.dart';
import 'package:cashback/src/constants/text_strings.dart';
import 'package:cashback/src/features/authentication/controllers/fade_in_animation_controller.dart';
import 'package:cashback/src/features/authentication/models/fade_in_animation_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static String routeName = '/splash';


  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FadeInAnimationController());
    controller.startSplashAnimation();

    return Scaffold(
      body: Stack(
        children: [
          
          CbFadeInAnimation(
            durationInMs: 1600,
            animate: CbAnimationPosition(
              topAfter: 0,
              topBefore: -30,
              leftAfter: 0,
              leftBefore: -30,
            ),
            child: const Image(image: AssetImage(cbSplashTopIcon)),
          ),
          CbFadeInAnimation(
            durationInMs: 2000,
            animate: CbAnimationPosition(
              topAfter: 80,
              topBefore: 80,
              leftAfter: CbSizings.cbDefaultSize,
              leftBefore: -80,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  CbTextStrings.cbAppName,
                  style: Theme.of(context).textTheme.headline5,
                ),
                Text(
                  CbTextStrings.cbAppTagLine,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ],
            ),
          ),
          CbFadeInAnimation(
            durationInMs: 2400,
            animate: CbAnimationPosition(
              bottomAfter: 100,
              bottomBefore: 0,
            ),
            child: const Image(
              image: AssetImage(cbSplashImage),
            ),
          ),
          CbFadeInAnimation(
            durationInMs: 2400,
            animate: CbAnimationPosition(
              bottomAfter: 60,
              bottomBefore: 0,
              rightAfter: CbSizings.cbDefaultSize,
              rightBefore: CbSizings.cbDefaultSize,
            ),
            child: Container(
              width: CbSizings.cbSplashContainerSize,
              height: CbSizings.cbSplashContainerSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: CbColors.cbPrimaryColor2,
              ),

            ),
          ),
        ],
      ),
    );
  }


}


