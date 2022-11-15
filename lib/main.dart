import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/src2/authentication_repository.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'utils/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/homescreen.dart';
import 'classes/user.dart' as u;



void main ()  async{
   WidgetsFlutterBinding.ensureInitialized();
    final Future<FirebaseApp> _future = Firebase.initializeApp();

   await Firebase.initializeApp(options: DefaultFirebaseOptions.web);
   runApp( App());
   //runApp(HomePage());
   


}


class App extends StatelessWidget {
   App({super.key});
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      home: FutureBuilder(
        future: _initialization,
        builder: (context,snapshot){
          if(snapshot.hasError){
            print('Error');
          }
          if(snapshot.connectionState==ConnectionState.done){
            return HomeScreen();
          }
          return CircularProgressIndicator();
        },
      ) ,
      title: 'Dog Shelter',
      );
  }
}