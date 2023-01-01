import 'package:firebase_database/firebase_database.dart';

import '../model/database.dart';



class User {
  //final String uId;
  final String fullName;
  final String email;
  final String phoneNo;
  static String helperName = '';
  static bool isAdmin = false;
  
   User({required this.fullName,required this.email,required this.phoneNo,}){

    DbHelper.ref.set({
      
      "name": fullName,
      "phoneNo":phoneNo,
      "email":email
      
    });
  }

  static setIsAdmin(bool value){
    isAdmin = value;
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