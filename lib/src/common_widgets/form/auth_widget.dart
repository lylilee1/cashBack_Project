import 'package:cashback/src/constants/colors.dart';
import 'package:cashback/src/constants/sizes.dart';
import 'package:cashback/src/constants/text_strings.dart';
import 'package:cashback/src/features/authentication/screens/supplier/upload_product_screen.dart';
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
          padding: EdgeInsets.symmetric(vertical: CbSizings.cbFormHeight -10),
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
  final int? maxlength, maxlins;
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
    this.emptyFieldError, this.onChanged, this.maxlength, this.maxlins, //this.controllerValue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        maxLength: maxlength,
        //maxLines: maxlins,
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
          else if (label == 'Prix'){
            if (value!.isEmpty) {
              return emptyFieldError;
            }
            else if (value.isValidPrice() != true) {
              return 'Format du montant invalide';
            }
            return null;
          }
          else if (label == 'Quantité'){
            if (value!.isEmpty) {
              return emptyFieldError;
            }
            else if (value.isValidQuantity() != true) {
              return 'Format de la Quantité invalide';
            }
            return null;
          }/*
          else if (label == 'Téléphone'){
            if (value!.isEmpty) {
              return emptyFieldError;
            }
            else if (value.isValidPhone() == false) {
              return 'Invalid phone number';
            }
            else if (value.isValidPhone() == true) {
              return null;
            }
            return null;
          }*/
          else{
            if (value!.isEmpty) {
              return emptyFieldError;
            }
            return null;
          }

        },
        //controller: controllerValue,
        onSaved: onChanged,
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

class TextFieldDecoration2 extends StatelessWidget {
  final String label, hintLabel;
  final String? emptyFieldError;
  final TextInputType? textType;
  final IconData? iconImage, iconImage2;
  final VoidCallback? onPressed;
  final bool? obscureText;
  final int? maxlength, maxlins;

  //final TextEditingController? controllerValue;
  final void Function(String?)? onChanged;

  const TextFieldDecoration2({
    super.key,
    required this.width,
    required this.label,
    required this.hintLabel,
    this.iconImage,
    this.textType,
    this.iconImage2,
    this.onPressed,
    this.obscureText,
    this.emptyFieldError,
    this.onChanged, this.maxlength, this.maxlins, //this.co
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width * 0.45,
      child: TextFormField(
        maxLength: maxlength,
        maxLines: maxlins,
        validator: (value) {
          if (value!.isEmpty) {
            return emptyFieldError;
          }
          return null;
        },
        //controller: controllerValue,
        onSaved: onChanged,
        obscureText: obscureText ?? false,
        keyboardType: textType,
        decoration: InputDecoration(
          label: Text(label), //
          hintText: hintLabel,
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
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(this);
  }

  /*
  bool emailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
  * */

}
/*
extension QuantityValidator on String {
  bool isValidQuantity (){
    return RegExp(r'^[1-9][0-9]*$').hasMatch(this);
  }
}

extension PriceValidator on String {
  bool isValidPrice (){
    return RegExp(r'^((([1-9][0-9]*[\.])||([0][\.]*)([0-9]{1,2}))$').hasMatch(this);
  }
}*/


extension QuantityValidator on String {
  bool isValidQuantity() {
    return RegExp(r'^[1-9][0-9]*$').hasMatch(this);
  }
}

extension PriceValidator on String {
  bool isValidPrice() {
    return RegExp(r'^((([1-9][0-9]*[\.]*)||([0][\.]*))([0-9]{1,2}))$')
        .hasMatch(this);
  }
}

extension DiscountValidator on String {
  bool isValidDiscount() {
    return RegExp(r'^([0-9]*)$').hasMatch(this);
  }
}


