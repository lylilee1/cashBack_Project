import 'dart:io';

import 'package:cashback/src/common_widgets/form/auth_widget.dart';
import 'package:cashback/src/common_widgets/snackBar/snackBarWidget.dart';
import 'package:cashback/src/constants/colors.dart';
import 'package:cashback/src/constants/sizes.dart';
import 'package:cashback/src/constants/text_strings.dart';
import 'package:cashback/src/features/authentication/screens/main/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CustomerSignUp extends StatefulWidget {
  const CustomerSignUp({Key? key}) : super(key: key);
  static String routeName = '/customerSignup';

  @override
  State<CustomerSignUp> createState() => _CustomerSignUpState();
}

class _CustomerSignUpState extends State<CustomerSignUp> {
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? password;

  //final _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldkey =
      GlobalKey<ScaffoldMessengerState>();
  bool passwordNotVisible = true;

  final ImagePicker _picker = ImagePicker();

  //variable for getting images from camera
  XFile? _imageFile;
    //dynamic variable for getting error from image picker
  dynamic _pickedImageError;

  //function for picking image from camera
  void _pickImageFromCamera() async {
    try {
      final pickedImage = await _picker.pickImage(
          source: ImageSource.camera,
          maxHeight: 300,
          maxWidth: 300,
          imageQuality: 95);

      setState(() {
        _imageFile = pickedImage;
      });
    } catch (e) {
      setState(() {
        _pickedImageError = e;
      });
      print(_pickedImageError);
    }
  }

  //function for picking image from gallery
  void _pickImageFromGallery() async {
    try {
      final pickedImage = await _picker.pickImage(
          source: ImageSource.gallery,
          maxHeight: 300,
          maxWidth: 300,
          imageQuality: 95);

      setState(() {
        _imageFile = pickedImage;
      });
    } catch (e) {
      setState(() {
        _pickedImageError = e;
      });
      print(_pickedImageError);
    }
  }

  void signUp() async {
    if (_formKey.currentState!.validate()) {
      try{
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email, password: password);
        Navigator.pushNamed(context, MainScreen.routeName);
      }
      on FirebaseAuthException catch(e){
        if (e.code == 'weak-password'){
          MyMessageHandler.showSnackBar(
              _scaffoldkey, 'The password provided is too weak.');
        }
        else if (e.code == 'email-already-in-use'){
          MyMessageHandler.showSnackBar(
              _scaffoldkey, 'The account already exists for that email.');
        }
      }
    }
    else {
      MyMessageHandler.showSnackBar(
          _scaffoldkey, 'please fill all fields');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldkey,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              reverse: true,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Sign Up',
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .copyWith()),
                            IconButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, MainScreen.routeName);
                              },
                              icon: Icon(Icons.home_work,
                                  color: CbColors.cbPrimaryColor2, size: 30),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 40),
                            child: CircleAvatar(
                              radius: 55,
                              backgroundColor: CbColors.cbPrimaryColor2,
                              backgroundImage: _imageFile == null ? null : FileImage(File(_imageFile!.path)),
                              /*
                              child: CircleAvatar(
                                radius: 60,
                                backgroundColor: CbColors.cbPrimaryColor2,
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundImage: AssetImage(
                                      'assets/images/user_images/user.gif'),
                                ),
                              ),*/
                            ),
                          ),
                          Column(
                            children: [
                              //pick from camera
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                  ),
                                  color: CbColors.cbPrimaryColor2,
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    _pickImageFromCamera();
                                  },
                                  icon: Icon(Icons.camera_alt_outlined,
                                      color: Colors.white, size: 30),
                                ),
                              ),
                              SizedBox(height: 5),
                              //pick from gallery
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                  ),
                                  color: CbColors.cbPrimaryColor2,
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    _pickImageFromGallery();
                                  },
                                  icon: Icon(Icons.image_outlined,
                                      color: Colors.white, size: 30),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      TextFieldDecoration(
                        label: CbTextStrings.cbFirstName,
                        hintLabel: CbTextStrings.cbHintFirstName,
                        iconImage: Icons.person_outline_rounded,
                        emptyFieldError: 'please enter your first name',
                        onChanged: (value) {
                          firstName = value!;
                        },
                      ),
                      TextFieldDecoration(
                        label: CbTextStrings.cbLastName,
                        hintLabel: CbTextStrings.cbHintLastName,
                        iconImage: Icons.person_outline_rounded,
                        emptyFieldError: 'please enter your last name',
                        onChanged: (value) {
                          lastName = value!;
                        },
                      ),
                      TextFieldDecoration(
                        label: CbTextStrings.cbSignUpEmail,
                        hintLabel: CbTextStrings.cbHintSignUpEmail,
                        iconImage: Icons.email_outlined,
                        textType: TextInputType.emailAddress,
                        emptyFieldError: 'please enter your email address',
                        onChanged: (value) {
                          email = value!;
                        },
                      ),
                      TextFieldDecoration(
                        label: CbTextStrings.cbSignUpPhone,
                        hintLabel: CbTextStrings.cbHintSignUpPhone,
                        iconImage: Icons.phone_android_outlined,
                        emptyFieldError: 'please enter your phone number',
                        onChanged: (value) {
                          phoneNumber = value!;
                        },
                      ),
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
                          password = value!;
                        },
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: false,
                            onChanged: (value) {},
                          ),
                          Text(
                            'I agree to the Terms and Conditions',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(),
                          ),
                        ],
                      ),
                      AuthMainButton(
                        label: CbTextStrings.cbSignup,
                        onPressed: () {
                        },
                      ),
                      HaveAccount(
                        haveAccount: 'Already have an account?',
                        actionLabel: 'Sign In',
                        onPressed: () {
                          signUp();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
