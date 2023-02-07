import 'package:cashback/src/constants/image_strings.dart';
import 'package:cashback/src/constants/text_strings.dart';
import 'package:cashback/src/features/authentication/screens/login/login_screen.dart';
import 'package:flutter/material.dart';

class SignUpFooterWidget extends StatelessWidget {
  const SignUpFooterWidget({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("OR"),
        SizedBox(
          width: double.infinity,
          height: size.height * 0.07,
          child: OutlinedButton.icon(
            onPressed: () {},
            icon: const Image(
                image: AssetImage(CbImageStrings.cbGoogleLogoImage)),
            label: Text(CbTextStrings.cbSignUpWithGoogle.toUpperCase()),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ));
          },
          child: Text.rich(
            TextSpan(
              text: CbTextStrings.cbSignUpAlreadyHaveAccount,
              style: Theme.of(context).textTheme.bodyLarge,
              children: [
                TextSpan(
                  text: CbTextStrings.cbLogin.toUpperCase(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
