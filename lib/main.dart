import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'utils/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/homescreen.dart';


void main ()  async{
   WidgetsFlutterBinding.ensureInitialized();
   runApp( App());
}
Future testUser({required String name})async{
}
class App extends StatelessWidget {
   App({super.key});
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
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