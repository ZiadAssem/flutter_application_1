import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/cat.dart';
import 'package:flutter_application_1/classes/user.dart';
import 'package:flutter_application_1/src2/authentication_repository.dart';
import 'package:get/get.dart';


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


static getImageUrlFromFirebase()async{
  List<String> imageUrls=['h'];
  await
 FirebaseDatabase.instance.ref().child('imageUrl').once().then(( snapshot) {
   imageUrls = snapshot.snapshot.children.map((e) => e.value as String).toList();
  Cat.urlImages=imageUrls;
});
return imageUrls;
} 

static deleteRequest(String id)async{
  await FirebaseDatabase.instance.ref('request/$id').remove().then((value) =>  
  Get.showSnackbar(
    const GetSnackBar(
    duration: Duration(seconds: 1),
    message: 'Request Deleted Successfully',)
    )
    ).onError((error, stackTrace) => 
    Future<SnackbarController>.value(
      Get.showSnackbar(
        GetSnackBar(
          duration:const  Duration(seconds: 1),
          message: error.toString(),))
    )
    );
    
 
} 
static deleteRequestsWithCatId(catId)async{
  await FirebaseDatabase.instance.ref()
  .child('request')
  .orderByChild('catId')
  .equalTo('$catId')
  .once()
  .then(( snapshot) {
    Map<dynamic, dynamic> children = snapshot.snapshot.value as Map;
    children.forEach((key, value) {

      FirebaseDatabase.instance.ref()
        .child('request')        
        .child(key)
        .remove();
    });
  }).then((value) =>  Get.showSnackbar(const GetSnackBar(
    duration: Duration(seconds: 1),
    message: 'Request Deleted Successfully',)));
    
  
  
  
  
 
}
static acceptRequest(String requestId,String catId)async{
  //await FirebaseDatabase.instance.ref('request/$requestId').remove();
  deleteRequestsWithCatId(catId);
  await FirebaseDatabase.instance.ref('cat/$catId').remove();
  Get.showSnackbar(const GetSnackBar(
    duration: Duration(seconds: 1),
    message: 'Request accepted',));
}

static queryCatId(){
  return FirebaseDatabase.instance.ref('cat').orderByChild('catId') as Map;
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