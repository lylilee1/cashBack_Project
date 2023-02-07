import 'package:cashback/src/constants/sizes.dart';
import 'package:cashback/src/constants/text_strings.dart';
import 'package:cashback/src/features/authentication/screens/forget_password/forget_password_mail/forget_password_mail.dart';
import 'package:cashback/src/features/authentication/screens/forget_password/forget_password_options/forget_password_btn_widget.dart';
import 'package:cashback/src/features/authentication/screens/forget_password/forget_password_phone/forget_password_phone.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

void buildShowModalBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(CbSizings.cbDefaultSize),
        topRight: Radius.circular(CbSizings.cbDefaultSize),
      ),
    ),
    builder: (context) => Container(
      padding: const EdgeInsets.all(CbSizings.cbDefaultSize),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(CbTextStrings.cbForgetPasswordTitle,
              style: Theme.of(context).textTheme.headline2),
          Text(
            CbTextStrings.cbForgetPasswordSubTitle,
            style: Theme.of(context).textTheme.bodyText2,
          ),
          const SizedBox(height: CbSizings.cbFormHeight),

          // -- Forget Password Mail Screen Btn --
          ForgetPasswordBtnWidget(
            btnIcon: Icons.mail_outline_rounded,
            title: CbTextStrings.cbEmail,
            subTitle: CbTextStrings.cbResetViaEmail,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ForgetPasswordMailScreen(),
                ),
              );
            },
          ),
          const SizedBox(height: CbSizings.cbFormHeight - 10.0),
          ForgetPasswordBtnWidget(
            btnIcon: Icons.mobile_friendly_rounded,
            title: CbTextStrings.cbSignUpPhone,
            subTitle: CbTextStrings.cbResetViaPhone,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ForgetPasswordPhoneScreen(),
                ),
              );
            },
          ),
        ],
      ),
    ),
  );
}
