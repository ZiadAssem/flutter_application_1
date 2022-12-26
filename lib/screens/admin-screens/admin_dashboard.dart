//import 'dart:html';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
//import 'package:pdf/widgets.dart';
import 'package:pdf/widgets.dart' as pw;
class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {

    return Container(
     
      
    );
  }
}
 Future openFile(File file)async{

  final url = file.path;
  await OpenFile.open(url);
}