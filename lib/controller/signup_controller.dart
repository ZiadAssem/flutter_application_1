import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../classes/user.dart' as u;
import '../model/authentication_repository.dart';


class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();


  //TextField Controllers to get data from TextFields
  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();


  //Call this Function from Design & it will do the rest
  void registerUser(String email, String password,String fullName, String phoneNo) {
    Get.put(AuthenticationRepository());
    String? error = Get.put(AuthenticationRepository.instance
    .createUserWithEmailAndPassword(email, password).then((value) 
    => u.User.addUser(AuthenticationRepository.auth.currentUser!.uid,
     fullName, email, phoneNo)) as String);

     
    // Get.put(AuthenticationRepository.instance
    // .createUserWithEmailAndPassword(email, password)
    // .then((value) => u.User.addUser(
    //   AuthenticationRepository.auth.currentUser!.uid,
    //    fullName, email, phoneNo))
    //  as String?);

    if(error != null) {
      Get.showSnackbar(GetSnackBar(message: error.toString(),));
    }
    // else{
    //   var user =  AuthenticationRepository.auth.currentUser;
    //         var userId=user?.uid;
    //    u.User.addUser(
    //           userId!, 
    //       fullName, email, phoneNo);
    // }
  }


}