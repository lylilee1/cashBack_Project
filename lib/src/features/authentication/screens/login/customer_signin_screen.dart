import 'package:cashback/src/common_widgets/form/auth_widget.dart';
import 'package:cashback/src/common_widgets/form/form_footer_widget.dart';
import 'package:cashback/src/common_widgets/snackBar/snackBarWidget.dart';
import 'package:cashback/src/constants/colors.dart';
import 'package:cashback/src/constants/image_strings.dart';
import 'package:cashback/src/constants/sizes.dart';
import 'package:cashback/src/constants/text_strings.dart';
import 'package:cashback/src/features/authentication/screens/forget_password/forget_password_options/forget_password_model_bottom_sheet.dart';
import 'package:cashback/src/features/authentication/screens/login/login_header_widget.dart';
import 'package:cashback/src/features/authentication/screens/main/main_screen2.dart';
import 'package:cashback/src/features/authentication/screens/signup/customer_signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../profile/profile_screen2.dart';

class CustomerSignInScreen extends StatefulWidget {
  const CustomerSignInScreen({Key? key}) : super(key: key);
  static String routeName = '/CustomerSignIn';

  @override
  State<CustomerSignInScreen> createState() => _CustomerSignInScreenState();
}

class _CustomerSignInScreenState extends State<CustomerSignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldkey =
      GlobalKey<ScaffoldMessengerState>();

  late String _email;
  late String _password;

  bool processing = false;
  bool sendEmailVerification = false;

  bool passwordNotVisible = true;

  void signIn() async {

      setState(() {
        processing = true;
      });

      if (_formKey.currentState!.validate()) {
        try {
          _formKey.currentState!.save();

          await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _email,
            password: _password,
          );
          await FirebaseAuth.instance.currentUser!.reload();
          if (FirebaseAuth.instance.currentUser!.emailVerified) {

          //code to clear the form after submitting
          _formKey.currentState!.reset();
          setState(() {
            //code to stop the progress indicator
            processing = false;
          });

          await Future.delayed(const Duration(microseconds: 100),).whenComplete(() => Navigator.pushReplacementNamed(context, MainScreen.routeName)
            //Navigator.pushReplacementNamed(context, ProfileScreen.routeName)
          );
          }
          else {
            MyMessageHandler.showSnackBar(
                _scaffoldkey, 'please verify your email address');
            setState(() {
              processing = false;
              sendEmailVerification = true;
            });
          }

        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            setState(() {
              processing = false;
            });
            MyMessageHandler.showSnackBar(
                _scaffoldkey, 'No user found for that email.');
          } else if (e.code == 'wrong-password') {
            setState(() {
              processing = false;
            });
            MyMessageHandler.showSnackBar(
                _scaffoldkey, 'Wrong password provided for that user.');
          }
        }
      } else {
        setState(() {
          processing = false;
        });
        MyMessageHandler.showSnackBar(_scaffoldkey, 'please fill all the fields');
      }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ScaffoldMessenger(
      key: _scaffoldkey,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            reverse: true,
            child: Container(
              padding: const EdgeInsets.all(CbSizings.cbDefaultSize),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /* -- Section 1 -- */
                    LoginHeaderWidget(size: size),
                    /* -- /.end Section 1 -- */

                    /* -- Section 2 [Form] -- */
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: CbSizings.cbFormHeight - 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //email
                          TextFieldDecoration(
                            label: CbTextStrings.cbSignUpEmail,
                            hintLabel: CbTextStrings.cbHintSignUpEmail,
                            iconImage: Icons.email_outlined,
                            textType: TextInputType.emailAddress,
                            emptyFieldError: 'please enter your email address',
                            onChanged: (value) {
                              _email = value!;
                            },
                          ),

                          //password
                          TextFieldDecoration(
                            label: CbTextStrings.cbSignUpPassword,
                            hintLabel: CbTextStrings.cbHintSignUpPassword,
                            iconImage: Icons.fingerprint_outlined,
                            iconImage2: passwordNotVisible
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            onPressed: () {
                              setState(() {
                                passwordNotVisible = !passwordNotVisible;
                              });
                            },
                            obscureText: passwordNotVisible,
                            emptyFieldError: 'please enter your password',
                            onChanged: (value) {
                              _password = value!;
                            },
                          ),

                          // -- Forget Password Button --
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                buildShowModalBottomSheet(context);
                              },
                              child: const Text(
                                CbTextStrings.cbForgetPassword,
                                style: TextStyle(
                                  color: CbColors.cbPrimaryColor2,
                                  //fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),

                          //Sign In button
                          processing == true
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: CbColors.cbPrimaryColor2,
                                  ),
                                )
                              : AuthMainButton(
                                  label: CbTextStrings.cbLogin,
                                  onPressed: () {
                                    signIn();
                                  },
                                ),
                        ],
                      ),
                    ),
                    /* -- /.end Section 2 -- */

                    /* -- Section 3 -- */
                    FormFooterWidget(
                      size: size,
                      image: CbImageStrings.cbGoogleLogoImage,
                      label: CbTextStrings.cbSignInWithGoogle,
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, CustomerSignUpScreen.routeName);
                      },
                      text1: CbTextStrings.cbDontHaveAnAccount,
                      text2: CbTextStrings.cbSignup,
                    ),
                    /* -- /.end Section 3 -- */
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
