import 'package:cashback/src/constants/app_styles.dart';
import 'package:cashback/src/constants/sizes.dart';
import 'package:flutter/material.dart';

import '../../../../../constants/size_config.dart';

class ForgetPasswordBtnWidget extends StatelessWidget {
  const ForgetPasswordBtnWidget({
    super.key,
    required this.btnIcon,
    required this.title,
    required this.subTitle,
    required this.onTap,
  });

  final IconData btnIcon;
  final String title, subTitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          children: [
            Icon(
              btnIcon,
              size: CbSizings.cbFormHeight + 30,
            ),
            const SizedBox(width: CbSizings.cbDefaultSize - 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: cbMontserratBold.copyWith(
                    fontSize: SizeConfig.blockSizeHorizontal! * 3.5,
                  ),
                ),
                Text(
                  subTitle,
                  style: cbMontserratRegular.copyWith(
                    fontSize: SizeConfig.blockSizeHorizontal! * 3.5,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
