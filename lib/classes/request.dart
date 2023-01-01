import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_application_1/model/authentication_repository.dart';

import '../model/database.dart';

class Request {
  
  static requestCat(catName,catId) async {
    final uId = AuthenticationRepository.auth.currentUser!.uid;
    
    final itemRef = DbHelper.database.ref('user/$uId');
    
    DatabaseReference ref = DbHelper.database.ref('request');

    itemRef.once().then((snapshot){
      Map userMap = snapshot.snapshot.value as Map;

      var userName = userMap["fullName"];
      var phoneNo = userMap["phoneNo"];

       ref.push().set(
      {
      'catName': catName,
      'catId':catId, 
      'userName': userName, 
      'userId': uId,
      'userPhoneNo': phoneNo,
      }
    );
    });


    
  }
}
