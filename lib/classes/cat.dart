import 'package:age_calculator/age_calculator.dart';


class Cat {

String name = '';
int birthYear = 0;
int age = 0;

Cat(this.name,this.birthYear){
     final DateTime now = DateTime.now();
     age= now.year - birthYear;

}


}