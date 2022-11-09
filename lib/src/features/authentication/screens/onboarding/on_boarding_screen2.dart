import 'package:cashback/src/constants/colors.dart';
import 'package:cashback/src/constants/image_strings.dart';
import 'package:cashback/src/constants/text_strings.dart';
import 'package:cashback/src/features/authentication/controllers/on_boarding_screen_controller.dart';
import 'package:cashback/src/features/authentication/models/onboarding_screen_model.dart';

import 'package:cashback/src/features/authentication/screens/onboarding/on_boarding_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
            liquidController: obController. controller,
            onPageChangeCallback: obController.onPageChangeCallback,
            pages: obController.pages,
            //slideIconWidget: Icon(Icons.arrow_back_ios),
            //enableSideReveal: true,
            //positionSlideIcon: 0.5,
          ),
          //button scroll page
          Positioned(
            child: OutlinedButton(
              onPressed: () => obController.animateToNextSlide(),
              style: ElevatedButton.styleFrom(
                side: const BorderSide(
                  color: Colors.black26,
                ),
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(20),
                foregroundColor: Colors.white,
              ),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: CbColors.cbSecondaryColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10.0,
                      spreadRadius: 1.0,
                      offset: Offset(3, 3),
                    ),
                  ],
                ),
                child: const Icon(Icons.arrow_forward_ios),
              ),
            ),
            bottom: 60.0,
          ),
          //skip button
          Positioned(
            top: 50,
            right: 20,
            child: TextButton(
              onPressed: () => obController.skip(),
              child: const Text(
                "Skip",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          Obx(
            () => Positioned(
              bottom: 10,
              child: AnimatedSmoothIndicator(
                activeIndex:obController.currentPage.value,
                count: 3 ,
                effect: const WormEffect(
                  activeDotColor: CbColors.cbSecondaryColor,
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




