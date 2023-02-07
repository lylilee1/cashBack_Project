import 'package:cashback/src/common_widgets/form/form_header_widget.dart';
import 'package:cashback/src/constants/image_strings.dart';
import 'package:cashback/src/constants/sizes.dart';
import 'package:cashback/src/constants/text_strings.dart';
import 'package:cashback/src/features/authentication/screens/forget_password/forget_password_options_page/forget_password_options_page.dart';
import 'package:cashback/src/features/authentication/screens/forget_password/forget_password_otp/otp_screen.dart';
import 'package:flutter/material.dart';

class ForgetPasswordPhoneScreen extends StatelessWidget {
  const ForgetPasswordPhoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(CbSizings.cbDefaultSize),
            child: ForgetPasswordOptionPageWidget(
                image: CbImageStrings.cbForgetPasswordImage,
                title: CbTextStrings.cbForgetPassword,
                subTitle: CbTextStrings.cbResetViaPhone,
                labelText: CbTextStrings.cbSignUpPhone,
                hintText: CbTextStrings.cbHintSignUpPhone,
                prefixIcon: Icons.mobile_friendly_rounded,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OTPScreen(),
                    ),
                  );
                },
                textBtn: CbTextStrings.cbNext),
          ),
        ),
      ),
    );
  }
}
