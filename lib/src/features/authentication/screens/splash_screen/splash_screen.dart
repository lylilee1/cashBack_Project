import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:splash_screen_with_animation/src/constants/colors.dart';
import 'package:splash_screen_with_animation/src/constants/image_strings.dart';
import 'package:splash_screen_with_animation/src/constants/sizes.dart';
import 'package:splash_screen_with_animation/src/constants/text_strings.dart';
import 'package:splash_screen_with_animation/src/features/authentication/models/fade_in_animation_model.dart';

import '../../../../common_widgets/fade_in_animation/animation_design.dart';
import '../../controllers/fade_in_animation_controller.dart';
import '../welcome_screen/welcome_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);


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
              leftAfter: cbDefaultSize,
              leftBefore: -80,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cbAppName,
                  style: Theme.of(context).textTheme.headline5,
                ),
                Text(
                  cbAppTagLine,
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
              rightAfter: cbDefaultSize,
              rightBefore: cbDefaultSize,
            ),
            child: Container(
              width: cbSplashContainerSize,
              height: cbSplashContainerSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: cbPrimaryColor2,
              ),

            ),
          ),
        ],
      ),
    );
  }


}


