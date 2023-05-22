import 'package:cashback/src/constants/colors.dart';
import 'package:flutter/material.dart';

class YellowButton extends StatelessWidget {
  final String label;
  final Function() onPressed;
  final double width;
  const YellowButton(
      {Key? key,
      required this.label,
      required this.onPressed,
      required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width * width,
      decoration: BoxDecoration(
          color: CbColors.cbPrimaryColor2,
          /*gradient: const LinearGradient(
          colors: [Colors.green, Colors.blue]),*/
          borderRadius: BorderRadius.circular(20)),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          label,
        ),
      ),
    );
  }
}
