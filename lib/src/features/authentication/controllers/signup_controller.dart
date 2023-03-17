import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  //TextField Controllers to get data from TextFields
  final firstName   = TextEditingController();
  final lastName    = TextEditingController();
  final email       = TextEditingController();
  final phoneNo     = TextEditingController();
  final password    = TextEditingController();

  //Call this Function from Design & it will do the rest
  void registerUser(String email, String password){

  }

}