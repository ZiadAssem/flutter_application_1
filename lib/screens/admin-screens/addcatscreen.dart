import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/reusable_widgets/reusable_widget.dart';
import '../../utils/database.dart';
import '../../classes/cat.dart';

class AddCat extends StatefulWidget {
  const AddCat({super.key});

  @override
  State<AddCat> createState() => _AddCatState();
}

class _AddCatState extends State<AddCat> {
    final formKey = GlobalKey<FormState>();
    final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
     MediaQueryData homeQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: appBarCustom(context,homeQuery)as PreferredSize,
      body:catForm(formKey, context, homeQuery) ,
    );
  }
}

Widget catForm(key,context,homeQuery){
  final nameController = TextEditingController();
  final birthController = TextEditingController();
  final imageController = TextEditingController();
  return Form(
    child: Column(
      children: [
        reusableTextField("Cat name", Icons.abc, false, nameController),
        const SizedBox(height: 5,),
        reusableTextField('Birth Year',Icons.calendar_month, false, birthController),
        const SizedBox(height: 5,),
        reusableTextField('Picture Drive link', Icons.portrait, false, imageController),
        const SizedBox(height: 5,),

        firebaseUIButton(context, 'Add Cat', 
        (){
          Cat.addCat(nameController.text.trim(),birthController.text.trim(),imageController.text.trim());
        },
        homeQuery.size.width*0.25 )
      ],
    ),
  );
}

Future<void> pickFile() async {
  
 var result = await FilePicker.platform.pickFiles(
  type: FileType.image,
 );

       if (result != null && result.files.isNotEmpty) {
  final fileBytes = result.files.first.bytes;
  final fileName = result.files.first.name;
  }

}