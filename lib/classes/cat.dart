import 'package:firebase_database/firebase_database.dart';

import '../utils/database.dart';

class Cat {

String name = '';
int birthYear = 0;
String imageUrl='';
int age=0;


Cat(this.name,this.birthYear,this.imageUrl){
     final DateTime now = DateTime.now();
     this.age= now.year - birthYear;

}
FirebaseDatabase database = FirebaseDatabase.instance;
static DatabaseReference reference = FirebaseDatabase.instance.ref('cat/');

//Add Birth Month later
 static void  addCat(name,birthYear,imageUrl) {
    

  reference.push().set({
    'name': name,  
    'birthYear':birthYear,
    'imageUrl':imageUrl
    });
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