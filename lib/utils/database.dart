import 'package:firebase_database/firebase_database.dart';


class DbHelper{
FirebaseDatabase database = FirebaseDatabase.instance;
static DatabaseReference ref = FirebaseDatabase.instance.ref();
}
