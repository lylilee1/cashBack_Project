import 'package:cashback/src/common_widgets/form/form_header_widget.dart';
import 'package:cashback/src/constants/image_strings.dart';
import 'package:cashback/src/constants/text_strings.dart';
import 'package:flutter/material.dart';

class LoginHeaderWidget extends StatelessWidget {
  const LoginHeaderWidget({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormHeaderWidget(
            image: cbWelcomeImage1,
            title: CbTextStrings.cbLoginTitle,
            subTitle: CbTextStrings.cbLoginSubTitle),
      ],
    );
  }
}
