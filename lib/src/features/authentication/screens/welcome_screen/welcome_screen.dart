import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:splash_screen_with_animation/src/common_widgets/fade_in_animation/animation_design.dart';
import 'package:splash_screen_with_animation/src/constants/colors.dart';
import 'package:splash_screen_with_animation/src/constants/image_strings.dart';
import 'package:splash_screen_with_animation/src/constants/sizes.dart';
import 'package:splash_screen_with_animation/src/constants/text_strings.dart';
import 'package:splash_screen_with_animation/src/features/authentication/models/fade_in_animation_model.dart';

import '../../controllers/fade_in_animation_controller.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FadeInAnimationController());
    controller.startAnimation();

    var mediaQuery = MediaQuery.of(context);
    var height = mediaQuery.size.height;
    var brightness = mediaQuery.platformBrightness;
    var isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? cbSecondaryColor : cbPrimaryColor2,
      body: /*Center(
        child: 
        Text("Welcome"),
      ),*/
      Stack(
        children: [
          CbFadeInAnimation(
            durationInMs: 1200,
            animate: CbAnimationPosition(
              bottomAfter: 0,
              bottomBefore: -100,
              leftBefore: 0,
              leftAfter: 0,
              topBefore: 0,
              topAfter: 0,
              rightAfter: 0,
              rightBefore: 0,
            ),
            child: Container(
              padding: EdgeInsets.all(cbDefaultSize),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image(
                    image: AssetImage(cbWelcomeImage2),
                    height: height * 0.5,
                  ),
                  Column(
                    children: [
                      Text(
                        cbWelcomeTitle,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Text(
                        cbWelcomeSubTitle,
                        style: Theme.of(context).textTheme.bodyText1,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: (){},
                          child: Text(cbLogin.toUpperCase()),
                        ),
                      ),
                      const SizedBox(width: 20.0,),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: (){},
                          child: Text(cbSignup.toUpperCase()),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}
