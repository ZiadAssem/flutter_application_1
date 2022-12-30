import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';


import '../utils/database.dart';

class Cat {

String name = '';
int birthYear = 0;
String imageUrl='';
int age=0;
static var catCounter=0;
static Map catMapHelper={};




Cat(this.name,this.birthYear,this.imageUrl){
     final DateTime now = DateTime.now();
     this.age= now.year - birthYear;

}
FirebaseDatabase database = FirebaseDatabase.instance;
static DatabaseReference reference = FirebaseDatabase.instance.ref('cat/');

//Add Birth Month later
 static void  addCat(name,birthYear,birthMonth,vaccinated,type,color,imageUrl) {
    

  reference.push().set({
    'name': name,  
    'birthYear':birthYear,
    'birthMonth':birthMonth,
    'vaccinated':vaccinated,
    'type':type,
    'color':color,
    'imageUrl':imageUrl,
    
    }).whenComplete(() => 
     Get.showSnackbar(const GetSnackBar(message: 'Cat Added Successfully',))

    ).onError((error, stackTrace) => 
          Get.showSnackbar(GetSnackBar(message: error.toString(),))
    );
}
static  getCount(snapshot){
   Query ref = DbHelper.getQuery('cat');
   
   Map cat=snapshot.value as Map;
   cat['key']=snapshot.key;
   return cat.length;
  // reference.onValue.listen((event) {
  //   final data =event.snapshot.value;
  //   var count = data.

  // });  
}

}