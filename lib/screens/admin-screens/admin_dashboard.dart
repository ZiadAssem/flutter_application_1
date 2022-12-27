import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../reusable_widgets/reusable_widget.dart';
import '../../utils/database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as fs;


class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  static Query ref = DbHelper.getQuery('requests');

  @override
  Widget build(BuildContext context) {
    MediaQueryData homeQuery = MediaQuery.of(context);
    return Scaffold(
     appBar: appBarCustom(context, homeQuery),
     body: Container(

      child: FirebaseAnimatedList(
        query: ref,
        itemBuilder:((context, snapshot, animation, index) {
          Map request = snapshot.value as Map;
          request['key']=snapshot.key;

          return listRequest(request: request);
        }) ,
        ),
     ),
    );
  }
}
Widget listRequest({required Map request}){
  return Card(
    child: Column(
      children: [
        Text(request['userId']),
        SizedBox(height: 5,),
        Text(request['cat']),

      ],
    ),
  );
}