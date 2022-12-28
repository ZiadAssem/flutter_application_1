import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_application_1/src2/authentication_repository.dart';

import '../utils/database.dart';

class Request {
  static requestCat(catName) async {
    final uId = AuthenticationRepository.auth.currentUser!.uid;
    // Query query = DbHelper.database.ref('user').orderByValue().equalTo(uId);

    // final snapshot = await query.get();
    // final user = snapshot.value as Map;

    // user['key'] = snapshot.key;
    // var userName = user['fullName'];
    final itemRef = DbHelper.database.ref('user/$uId');
    
    DatabaseReference ref = DbHelper.database.ref('request');

    itemRef.once().then((snapshot){
      Map snapshot2 = snapshot.snapshot.value as Map;
      var userName = snapshot2["fullName"];
      var phoneNo = snapshot2["phoneNo"];

       ref.push().set(
      {
      'catName': catName, 
      'userName': userName, 
      'userId': uId,
      'userPhoneNo': phoneNo,
      }
    );
    });


    // ref.push().set(
    //   {'catName': catName, 
    //   'userName': userName, 
    //   'userId': uId
    //   }
    // );
  }
}
