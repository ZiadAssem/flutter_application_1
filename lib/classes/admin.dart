import 'package:flutter_application_1/classes/user.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_core/firebase_core.dart';

class Admin extends User{
  String department;
  Admin(fullName,phoneNo,email,this.department) : super(fullName:fullName, phoneNo:phoneNo, email:email);
}