import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_application_1/src2/authentication_repository.dart';

import '../utils/database.dart';



class User {
  //final String uId;
  final String fullName;
  final String email;
  final String phoneNo;
   User({required this.fullName,required this.email,required this.phoneNo,}){

    DbHelper.ref.set({
      
      "name": fullName,
      "phoneNo":phoneNo,
      "email":email
      
    });
  }
//need to set the singleton later on
FirebaseDatabase database = FirebaseDatabase.instance;


static addUser(
  String uId,
  String name,String email,String phoneNo) {
    DatabaseReference reference = FirebaseDatabase.instance.ref('user/');
 reference.child(uId).set({
    
    'fullName': name, 
    'email': email, 
    'phoneNo':phoneNo,
    'admin':false,
    });
}

static bool isAdmin(){
  if (AuthenticationRepository.auth.currentUser != null){
    var currentUser = AuthenticationRepository.auth.currentUser;
    var uId = currentUser!.uid;
    DatabaseReference reference = FirebaseDatabase.instance.ref('user/$uId');

    
    // DataSnapshot snapshot1;
    // reference.child(uId).once().then((snapshot1 ) async {
      
    //   // Use the val() method on the snapshot to get the value of the 'admin' field
    //   bool isAdmin =await  snapshot1.value!['admin'];
    //   return isAdmin;
      
    // });
  }

  return false;
}
// void printFirebase(){
//   reference.once().then(
//     (event) 
//     {
//     final dataSnapshot = event.snapshot;
//     print('Data : ${dataSnapshot.value}');
//   }
//   );
// }
}