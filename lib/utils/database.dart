import 'package:firebase_database/firebase_database.dart';


class DbHelper{
static FirebaseDatabase database = FirebaseDatabase.instance;
static DatabaseReference ref = FirebaseDatabase.instance.ref();

static Query getQuery(String ref){
  return FirebaseDatabase.instance.ref(ref);
}


}

