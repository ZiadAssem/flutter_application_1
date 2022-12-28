
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_application_1/src2/authentication_repository.dart';

import '../utils/database.dart';
class Request{
 
 static requestCat(catName)async{

  Query query = DbHelper.getQuery('user')
  .startAt(AuthenticationRepository.auth.currentUser!.uid).endAt(AuthenticationRepository.auth.currentUser!.uid);
  final snapshot =await  query.get();
   Map user = snapshot.value as Map;
   user['key']=snapshot.key;
   var userName=user['fullName'];
  print(user['fullName']);
  DatabaseReference ref=DbHelper.database.ref('request');

  ref.push().set({
    'catName': catName,
   // 'userName': userName,
    'userId': AuthenticationRepository.auth.currentUser!.uid
  });


 }
  
  

}