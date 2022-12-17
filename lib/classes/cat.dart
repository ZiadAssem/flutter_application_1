import 'package:firebase_database/firebase_database.dart';

class Cat {

String name = '';
int birthYear = 0;

final String image;

Cat(this.name,this.birthYear,this.image){
     final DateTime now = DateTime.now();
     int age= now.year - birthYear;

}
FirebaseDatabase database = FirebaseDatabase.instance;
static DatabaseReference reference = FirebaseDatabase.instance.ref('cat/');

static void  addCat(String name,int birthYear) {
       final DateTime now = DateTime.now();
       int age= now.year - birthYear;

  reference.push().set({
    'Name': name, 
    'birthYear': birthYear, 
    'age':age
    });
}

}