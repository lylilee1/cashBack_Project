
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
    onBoardingPageWidget(
      model: OnBoardingModel(
        image: CbImageStrings.cbOnBoardingImage0,
        title: CbTextStrings.cbOnBoardingTitle1,
        subTitle: CbTextStrings.cbOnBoardingSubTitle1,
        counterText: CbTextStrings.cbOnBoardingCounter1,
        bgColor: CbColors.cbOnBoardingPage1Color,
        textColor: CbColors.cbBackgoundBleuDark,
      ),
    ),
    onBoardingPageWidget(
      model: OnBoardingModel(
        image: CbImageStrings.cbOnBoardingImage1,
        title: CbTextStrings.cbOnBoardingTitle2,
        subTitle: CbTextStrings.cbOnBoardingSubTitle2,
        counterText: CbTextStrings.cbOnBoardingCounter2,
        bgColor: CbColors.cbOnBoardingPage2Color,
        textColor: CbColors.cbOnBoardingPage1Color,
      ),
    ),
    onBoardingPageWidget(
      model: OnBoardingModel(
        image: CbImageStrings.cbOnBoardingImage2,
        title: CbTextStrings.cbOnBoardingTitle3,
        subTitle: CbTextStrings.cbOnBoardingSubTitle3,
        counterText: CbTextStrings.cbOnBoardingCounter3,
        bgColor: CbColors.cbOnBoardingPage3Color,
        textColor: CbColors.cbOnBoardingPage1Color,
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