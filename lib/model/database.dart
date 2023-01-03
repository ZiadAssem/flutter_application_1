import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_application_1/classes/request.dart';
import 'package:get/get.dart';

import 'package:flutter_application_1/classes/cat.dart';
import 'package:flutter_application_1/classes/user.dart';
import 'package:flutter_application_1/model/authentication_repository.dart';

class DbHelper {
  static FirebaseDatabase database = FirebaseDatabase.instance;
  static late DatabaseReference ref;
  static late DatabaseReference refWithChild;

  static Query getQuery(String ref) {
    return FirebaseDatabase.instance.ref(ref);
  }




/*

request database functions

*/

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

// method to delete all remaining requests of same cat after accepting other request
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

 

 

/*

User Database functions

*/


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


static addUser(String uId,String name,String email,String phoneNo) {
    DatabaseReference reference = FirebaseDatabase.instance.ref('user/');
 reference.child(uId).set({
    
    'fullName': name, 
    'email': email, 
    'phoneNo':phoneNo,
    'admin':false,
    });
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

/*

Cat database functions

*/

static void addCat(name, birthYear, birthMonth, vaccinated, type, color, imageUrl) {
    DatabaseReference imageRef = FirebaseDatabase.instance.ref('imageUrl/');
    final reference = FirebaseDatabase.instance.ref('cat/');
    reference
        .push()
        .set({
          'name': name,
          'birthYear': birthYear,
          'birthMonth': birthMonth,
          'vaccinated': vaccinated,
          'type': type,
          'color': color,
          'imageUrl': imageUrl,
        })
        .whenComplete(() => Get.showSnackbar(const GetSnackBar(
              duration: Duration(seconds: 1),
              message: 'Cat Added Successfully',
            )))
        .onError((error, stackTrace) => Get.showSnackbar(GetSnackBar(
              duration: const Duration(seconds: 1),
              message: error.toString(),
            )));

    imageRef.push().set(imageUrl);
  }


  static requestCat(catName, catId) async {
    final uId = AuthenticationRepository.auth.currentUser!.uid;

    final itemRef = DbHelper.database.ref('user/$uId');

    DatabaseReference ref = DbHelper.database.ref('request');

    itemRef.once().then((snapshot) {
      Map userMap = snapshot.snapshot.value as Map;

      var userName = userMap["fullName"];
      var phoneNo = userMap["phoneNo"];

      ref.push().set({
        'catName': catName,
        'catId': catId,
        'userName': userName,
        'userId': uId,
        'userPhoneNo': phoneNo,
      });
    });
  }
  
 static queryCatId() {
    return FirebaseDatabase.instance.ref('cat').orderByChild('catId') as Map;
  }

  /*

  Buttons

  */

  static getButtons() async {
    
    final ref = FirebaseDatabase.instance.ref('Buttons/');
    final snapshot = await ref.get();

    Map buttons = snapshot.value as Map;
    Request.buttons = buttons;
    
    return buttons;
  }
}