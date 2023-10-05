import 'package:cashback/src/constants/sizes.dart';
import 'package:cashback/src/constants/text_strings.dart';
import 'package:cashback/src/features/authentication/screens/forget_password/forget_password_options/forget_password_model_bottom_sheet.dart';
import 'package:flutter/material.dart';

class LoginFormWidget extends StatelessWidget {
  const LoginFormWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Form(
      child: Container(
        padding:
            const EdgeInsets.symmetric(vertical: CbSizings.cbFormHeight - 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person_outline_outlined),
                labelText: CbTextStrings.cbEmail,
                hintText: CbTextStrings.cbHintEmail,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: CbSizings.cbFormHeight - 20),
            TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.fingerprint),
                labelText: CbTextStrings.cbPassword,
                hintText: CbTextStrings.cbHintPassword,
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: null,
                  icon: Icon(Icons.remove_red_eye_sharp),
                ),
              ),
            ),
            const SizedBox(height: CbSizings.cbFormHeight - 20),

            // -- Forget Password Button --
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  buildShowModalBottomSheet(context);
                },
                child: const Text(
                  CbTextStrings.cbForgetPassword,
                  style: TextStyle(
                    color: Colors.blue,
                    //fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: size.height * 0.07,
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  CbTextStrings.cbLogin.toUpperCase(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
