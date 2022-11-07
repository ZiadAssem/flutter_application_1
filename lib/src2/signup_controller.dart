import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'authentication_repository.dart';


class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();


  //TextField Controllers to get data from TextFields
  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();


  //Call this Function from Design & it will do the rest
  void registerUser(String email, String password) {
    Get.put(AuthenticationRepository());
    String? error = Get.put(AuthenticationRepository.instance.createUserWithEmailAndPassword(email, password) as String?);
    if(error != null) {
      Get.showSnackbar(GetSnackBar(message: error.toString(),));
    }
  }


}