

import 'package:cashback/src/constants/sizes.dart';
import 'package:cashback/src/constants/text_strings.dart';
import 'package:flutter/material.dart';

class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: CbSizings.cbFormHeight - 10),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
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
                onPressed: (){},
                child: Text(CbTextStrings.cbSignup.toUpperCase()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}