
import 'package:get/get.dart';
import 'package:liquid_swipe/PageHelpers/LiquidController.dart';

import '../../../constants/colors.dart';
import '../../../constants/image_strings.dart';
import '../../../constants/text_strings.dart';
import '../models/onboarding_screen_model.dart';
import '../screens/onboarding/on_boarding_page_widget.dart';

class OnBoardingScreenController extends GetxController{

  final controller = LiquidController();
  RxInt currentPage = 0.obs;


  final pages = [
    OnBoardingPageWidget(
      model: OnBoardingModel(
        image: cbOnBoardingImage1,
        title: cbOnBoardingTitle1,
        subTitle: cbOnBoardingSubTitle1,
        counterText: cbOnBoardingCounter1,
        bgColor: cbCardBgColor,
      ),
    ),
    OnBoardingPageWidget(
      model: OnBoardingModel(
        image: cbOnBoardingImage2,
        title: cbOnBoardingTitle2,
        subTitle: cbOnBoardingSubTitle2,
        counterText: cbOnBoardingCounter2,
        bgColor: cbOnBoardingPage3Color,
      ),
    ),
    OnBoardingPageWidget(
      model: OnBoardingModel(
        image: cbOnBoardingImage3,
        title: cbOnBoardingTitle3,
        subTitle: cbOnBoardingSubTitle3,
        counterText: cbOnBoardingCounter3,
        bgColor: cbOnBoardingPage2Color,
      ),
    ),
  ];


  skip() => controller.jumpToPage(page: 2);
  animateToNextSlide(){
    int nextPage = controller.currentPage + 1;
    controller.animateToPage(page: nextPage);
  }
  onPageChangeCallback(int activePageIndex) => currentPage.value = activePageIndex;

}