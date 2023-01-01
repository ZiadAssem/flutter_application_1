import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../reusable_widgets/reusable_widget.dart';
import '../../model/database.dart';


class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  static Query ref = DbHelper.getQuery('request');

  @override
  Widget build(BuildContext context) {
    MediaQueryData homeQuery = MediaQuery.of(context);


    return Scaffold(
     appBar: appBarCustom(context, homeQuery,Container()),
     body:Container(),
    );
  }
}
