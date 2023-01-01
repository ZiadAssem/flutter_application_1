import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';



class Cat {

String name = '';
int birthYear = 0;
String imageUrl='';
int age=0;
static var catCounter=0;
static Map catMapHelper={};
static List<String> urlImages= ['h'];




Cat(this.name,this.birthYear,this.imageUrl){
     final DateTime now = DateTime.now();
     this.age= now.year - birthYear;

}




}