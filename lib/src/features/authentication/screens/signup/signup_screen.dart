import 'package:cashback/src/common_widgets/form/form_footer_widget.dart';
import 'package:cashback/src/common_widgets/form/form_header_widget.dart';
import 'package:cashback/src/constants/image_strings.dart';
import 'package:cashback/src/constants/sizes.dart';
import 'package:cashback/src/constants/text_strings.dart';
import 'package:cashback/src/features/authentication/screens/customer/customer_hom_screen2.dart';
import 'package:cashback/src/features/authentication/screens/signup/widget/signup_form_widget.dart';
import 'package:flutter/material.dart';


class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  static String routeName = '/signup';

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
                const FormHeaderWidget(
                  image: cbWelcomeImage1,
                  title: CbTextStrings.cbSignUpTitle,
                  subTitle: CbTextStrings.cbSignUpSubTitle,
                ),
                const SignUpFormWidget(),
                FormFooterWidget(
                  size: size,
                  image: CbImageStrings.cbGoogleLogoImage,
                  label: CbTextStrings.cbSignUpWithGoogle,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CustomerHomeScreen(),
                      ),
                    );
                  },
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
