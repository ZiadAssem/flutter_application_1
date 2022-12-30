import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
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
  static Query ref = DbHelper.getQuery('request');

  @override
  Widget build(BuildContext context) {
    MediaQueryData homeQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: appBarCustom(context, homeQuery) as PreferredSize,
      body: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Stack(
            children: [
              Container(
                width: homeQuery.size.width,
                height: homeQuery.size.height,
                decoration: const BoxDecoration(
                  color: Colors.deepPurple,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/cat_background.jpeg')),
                ),
              ),
              Row(
                children: [
                  SingleChildScrollView(
                    child: SizedBox(
                      width: homeQuery.size.width * 0.5,
                      height: homeQuery.size.height,
                      child: catForm(
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
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 0.3 * homeQuery.size.width,
                    child: FirebaseAnimatedList(
                      query: ref,
                      itemBuilder: ((context, snapshot, animation, index) {
                        Map request = snapshot.value as Map;

                        request['key'] = snapshot.key;

                        return listRequest(request: request);
                      }),
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}

Widget catForm(
    formKey, context, homeQuery, controller, validateEmpty, checkBox, value) {
  return Form(
    key: formKey,
    child: Column(
      children: [
        const SizedBox(height: 5),
        const Text(
          'Fill with cat details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.black,
          ),
        ),
        reusableTextField(
            "Cat name", Icons.abc, false, controller.name, validateEmpty),
        const SizedBox(height: 5),
        Row(
          children: [
            Expanded(
              child: reusableTextField('Birth Year', Icons.calendar_month,
                  false, controller.birthYear, validateEmpty),
            ),
            Expanded(
              child: reusableTextField('Birth Month', Icons.calendar_month,
                  false, controller.birthMonth, validateEmpty),
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
        reusableTextField('Link for GOOGLE DRIVE image',
            Icons.image_rounded, false, controller.image, validateEmpty),
        Row(
          children: [
            const SizedBox(
              width: 10,
            ),
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
            formKey.currentState.reset();
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

Widget listRequest({required Map request}) {
  return Card(
    child: Column(
      children: [
        Text(request['userName']),
        const SizedBox(
          height: 5,
        ),
        Text(request['catName']),
        const SizedBox(
          height: 5,
        ),
        Text(request['userPhoneNo']),
      ],
    ),
  );
}
