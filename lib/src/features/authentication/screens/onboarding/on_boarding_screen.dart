import 'package:cashback/src/constants/colors.dart';
import 'package:cashback/src/constants/image_strings.dart';
import 'package:cashback/src/constants/sizes.dart';
import 'package:cashback/src/constants/text_strings.dart';
import 'package:cashback/src/features/authentication/models/onboarding_screen_model.dart';
import 'package:cashback/src/features/authentication/screens/main/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'on_boarding_page_widget.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);
  static String routeName = '/onboarding';

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final controller = LiquidController();

  int currentPage = 0;
  bool procesing = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pages = [
      onBoardingPageWidget(
          model: OnBoardingModel(
        image: CbImageStrings.cbOnBoardingImage0,
        title: CbTextStrings.cbOnBoardingTitle1,
        subTitle: CbTextStrings.cbOnBoardingSubTitle1,
        counterText: CbTextStrings.cbOnBoardingCounter1,
        bgColor: CbColors.cbOnBoardingPage1Color,
        textColor: CbColors.cbBlueColor,
        height: size.height,
      )),
      onBoardingPageWidget(
          model: OnBoardingModel(
        image: CbImageStrings.cbOnBoardingImage1,
        title: CbTextStrings.cbOnBoardingTitle2,
        subTitle: CbTextStrings.cbOnBoardingSubTitle2,
        counterText: CbTextStrings.cbOnBoardingCounter2,
        bgColor: CbColors.cbOnBoardingPage2Color,
        textColor: CbColors.cbWhiteColor,
        height: size.height,
      )),
      onBoardingPageWidget(
          model: OnBoardingModel(
        image: CbImageStrings.cbOnBoardingImage2,
        title: CbTextStrings.cbOnBoardingTitle3,
        subTitle: CbTextStrings.cbOnBoardingSubTitle3,
        counterText: CbTextStrings.cbOnBoardingCounter3,
        bgColor: CbColors.cbOnBoardingPage3Color,
        textColor: CbColors.cbWhiteColor,
        height: size.height,
      )),
    ];

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          LiquidSwipe(
            pages: pages,
            liquidController: controller,
            onPageChangeCallback: onPageChangedCallback,
          ),
          //button scroll page
          Positioned(
            bottom: 60.0,
            child: OutlinedButton(
              onPressed: () async {
                if (currentPage == 2) {
                    await FirebaseAuth.instance
                        .signInAnonymously();/*
                        .whenComplete(() async {
                      _uid = FirebaseAuth.instance.currentUser!.uid;
                      await anonymous.doc(_uid).set({
                        'name': 'Invité',
                        'email': 'guest@example.com',
                        'profileimage': '',
                        'phone': '11111',
                        'address': 'Guest place area',
                        'cid': _uid
                      });
                    });*/

                    await Future.delayed(const Duration(microseconds: 100))
                        .whenComplete(() {
                      Navigator.pushReplacementNamed(
                          context, MainScreen.routeName);
                    });
                } else {
                  int nextPage = controller.currentPage + 1;
                  controller.animateToPage(
                    page: nextPage,
                    duration: 500,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                side: const BorderSide(
                  color: Colors.black26,
                ),
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(20),
                foregroundColor: Colors.white,
              ),
              child: Container(
                padding: const EdgeInsets.all(15),
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
          ),
          //skip button
          Positioned(
            top: 50,
            right: 20,
            child: TextButton(
              onPressed: () => controller.jumpToPage(page: 2),
              child: const Text(
                'Skip',
                style: TextStyle(color: CbColors.cbBlueColor),
              ),
            ),
          ),
          //page indicator
          Positioned(
            bottom: 10,
            child: AnimatedSmoothIndicator(
              count: 3,
              activeIndex: controller.currentPage,
              effect: const WormEffect(
                activeDotColor: CbColors.cbBlueColor,
                dotHeight: 5.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onPageChangedCallback(int activePageIndex) {
    setState(() {
      currentPage = activePageIndex;
    });
  }
}
