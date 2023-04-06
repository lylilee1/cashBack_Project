import 'dart:io';

import 'package:cashback/src/common_widgets/snackBar/snackBarWidget.dart';
import 'package:cashback/src/constants/colors.dart';
import 'package:cashback/src/features/authentication/screens/supplier/supplier_signin_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SupplierSignUpScreen extends StatefulWidget {
  const SupplierSignUpScreen({Key? key}) : super(key: key);
  static String routeName = '/SupplierSignUp';

  @override
  State<SupplierSignUpScreen> createState() => _SupplierSignUpScreenState();
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

        firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
            .ref('suppl-images/$_email.jpg');
        await ref.putFile(File(_imageFile!.path),);
        _uid = FirebaseAuth.instance.currentUser!.uid;


        storeLogo = await ref.getDownloadURL();
        suppliers.doc(_uid).set({
          'storeName': _storeName,
          'email': _email,
          'phone': '',
          'address': '',
          'storeLogo': storeLogo,
          'sid': _uid,
        });

        //code to clear the form
        _formKey.currentState!.reset();
        setState(() {
          //code to clear the image
          _imageFile = null;
          //code to stop the progress indicator
          processing = false;
        });
        //if the user is successfully registered, then navigate to the home screen
        Navigator.pushReplacementNamed(context, SupplierSignInScreen.routeName);

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
    return Scaffold(
      body: Form(
        key: _scaffoldkey,
        child: Center(
          child: Card(
            elevation: 8,
            child: Container(
              padding: const EdgeInsets.all(32.0),
              constraints: const BoxConstraints(maxWidth: 350),
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
                        "Welcome to CashBack!",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        "Enter your email and password to continue.",
                        style: Theme.of(context).textTheme.bodySmall,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    _gap(),
                    TextFormField(
                      validator: (value) {
                        // add email validation
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }

                        bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value);
                        if (!emailValid) {
                          return 'Please enter a valid email';
                        }

                        return null;
                      },
                      onSaved: (value) {
                        _storeName = value!;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Nom du magasin',
                        hintText: 'Saisir Nom du magasin',
                        prefixIcon: Icon(Icons.email_outlined),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    _gap(),
                    TextFormField(
                      validator: (value) {
                        // add email validation
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }

                        bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value);
                        if (!emailValid) {
                          return 'Please enter a valid email';
                        }

                        return null;
                      },
                      onSaved: (value) {
                        _email = value!;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        hintText: 'Enter your email',
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
                          return 'Le mot de passe doit être au moins de 6 caractères';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _password = value!;
                      },
                      obscureText: !passwordNotVisible,
                      decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Enter your password',
                          prefixIcon: const Icon(Icons.lock_outline_rounded),
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(passwordNotVisible
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                passwordNotVisible = !passwordNotVisible;
                              });
                            },
                          )),
                    ),
                    /*
                    _gap(),
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
                    processing == true
                        ? const Center(child: CircularProgressIndicator(color: CbColors.cbPrimaryColor2,),)
                        :
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'Sign in',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        onPressed: () {
                          signUp();
                        },
                      ),
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
