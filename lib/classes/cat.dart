class Cat {

String name = '';
int birthYear = 0;
int age = 0;
final String image;

Cat(this.name,this.birthYear,this.image){
     final DateTime now = DateTime.now();
     age= now.year - birthYear;

}


}