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
  final  snapshot =await database.ref('user/$currentId/admin').once();
  Map adminMap = snapshot.snapshot.value as Map;

  //User.setIsAdmin(snapshot.snapshot.value as bool);  
  User.setIsAdmin(adminMap['admin']);
  }
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
}

