import 'package:cashback/src/constants/colors.dart';
import 'package:cashback/src/constants/text_strings.dart';
import 'package:flutter/material.dart';

class AuthMainButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const AuthMainButton({
    super.key,
    required this.label,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: CbColors.cbPrimaryColor2,
          // padding: EdgeInsets.symmetric(vertical: CbSizings.cbFormHeight),
          /*shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),*/
        ),
        onPressed: onPressed,
        child: Text(label.toUpperCase()),
      ),
    );
  }
}

class HaveAccount extends StatelessWidget {
  final String haveAccount, actionLabel;
  final VoidCallback? onPressed;

  const HaveAccount({
    super.key,
    required this.haveAccount,
    required this.actionLabel,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          haveAccount, //
          style: Theme.of(context).textTheme.labelLarge!.copyWith(),
        ),
        TextButton(
          onPressed: onPressed, //() {}
          child: Text(
            actionLabel, //
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(color: CbColors.cbPrimaryColor2),
          ),
        ),
      ],
    );
  }
}

class TextFieldDecoration extends StatelessWidget {
  final String label, hintLabel;
  final String? emptyFieldError;
  final TextInputType? textType;
  final IconData? iconImage, iconImage2;
  final VoidCallback? onPressed;
  final bool? obscureText;
  //final TextEditingController? controllerValue;
  final void Function(String?)? onChanged;

  const TextFieldDecoration({
    super.key,
    required this.label,
    required this.hintLabel,
    this.iconImage,
    this.textType,
    this.iconImage2,
    this.onPressed,
    this.obscureText,
    this.emptyFieldError, this.onChanged, //this.controllerValue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        validator: (value) {
          if (label == CbTextStrings.cbSignUpEmail){
            if (value!.isEmpty) {
              return emptyFieldError;
            }
            else if (value.isValidEmail() == false) {
              return 'Invalid email address';
            }
            else if (value.isValidEmail() == true) {
              return null;
            }
            return null;
          }
          else{
            if (value!.isEmpty) {
              return emptyFieldError;
            }
            return null;
          }

        },
        //controller: controllerValue,
        onChanged: onChanged,
        obscureText: obscureText ?? false,
        keyboardType: textType,
        decoration: InputDecoration(
          label: Text(label), //
          hintText: hintLabel, //
          prefixIcon: Icon(
            iconImage, //
            //color: Colors.grey,
          ),
          suffixIcon: IconButton(
            onPressed: onPressed,
            icon: Icon(iconImage2, color: CbColors.cbPrimaryColor2),
          ),
        ),
      ),
    );
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            //r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            r"^([a-zA-Z0-9.]+)([\-\_\.]*)([a-zA-Z0-9.]*)([@])([a-zA-Z0-9]{2,})([\.][a-zA-Z]{2,3})$")
        .hasMatch(this);
  }
}
