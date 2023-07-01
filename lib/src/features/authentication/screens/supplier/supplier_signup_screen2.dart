import 'dart:io';

import 'package:cashback/src/common_widgets/form/auth_widget.dart';
import 'package:cashback/src/common_widgets/snackBar/snackBarWidget.dart';
import 'package:cashback/src/constants/colors.dart';
import 'package:cashback/src/constants/sizes.dart';
import 'package:cashback/src/constants/text_strings.dart';
import 'package:cashback/src/features/authentication/screens/supplier/supplier_signin_screen2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

/*
SIGNUP PAGE

This is the Sign Up page where the user can create an account.


When considering registering users into your app, you must consider AUTHENTICATION:

- email sign up
- google sign up
- apple sign up
- facebook sign up

Once the user us authenticated, they are directed to the sign in page

* */

class SupplierSignUpScreen extends StatefulWidget {
  static String routeName = '/SupplierSignUp';

  const SupplierSignUpScreen({super.key});

  @override
  _SupplierSignUpScreenState createState() => _SupplierSignUpScreenState();
}

class _SupplierSignUpScreenState extends State<SupplierSignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldkey =
  GlobalKey<ScaffoldMessengerState>();

  late String _uid;
  late String _storeName;
  late String _email;
  late String _password;
  late String storeLogo;

  bool processing = false;

  bool passwordNotVisible = true;

  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  dynamic _pickedImageError;

  CollectionReference suppliers = FirebaseFirestore.instance.collection('suppliers');

  //function to validate the form
  void signUp() async {
    //code to start the progress indicator
    setState(() {
      processing = true;
    });

    if (_formKey.currentState!.validate()) {
      try {
        _formKey.currentState!.save();

        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _email,
          password: _password,
        );

        try {
          await FirebaseAuth.instance.currentUser!.sendEmailVerification();
        } catch (e){
          print("An error occurred while trying to send email verification");
          print(e);
        }

        firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
            .ref('supp-images/$_email.jpg');
        await ref.putFile(File(_imageFile!.path),);
        _uid = FirebaseAuth.instance.currentUser!.uid;


        storeLogo = await ref.getDownloadURL();

        await FirebaseAuth.instance.currentUser!.updateDisplayName(_storeName);
        await FirebaseAuth.instance.currentUser!.updatePhotoURL(storeLogo);

        suppliers.doc(_uid).set({
          'storeName': _storeName,
          'email': _email,
          'phone': '',
          'address': '',
          'storeLogo': storeLogo,
          'sid': _uid,
          'coverImage': '',
        });

        //code to clear the form
        _formKey.currentState!.reset();
        setState(() {
          //code to clear the image
          _imageFile = null;
          //code to stop the progress indicator
          processing = false;
        });
        await Future.delayed(const Duration(microseconds: 100),).whenComplete(() => //if the user is successfully registered, then navigate to the home screen
        Navigator.pushReplacementNamed(context, SupplierSignInScreen.routeName));

      }
      on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          //code to stop the progress indicator
          setState(() {
            processing = false;
          });
          MyMessageHandler.showSnackBar(
              _scaffoldkey, 'The password provided is too weak.');
        }
        else if (e.code == 'email-already-in-use') {
          //code to stop the progress indicator
          setState(() {
            processing = false;
          });
          MyMessageHandler.showSnackBar(
              _scaffoldkey, 'The account already exists for that email.');
        }
      }
    }
    else {
      //code to stop the progress indicator
      setState(() {
        processing = false;
      });
      MyMessageHandler.showSnackBar(_scaffoldkey, 'please fill all the fields');
    }
  }

  //function to pick image from camera
  void _pickImageFromCamera() async {
    try{
      final pickedImage = await _picker.pickImage(
          source: ImageSource.camera,
          maxWidth: 300,
          maxHeight: 300,
          imageQuality: 95);

      setState(() {
        _imageFile = pickedImage;
      });
    } catch(e){
      setState(() {
        _pickedImageError = e;
      });
      print(_pickedImageError);
    }
  }

  //function to pick image from gallery
  void _pickImageFromGallery() async {
    try{
      final pickedImage = await _picker.pickImage(
          source: ImageSource.gallery,
          maxWidth: 300,
          maxHeight: 300,
          imageQuality: 95);

      setState(() {
        _imageFile = pickedImage;
      });
    } catch(e){
      setState(() {
        _pickedImageError = e;
      });
      print(_pickedImageError);
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
                    const SizedBox(
                      height: 20,
                    ),
                    //logo
                    const Icon(
                      Icons.app_registration_outlined,
                      size: 100,
                      color: CbColors.cbPrimaryColor2,
                    ),
                    Text(
                      'Create an account',
                      style:
                      Theme.of(context).textTheme.displayLarge!.copyWith(),
                    ),
                    const SizedBox(
                      height: 30,
                    ),

                    //Image picker
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 40),
                          child: CircleAvatar(
                            radius: 55,
                            backgroundColor: Colors.grey[300],
                            //if image is not picked or equal to null
                            backgroundImage: _imageFile == null
                            //show default image
                                ? null
                            //else show the image picked
                                : FileImage(File(_imageFile!.path)),
                          ),
                        ),
                        Column(
                          children: [
                            //pick from camera
                            Container(
                              decoration: const BoxDecoration(
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
                                icon: const Icon(Icons.camera_alt_outlined,
                                    color: Colors.white, size: 30),
                              ),
                            ),
                            const SizedBox(height: 5),
                            //pick from gallery
                            Container(
                              decoration: const BoxDecoration(
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
                                icon: const Icon(Icons.image_outlined,
                                    color: Colors.white, size: 30),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    //name
                    TextFieldDecoration(
                      label: CbTextStrings.cbName,
                      hintLabel: CbTextStrings.cbHintName,
                      iconImage: Icons.person_outline,
                      textType: TextInputType.name,
                      emptyFieldError: 'please enter your name',
                      onChanged: (value) {
                        _storeName = value!;
                      },
                    ),

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

                    // -- Terms and condition check Button --
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

                    //Sign Up button
                    processing == true
                        ? const CircularProgressIndicator()
                        : AuthMainButton(
                      label: CbTextStrings.cbSignup,
                      onPressed: () {
                        signUp();
                      },
                    ),

                    //already have an account
                    HaveAccount(
                      haveAccount: 'Already have an account?',
                      actionLabel: 'Sign In',
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, SupplierSignInScreen.routeName);
                      },
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
}
