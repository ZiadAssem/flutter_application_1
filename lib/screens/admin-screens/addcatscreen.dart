import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/mixins/validation_mixin.dart';
import 'package:flutter_application_1/reusable_widgets/reusable_widget.dart';
import 'package:flutter_application_1/src2/addcat_controller.dart';
import 'package:get/get.dart';
import '../../utils/database.dart';
import '../../classes/cat.dart';

class AddCat extends StatefulWidget {
  const AddCat({super.key});

  @override
  State<AddCat> createState() => _AddCatState();
}

class _AddCatState extends State<AddCat> with ValidationMixin {
  final formKey = GlobalKey<FormState>();
  final addCatController = Get.put(AddCatController());
  bool value = false;
  @override
  Widget build(BuildContext context) {
    MediaQueryData homeQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: appBarCustom(context, homeQuery) as PreferredSize,
      body: catForm(
          formKey,
          context,
          homeQuery,
          addCatController,
          validateEmpty,
          Checkbox(
            
            value: this.value,
            onChanged: (bool? value) {
              setState(() {
                this.value = value!;
              });
            },
          ),
          value,
          ),
          
    );
  }
}

Widget catForm(
    formKey, context, homeQuery, controller, validateEmpty, checkBox,value) {
  return Form(
    key: formKey,
    child: Column(
      children: [
        reusableTextField(
            "Cat name", Icons.abc, false, controller.name, validateEmpty),
        const SizedBox(
          height: 5,
        ),
       
        
        Row(
          children: [
            Expanded(
              child:  reusableTextField('Birth Year', Icons.calendar_month, false,
            controller.birthYear, validateEmpty),
              ),
            Expanded(
              child: reusableTextField('Birth Month', Icons.calendar_month, false,
            controller.birthMonth, validateEmpty),
              )
          ],
        ),
        
        const SizedBox(
          height: 5,
        ),
        reusableTextField('Cat Type', Icons.flag_circle_outlined, false,
            controller.type, validateEmpty),
        const SizedBox(
          height: 5,
        ),
        reusableTextField('Cat Color', Icons.color_lens_rounded, false,
            controller.color, validateEmpty),
        reusableTextField('Link for GOOGLE DRIVE image', Icons.color_lens_rounded, false,
            controller.image, validateEmpty),
        Row(
          children: [
            SizedBox(width: 10,),
            const Text('VACCINATED?'),
            checkBox,
          ],
        ),
        
        
        const SizedBox(
          height: 5,
        ),
        firebaseUIButton(context, 'Add Cat', () {
          if (formKey.currentState.validate()) {
            Cat.addCat(
                controller.name.text.trim(),
                controller.birthYear.text.trim(),
                controller.birthMonth.text.trim(),
                value,
                controller.type.text.trim(),
                controller.color.text.trim(),
                controller.image.text.trim());

          }
        }, homeQuery.size.width * 0.25)
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
