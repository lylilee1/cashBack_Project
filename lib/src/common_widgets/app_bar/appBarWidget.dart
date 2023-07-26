import 'package:flutter/material.dart';

import '../../constants/app_styles.dart';
import '../../constants/colors.dart';
import '../../constants/size_config.dart';

class AppBarButton extends StatelessWidget {
  final Color? iconColor;
  final IconData prefixIcon;
  final VoidCallback onTap;

  const AppBarButton({
    super.key,
    required this.prefixIcon,
    required this.onTap, this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(
        prefixIcon,
        //if iconColor is null then use default color else use iconColor
        color: iconColor ?? CbColors.cbBlack,
      ),
    );
  }
}

class AppBarTitle extends StatelessWidget {
  final String title;
  final Color? iconColor;

  const AppBarTitle({
    super.key,
    required this.title, this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Text(
      title,
      style: cbMontserratBold.copyWith(
        fontSize: SizeConfig.blockSizeHorizontal! * 4,
        color: iconColor ?? CbColors.cbBlack,
      ),
    );
  }
}

class AppBarBackButton extends StatelessWidget {
  final Color? iconColor;
  const AppBarBackButton({
    Key? key, this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back_ios_new,
        color: iconColor ?? CbColors.cbBlack,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
