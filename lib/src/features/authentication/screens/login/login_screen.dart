import 'package:cashback/src/common_widgets/form/form_footer_widget.dart';
import 'package:cashback/src/constants/image_strings.dart';
import 'package:cashback/src/constants/sizes.dart';
import 'package:cashback/src/constants/text_strings.dart';
import 'package:cashback/src/features/authentication/screens/login/login_footer_widget.dart';
import 'package:cashback/src/features/authentication/screens/login/login_form_widget.dart';
import 'package:cashback/src/features/authentication/screens/login/login_header_widget.dart';
import 'package:cashback/src/features/authentication/screens/signup/signup_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
            child: Container(
          padding: const EdgeInsets.all(CbSizings.cbDefaultSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /* -- Section 1 -- */
              LoginHeaderWidget(size: size),
              /* -- /.end Section 1 -- */

              /* -- Section 2 [Form] -- */
              LoginFormWidget(),
              /* -- /.end Section 2 -- */

              /* -- Section 3 -- */
              FormFooterWidget(
                size: size,
                image: CbImageStrings.cbGoogleLogoImage,
                label: CbTextStrings.cbSignInWithGoogle,
                route: const SignUpScreen(),
                text1: CbTextStrings.cbDontHaveAnAccount,
                text2: CbTextStrings.cbSignup,
              ),
              /* -- /.end Section 3 -- */
            ],
          ),
        )),
      ),
    );
  }
}
