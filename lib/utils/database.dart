import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/cat.dart';
import 'package:flutter_application_1/classes/user.dart';
import 'package:flutter_application_1/src2/authentication_repository.dart';


class DbHelper{
static FirebaseDatabase database = FirebaseDatabase.instance;
static DatabaseReference ref = FirebaseDatabase.instance.ref();

static Query getQuery(String ref){
  return FirebaseDatabase.instance.ref(ref);
}

static isAdmin()async{
  if(AuthenticationRepository.auth.currentUser?.uid !=null){

  var currentId = AuthenticationRepository.auth.currentUser!.uid;
  DatabaseReference ref = FirebaseDatabase.instance.ref('user/$currentId/admin');
  final  snapshot =await ref.get();
 // Map adminMap = snapshot.value as Map;
  User.isAdmin=snapshot.value as bool ;
  User.setIsAdmin(snapshot.value as bool);
  return snapshot.value as bool;
  }
}

static isAdminTest()async{
 // if(AuthenticationRepository.auth.currentUser?.uid !=null){
  DatabaseReference ref = FirebaseDatabase.instance.ref('user/uFkR1Z1UoVTVUmbpDmgU7BXGT852/admin');
  final  snapshot =await ref.get();
  return snapshot.value as bool;
  //}
}

static int getCatCount(){
   DatabaseReference catRef=DbHelper.database.ref('cat');
    
    catRef.once().then((snapshot){
      Map cat = snapshot.snapshot.value as Map;
      Cat.catCounter = cat.length;
    });
    return Cat.catCounter;
}

static getCats()  async{

  Query catRef = getQuery('cat');

  DatabaseEvent catQuery =await catRef.once();
  // .then((snapshot) {
  //   Cat.catMapHelper = snapshot.snapshot.value as Map;
  //   Cat.catMapHelper['key'] = snapshot.snapshot.key;
    
  //   });

  //final snapshot =   catRef.get();
 // Cat.cat = snapshot.value as Map;
  //Map catMap = snapshot.value as Map;
  // Cat.cat = catRef.get().snapshot.value as Map;

  // Cat.cat['key'] = catQuery.snapshot.key;
  }



static getImageUrlFromFirebase()async{
  List<String> imageUrls=['h'];
  await
 FirebaseDatabase.instance.ref().child('imageUrl').once().then(( snapshot) {
   imageUrls = snapshot.snapshot.children.map((e) => e.value as String).toList();
  Cat.urlImages=imageUrls;
});
return imageUrls;
} 

// static getUrlImages()async{
//   final ref =  FirebaseDatabase.instance
//                 .ref().child('imageUrl/').get();

//  await ref.then((snapshot) {
//     var imageKey = snapshot.key;
//     if(snapshot.value!=null){
//       var imageUrl = snapshot.value;
//       Cat.urlImages.add(imageUrl);
//     }
//   });
//     // ((snapshot) {
//     //   var imageKey = snapshot.key;
//     //   var imageUrl = snapshot.value;
//     //   });
                
  
//   //final snapshot = ref.value as List;
//   //List images =['cat'];  
  
//   // ref.forEach((key, value) {
//   //   images.add(value);
//   // });

//   // cat
//   // catMap.forEach((key,value){
//   //   urlImageList.add(value);
//   // });
  
//   Cat.urlImages.add('a') ;
//  // Cat.urlImages= ref.values.toList();

//   }

}