import 'package:cashback/src/constants/sizes.dart';
import 'package:cashback/src/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:google_fonts/google_fonts.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(CbSizings.cbDefaultSize),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                CbTextStrings.cbOtpTitle,
                style: GoogleFonts.montserrat(
                  fontSize: 80.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                CbTextStrings.cbOtpSubTitle.toUpperCase(),
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: CbSizings.cbDefaultSize + 10.0),
              const Text(
                "${CbTextStrings.cbOtpMessage}useremail@orixaslinks.com",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: CbSizings.cbDefaultSize - 10.0),
              OtpTextField(
                numberOfFields: 6,
                fillColor: Colors.black.withOpacity(0.1),
                //filled: true,
                borderColor: Colors.black,
                fieldWidth: 50,
                showFieldAsBox: true,
                onCodeChanged: (code) {
                  //Handle callback
                },
              ),
              const SizedBox(height: CbSizings.cbDefaultSize - 10.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text(CbTextStrings.cbNext),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
