import 'package:cashback/src/constants/colors.dart';
import 'package:cashback/src/constants/sizes.dart';
import 'package:cashback/src/constants/text_strings.dart';
import 'package:cashback/src/features/authentication/controllers/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    final _formKey = GlobalKey<FormState>();

    return Container(
      padding: EdgeInsets.symmetric(vertical: CbSizings.cbFormHeight - 10),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: controller.firstName,
              decoration: const InputDecoration(
                label: Text(CbTextStrings.cbFirstName),
                hintText: CbTextStrings.cbHintFirstName,
                prefixIcon: Icon(
                  Icons.person_outline_rounded,
                  //color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: CbSizings.cbFormHeight - 20),
            TextFormField(
              controller: controller.lastName,
              decoration: const InputDecoration(
                label: Text(CbTextStrings.cbLastName),
                hintText: CbTextStrings.cbHintLastName,
                prefixIcon: Icon(
                  Icons.person_outline_rounded,
                  //color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: CbSizings.cbFormHeight - 20),
            TextFormField(
              controller: controller.email,
              decoration: const InputDecoration(
                label: Text(CbTextStrings.cbSignUpEmail),
                hintText: CbTextStrings.cbHintSignUpEmail,
                prefixIcon: Icon(
                  Icons.email_outlined,
                  //color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: CbSizings.cbFormHeight - 20),
            TextFormField(
              controller: controller.phoneNo,
              decoration: const InputDecoration(
                label: Text(CbTextStrings.cbSignUpPhone),
                hintText: CbTextStrings.cbHintSignUpPhone,
                prefixIcon: Icon(
                  Icons.phone_android_outlined,
                  //color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: CbSizings.cbFormHeight - 20),
            TextFormField(
              controller: controller.password,
              decoration: const InputDecoration(
                label: Text(CbTextStrings.cbSignUpPassword),
                hintText: CbTextStrings.cbHintSignUpPassword,
                prefixIcon: Icon(
                  Icons.fingerprint_outlined,
                  //color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: CbSizings.cbFormHeight - 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: CbColors.cbPrimaryColor2,
                  // padding: EdgeInsets.symmetric(vertical: CbSizings.cbFormHeight),
                  /*shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),*/
                ),
                onPressed: () {
                  if(_formKey.currentState!.validate()){
                    SignUpController.instance.registerUser(controller.email.text.trim(), controller.password.text.trim());
                  }
                },
                child: Text(CbTextStrings.cbSignup.toUpperCase()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
