

import 'package:cashback/src/common_widgets/form/form_header_widget.dart';
import 'package:cashback/src/constants/sizes.dart';
import 'package:flutter/material.dart';

class ForgetPasswordOptionPageWidget extends StatelessWidget {
  const ForgetPasswordOptionPageWidget({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
    required this.labelText,
    required this.hintText,
    required this.prefixIcon,
    required this.textBtn,
    required this.onTap,
  });

  final String image, title, subTitle, labelText, hintText, textBtn;
  final IconData prefixIcon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: CbSizings.cbDefaultSize * 4),
        FormHeaderWidget(
          image: image,
          title: title,
          subTitle: subTitle,
          crossAxisAlignment: CrossAxisAlignment.center,
          heightBetween: CbSizings.cbDefaultSize,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: CbSizings.cbFormHeight),
        Form(
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: labelText,
                  hintText: hintText,
                  /*border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(CbSizings.cbDefaultSize),
                    ),
                  ),*/
                  prefixIcon: Icon(prefixIcon),
                ),
              ),
              const SizedBox(height: CbSizings.cbDefaultSize - 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onTap,
                  child: Text(textBtn),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}