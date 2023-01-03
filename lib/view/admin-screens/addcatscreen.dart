// ignore_for_file: prefer_interpolation_to_compose_strings, deprecated_member_use

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/mixins/validation_mixin.dart';
import 'package:flutter_application_1/view/reusable_widgets/reusable_widget.dart';
import 'package:flutter_application_1/controller/addcat_controller.dart';
import 'package:get/get.dart';
import '../../classes/request.dart';
import '../../model/database.dart';
import 'package:url_launcher/url_launcher.dart';

class AddCat extends StatefulWidget {
  const AddCat({super.key});

  @override
  State<AddCat> createState() => _AddCatState();
}

class _AddCatState extends State<AddCat> with ValidationMixin {
  final formKey = GlobalKey<FormState>();
  final addCatController = Get.put(AddCatController());
  bool vaccinated = false;
  static Query ref = DbHelper.getQuery('request');

  @override
  Widget build(BuildContext context) {
    MediaQueryData homeQuery = MediaQuery.of(context);

    return Scaffold(
      appBar:
          appBarCustom(context, homeQuery, invoiceButton()) as PreferredSize,
      body: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Stack(
            children: [
              //Background
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
                      //Add cat form
                      child: catForm(
                        formKey,
                        context,
                        homeQuery,
                        addCatController,
                        validateEmpty,
                        validateBirthMonth,
                        validateBirthYear,
                        Checkbox(
                          value: vaccinated,
                          onChanged: (bool? value) {
                            setState(() {
                              vaccinated = value!;
                            });
                          },
                        ),
                        vaccinated,
                      ),
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      width: 0.3 * homeQuery.size.width,
                      // List of requests
                      child: FirebaseAnimatedList(
                        query: ref,
                        itemBuilder: ((context, snapshot, animation, index) {
                          Map request = snapshot.value as Map;

                          request['key'] = snapshot.key;

                          return listRequest(request: request);
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}

Widget catForm(formKey, context, homeQuery, controller, validateEmpty,
    validateBirthMonth, validateBirthYear, checkBox, vaccinated) {
  return Form(
    key: formKey,
    child: Column(
      children: [
        const SizedBox(height: 5),
         Text(
          Request.buttons['fillDetails'],
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
                  false, controller.birthYear, validateBirthYear),
            ),
            Expanded(
              child: reusableTextField('Birth Month', Icons.calendar_month,
                  false, controller.birthMonth, validateBirthMonth),
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
        reusableTextField('Link for GOOGLE DRIVE image', Icons.image_rounded,
            false, controller.image, validateEmpty),
        Row(
          children: [
            const SizedBox(
              width: 10,
            ),
             Text('VACCINATED?'),
            checkBox,
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        firebaseUIButton(context, 'Add Cat', () {
          if (formKey.currentState.validate()) {
            DbHelper.addCat(
                controller.name.text.trim(),
                controller.birthYear.text.trim(),
                controller.birthMonth.text.trim(),
                vaccinated,
                controller.type.text.trim(),
                controller.color.text.trim(),
                controller.image.text.trim());
            formKey.currentState.clear();
          }
        }, homeQuery.size.width * 0.25)
      ],
    ),
  );
}



// presents the request in a list tile
Widget listRequest({required Map request}) {
  return Container(
    height: 100,
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(500)),
      child: ListTile(
        leading: const CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage('cat_avatar.png'),
        ),
        title: Text(
          request['userName'],
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          children: [
            Text(request['userPhoneNo'],
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            Text(
              request['catName'],
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        trailing: Column(
          children: [
            InkWell(
              child: const Icon(Icons.check),
              onTap: () {
                DbHelper.acceptRequest(request['key'], request['catId']);
              },
            ),
            InkWell(
              child: const Icon(Icons.delete),
              onTap: () {
                DbHelper.deleteRequest(request['key']);
              },
            ),
          ],
        ),
      ),
    ),
  );
}

// redirects to invoice generator
Widget invoiceButton() {
  return InkWell(
      child:  Text(Request.buttons['invoice'],
        style: const TextStyle(
          
          color: Colors.white,
        ),
      ),
      onTap: () => launch('https://invoice-generator.com/')
        
          );
}
