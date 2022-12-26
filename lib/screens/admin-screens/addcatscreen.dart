// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/reusable_widgets/reusable_widget.dart';

// class AddCat extends StatefulWidget {
//   const AddCat({super.key});

//   @override
//   State<AddCat> createState() => _AddCatState();
// }

// class _AddCatState extends State<AddCat> {
//   @override
//   Widget build(BuildContext context) {
//      MediaQueryData homeQuery = MediaQuery.of(context);
//     return Scaffold(
//       appBar: appBarCustom(context,homeQuery)as PreferredSize,
//       body:Container(
//         child: TextButton(
//           child: Text('add Photo'),
//           onPressed: (){
//             pickFile();
//           },
//            ),
//       ) ,
//     );
//   }
// }

// Widget catForm(){
  
//   return Form(
//     child: Column(),
//   );
// }

// Future<void> pickFile() async {
  
//  var result = await FilePicker.platform.pickFiles(
//   type: FileType.image,
//  );

//        if (result != null && result.files.isNotEmpty) {
//   final fileBytes = result.files.first.bytes;
//   final fileName = result.files.first.name;
//   }

// }