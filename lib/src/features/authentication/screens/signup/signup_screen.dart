import 'package:cashback/src/common_widgets/form/form_footer_widget.dart';
import 'package:cashback/src/common_widgets/form/form_header_widget.dart';
import 'package:cashback/src/constants/image_strings.dart';
import 'package:cashback/src/constants/sizes.dart';
import 'package:cashback/src/constants/text_strings.dart';
import 'package:cashback/src/features/authentication/screens/login/login_screen.dart';
import 'package:cashback/src/features/authentication/screens/signup/widget/signup_form_widget.dart';
import 'package:flutter/material.dart';

import 'widget/signup_footer_widget.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(CbSizings.cbDefaultSize),
            child: Column(
              children: [
                FormHeaderWidget(
                  image: cbWelcomeImage1,
                  title: CbTextStrings.cbSignUpTitle,
                  subTitle: CbTextStrings.cbSignUpSubTitle,
                ),
                SignUpFormWidget(),
                FormFooterWidget(
                  size: size,
                  image: CbImageStrings.cbGoogleLogoImage,
                  label: CbTextStrings.cbSignUpWithGoogle,
                  route: const LoginScreen(),
                  text1: CbTextStrings.cbSignUpAlreadyHaveAccount,
                  text2: CbTextStrings.cbLogin,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
