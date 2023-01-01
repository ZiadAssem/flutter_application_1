import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/database.dart';
import 'package:get/get.dart';

import 'authentication_repository.dart';


class LoginController extends GetxController {
  static LoginController get instance => Get.find();


  /// TextField Controllers to get data from TextFields
  final email = TextEditingController();
  final password = TextEditingController();


  /// TextField Validation

  //Call this Function from Design & it will do the rest
  void loginUser(String email, String password)   async {
    Get.put(AuthenticationRepository());

    String? error =   '';
    error = Get.put(await AuthenticationRepository.instance.loginWithEmailAndPassword(email, password).
    then((value) => DbHelper.queryUserInfo()) as String ) ; 
    
    if(error != null) {
      Get.showSnackbar(
        GetSnackBar(
        duration:const Duration(seconds: 5),
        message: error.toString(),
        isDismissible: true,
        ));
      error=null;
    }


  }
}