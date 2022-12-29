import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_application_1/classes/cat.dart';


class DbHelper{
static FirebaseDatabase database = FirebaseDatabase.instance;
static DatabaseReference ref = FirebaseDatabase.instance.ref();

static Query getQuery(String ref){
  return FirebaseDatabase.instance.ref(ref);
}

static int getCatCount(){
   DatabaseReference catRef=DbHelper.database.ref('cat');
    
    catRef.once().then((snapshot){
      Map cat = snapshot.snapshot.value as Map;
      Cat.catCounter = cat.length;
    });
    return Cat.catCounter;
}

static getCats()  async{

  Query catRef = getQuery('cat');

  DatabaseEvent catQuery =await catRef.once();
  // .then((snapshot) {
  //   Cat.catMapHelper = snapshot.snapshot.value as Map;
  //   Cat.catMapHelper['key'] = snapshot.snapshot.key;
    
  //   });

  //final snapshot =   catRef.get();
 // Cat.cat = snapshot.value as Map;
  //Map catMap = snapshot.value as Map;
  // Cat.cat = catRef.get().snapshot.value as Map;

  // Cat.cat['key'] = catQuery.snapshot.key;
  }
}

