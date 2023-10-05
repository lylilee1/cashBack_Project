import 'package:cashback/src/common_widgets/form/auth_widget.dart';
import 'package:cashback/src/common_widgets/form/form_footer_widget.dart';
import 'package:cashback/src/common_widgets/snackBar/snackBarWidget.dart';
import 'package:cashback/src/constants/colors.dart';
import 'package:cashback/src/constants/image_strings.dart';
import 'package:cashback/src/constants/text_strings.dart';
import 'package:cashback/src/features/authentication/screens/forget_password/forget_password_options/forget_password_model_bottom_sheet.dart';
import 'package:cashback/src/features/authentication/screens/supplier/supplier_home_screen2.dart';
import 'package:cashback/src/features/authentication/screens/supplier/supplier_signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SupplierSignInScreen extends StatefulWidget {
  const SupplierSignInScreen({Key? key}) : super(key: key);
  static String routeName = '/SupplierSignIn';

  @override
  State<SupplierSignInScreen> createState() => _SupplierSignInScreenState();
}

class _SupplierSignInScreenState extends State<SupplierSignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldkey =
  GlobalKey<ScaffoldMessengerState>();

  late String _email;
  late String _password;

  bool processing = false;

  bool _isPasswordVisible = false;
  final bool _rememberMe = false;

  void signIn() async {
    setState(
          () {
        processing = true;
      },
    );

    if (_formKey.currentState!.validate()) {
      try {
        _formKey.currentState!.save();

        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email,
          password: _password,
        );

        //code to clear the form after submitting
        _formKey.currentState!.reset();
        setState(() {
          //code to stop the progress indicator
          processing = false;
        });

        Navigator.pushReplacementNamed(context, SupplierHomeScreen.routeName);
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
        body: Form(
          key: _formKey,
          child: Center(
            child: Container(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
              ),
              //padding: const EdgeInsets.all(32.0),
              //constraints: const BoxConstraints(maxWidth: 350),
              child: SingleChildScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                reverse: true,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const FlutterLogo(size: 100),
                    _gap(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "Bienvenue sur CashBack!",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        "Saisissez vos informations pour continuer.",
                        style: Theme.of(context).textTheme.bodySmall,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    _gap(),
                    TextFormField(
                      validator: (value) {
                        // add email validation
                        if (value == null || value.isEmpty) {
                          MyMessageHandler.showSnackBar(_scaffoldkey, 'Renseigner le champs');
                          return 'Renseigner le champs';
                        }

                        bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value);
                        if (!emailValid) {
                          return 'Saisir un email valide';
                        }

                        return null;
                      },
                      onSaved: (value) {
                        _email = value!;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        hintText: 'Saisir email',
                        prefixIcon: Icon(Icons.email_outlined),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    _gap(),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }

                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _password = value!;
                      },
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                          labelText: 'Mot de passe',
                          hintText: 'Saisir Mot de passe',
                          prefixIcon: const Icon(Icons.lock_outline_rounded),
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(_isPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          )),
                    ),
                    /*_gap(),
                    CheckboxListTile(
                      value: _rememberMe,
                      onChanged: (value) {
                        if (value == null) return;
                        setState(() {
                          _rememberMe = value;
                        });
                      },
                      title: const Text('Remember me'),
                      controlAffinity: ListTileControlAffinity.leading,
                      dense: true,
                      contentPadding: const EdgeInsets.all(0),
                    ),*/
                    _gap(),


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

                    /* -- Section 3 -- */
                    FormFooterWidget(
                      size: size,
                      image: CbImageStrings.cbGoogleLogoImage,
                      label: CbTextStrings.cbSignInWithGoogle,
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, SupplierSignUpScreen.routeName);
                      },
                      text1: CbTextStrings.cbDontHaveAnAccount,
                      text2: CbTextStrings.cbSignup,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _gap() => const SizedBox(height: 16);
}
