import 'package:flutter/material.dart';

import '../utils/database.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen>  {
  bool test = true;
  @override
  Widget build(BuildContext context) {
    
    return Container(
      child: Column(
        children: [
        Text('$test'),
        ElevatedButton(
          onPressed: ()async{
          
          test =await DbHelper.isAdminTest();

            setState(() {
              
              });
        }
        , child: Text("$test")),
      ]),
    );
  }
}