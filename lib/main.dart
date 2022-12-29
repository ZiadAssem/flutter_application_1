import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/screens/adoptscreen.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';



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
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: _initialization,
        builder: (context,snapshot){
          if(snapshot.hasError){
            print('Error');
          }
          if(snapshot.connectionState==ConnectionState.done){
            //return const HomeScreen();
           return AdoptionScreen();
           //return SignUpScreen();
           // return AddCat();
          }
          return const CircularProgressIndicator();
        },
      ) ,
      title: 'Animal Rights Association',
      );
  }
}