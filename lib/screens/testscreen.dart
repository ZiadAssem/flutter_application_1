import 'package:flutter/material.dart';

import '../classes/cat.dart';
import '../utils/database.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen>  {
  bool test = true;
  int counter = 0;
  List testList = ['h'];
  
  @override
  Widget build(BuildContext context) {
    
    return Container(
      child: Column(
        children: [
        Text('$test'),
        ElevatedButton(
          onPressed: ()async{
          
           testList = await DbHelper.getImageUrlFromFirebase();
           //await DbHelper.getImageUrlFromFirebase();
            counter++;


            setState(() {
              
              });
        }
        , child: Text(Cat.urlImages.elementAt(0))),
      ]),
    );
  }
}