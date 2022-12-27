import 'package:firebase_database/firebase_database.dart';

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

}