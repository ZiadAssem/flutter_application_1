import 'package:firebase_core/firebase_core.dart';

import 'utils/authentication.dart';
import 'package:flutter/material.dart';
//import 'firebase_options.dart';
import 'package:flutter_application_1/screens/homescreen.dart';

void main(){
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  runApp(const App());
}
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      title: 'Dog Shelter',
      );
  }
}