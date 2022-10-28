import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/homescreen.dart';

void main(){
  runApp(App());
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