import 'cat.dart';
import 'user.dart';
class AdoptionForm{
  User user;
  Cat cat;
  late DateTime date;
  
  AdoptionForm(this.user, this.cat,){
    date = DateTime.now();
  }

}