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

  late String _uid;
  late String _name;
  late String _email;
  late String _password;
  late String _profileImage;

  bool processing = false;

  bool passwordNotVisible = true;

  void signIn() async {
    setState(() {
      processing = true;
    });

    if (_formKey.currentState!.validate()) {
      try {
        _formKey.currentState!.save();
        /* print(_email);
                            print(_password);*/

        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _email,
          password: _password,
        );/*

        firebase_storage.Reference ref = firebase_storage.FirebaseStorage
            .instance
            .ref('cust-images/$_email.jpg');

        await ref.putFile(File(_imageFile!.path));
        _uid = FirebaseAuth.instance.currentUser!.uid;

        _profileImage = await ref.getDownloadURL();
        await customers.doc(_uid).set({
          'name': _name,
          'email': _email,
          'profileimage': _profileImage,
          'phone': '',
          'address': '',
          'cid': _uid,
        });*/

        //code to clear the form after submitting
        _formKey.currentState!.reset();
       /* setState(() {
          _imageFile = null;
        });*/


        Navigator.pushReplacementNamed(context, MainScreen.routeName);
      }
      on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          setState(() {
            processing = false;
          });
          MyMessageHandler.showSnackBar(
              _scaffoldkey, 'The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          setState(() {
            processing = false;
          });
          MyMessageHandler.showSnackBar(
              _scaffoldkey, 'The account already exists for that email.');
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
                          processing == true ? const CircularProgressIndicator() : AuthMainButton(
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
                        Navigator.pushReplacementNamed(context, CustomerSignUpScreen.routeName);
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
