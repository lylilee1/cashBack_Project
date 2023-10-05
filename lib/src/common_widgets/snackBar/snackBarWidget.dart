
import 'package:flutter/material.dart';

class MyMessageHandler{
  static void showSnackBar(var scaffoldkey, String message){
    scaffoldkey.currentState!.hideCurrentSnackBar();
    scaffoldkey.currentState!.showSnackBar(SnackBar(
      duration: const Duration(seconds: 2),
      //backgroundColor: Colors.red,
      content: Text(
        message,
        //textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white),
      ),
    ));
  }
}