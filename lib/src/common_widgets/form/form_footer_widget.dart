import 'package:cashback/src/constants/image_strings.dart';
import 'package:cashback/src/constants/text_strings.dart';
import 'package:cashback/src/features/authentication/screens/login/login_screen.dart';
import 'package:flutter/material.dart';

class FormFooterWidget extends StatelessWidget {
  const FormFooterWidget({
    Key? key,
    required this.size,
    required this.image,
    required this.label,
    required this.text1,
    required this.text2,
    required this.onPressed,
  }) : super(key: key);

  final Size size;
  final String image, label, text1, text2;
  final VoidCallback onPressed;


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
            icon: Image(
                image: AssetImage(image)),
            label: Text(label.toUpperCase()),
          ),
        ),
        TextButton(
          onPressed: onPressed,
          child: Text.rich(
            TextSpan(
              text: text1,
              style: Theme.of(context).textTheme.bodyLarge,
              children: [
                TextSpan(
                  text: text2.toUpperCase(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
