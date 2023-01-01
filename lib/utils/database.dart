import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/cat.dart';
import 'package:flutter_application_1/classes/user.dart';
import 'package:flutter_application_1/src2/authentication_repository.dart';
import 'package:get/get.dart';

class DbHelper {
  static FirebaseDatabase database = FirebaseDatabase.instance;
  static DatabaseReference ref = FirebaseDatabase.instance.ref();

  static Query getQuery(String ref) {
    return FirebaseDatabase.instance.ref(ref);
  }

// Checks if current user is an admin
  static isAdmin() async {
    if (AuthenticationRepository.auth.currentUser?.uid != null) {
      var currentId = AuthenticationRepository.auth.currentUser!.uid;
      DatabaseReference ref =
          FirebaseDatabase.instance.ref('user/$currentId/admin');
      final snapshot = await ref.get();
      User.isAdmin = snapshot.value as bool;
      User.setIsAdmin(snapshot.value as bool);
      return snapshot.value as bool;
    }
  }

  static getImageUrlFromFirebase() async {
    List<String> imageUrls = ['h'];
    await FirebaseDatabase.instance
        .ref()
        .child('imageUrl')
        .once()
        .then((snapshot) {
      imageUrls =
          snapshot.snapshot.children.map((e) => e.value as String).toList();
      Cat.urlImages = imageUrls;
    });
    return imageUrls;
  }

// method to decline request
  static deleteRequest(String id) async {
    await FirebaseDatabase.instance
        .ref('request/$id')
        .remove()
        .then((value) => Get.showSnackbar(const GetSnackBar(
              duration: Duration(seconds: 1),
              message: 'Request Deleted Successfully',
            )))
        .onError((error, stackTrace) =>
            Future<SnackbarController>.value(Get.showSnackbar(GetSnackBar(
              duration: const Duration(seconds: 1),
              message: error.toString(),
            ))));
  }

// method to delete all remaining requests of same cat
  static deleteRequestsWithCatId(catId) async {
    await FirebaseDatabase.instance
        .ref()
        .child('request')
        .orderByChild('catId')
        .equalTo('$catId')
        .once()
        .then((snapshot) {
      Map<dynamic, dynamic> children = snapshot.snapshot.value as Map;
      children.forEach((key, value) {
        FirebaseDatabase.instance.ref().child('request').child(key).remove();
      });
    }).then((value) => Get.showSnackbar(const GetSnackBar(
              duration: Duration(seconds: 1),
              message: 'Request Deleted Successfully',
            )));
  }

  static acceptRequest(String requestId, String catId) async {
    //await FirebaseDatabase.instance.ref('request/$requestId').remove();
    deleteRequestsWithCatId(catId);
    await FirebaseDatabase.instance.ref('cat/$catId').remove();
    Get.showSnackbar(const GetSnackBar(
      duration: Duration(seconds: 1),
      message: 'Request accepted',
    ));
  }

  static queryCatId() {
    return FirebaseDatabase.instance.ref('cat').orderByChild('catId') as Map;
  }

  static queryUserInfo() async {
    final currentId = AuthenticationRepository.auth.currentUser!.uid;
    final snapshot =
        await FirebaseDatabase.instance.ref('user/$currentId').get();
    final userMap = snapshot.value as Map;
    User.helperName = userMap['fullName'] as String;
    return userMap;
  }

  static deleteAccount() {
    final currentId = AuthenticationRepository.auth.currentUser!.uid;
    FirebaseDatabase.instance.ref('user/$currentId').remove();
  }
}
