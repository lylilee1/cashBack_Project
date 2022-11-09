import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:splash_screen_with_animation/src/constants/colors.dart';
import 'package:splash_screen_with_animation/src/constants/image_strings.dart';
import 'package:splash_screen_with_animation/src/constants/sizes.dart';
import 'package:splash_screen_with_animation/src/constants/text_strings.dart';
import 'package:splash_screen_with_animation/src/features/authentication/controllers/on_boarding_screen_controller.dart';

import '../../models/onboarding_screen_model.dart';
import 'on_boarding_page_widget.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    final obController = OnBoardingScreenController();

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          LiquidSwipe(
            pages: obController.pages,
            liquidController: obController.controller,
            onPageChangeCallback: obController.onPageChangeCallback,
            //slideIconWidget: Icon(Icons.arrow_back_ios_new),
            //enableSideReveal: true,
          ),
          Positioned(
              bottom: 60.0,
              child: OutlinedButton
                (
                  onPressed: () => obController.animateToNextSlide(),
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(
                        color: cbPrimaryColor2
                    ),
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(10),
                    //onPrimary: Color.white,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(15.0),
                    decoration: const BoxDecoration(
                      color: cbPrimaryColor2,
                      shape: BoxShape.circle,
                    ),
                    /*child: const Icon(Icons.arrow_forward_ios),*/
                    child: SvgPicture.asset(
                      cbSvgArrow,
                      width: 10,
                    ),
                  ),
              ),
          ),
          Positioned(
            top: 30,
            right: 20,
            child: TextButton(
              onPressed: () => obController.skip(),
              child: const Text(
                "Skip",
                style: TextStyle(
                    color: cbPrimaryColor2
                ),
              ),
            ),
          ),
          Obx(
            () => Positioned(
              bottom: 10,
                child: AnimatedSmoothIndicator(
                  activeIndex: obController.currentPage.value,
                  count: 3,
                  effect: const WormEffect(
                    activeDotColor: cbPrimaryColor2,
                    dotHeight: 5.0,
                  ),
                ),
            ),
          ),
        ],
      ),
    );
  }

}



