import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import 'utils/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/homescreen.dart';


void main ()  async{
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   //options: DefaultFirebaseOptions.currentPlatform,
  // );
   runApp(const App());
}
Future testUser({required String name})async{
}
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
      title: 'Dog Shelter',
      );
  }
}