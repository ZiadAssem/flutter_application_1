import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'signup_controller.dart';
import '../reusable_widgets/reusable_widget.dart';

class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    final _formKey = GlobalKey<FormState>();


    return Scaffold(
      appBar: AppBar(),
      body:  Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            reusableTextField("Enter UserName", Icons.person_outline, false,
                    controller.fullName),
            const SizedBox(height: 20),
            reusableTextField("Enter email", Icons.person_outline, false,
                    controller.email),
            const SizedBox(height: 20),
           reusableTextField("Enter UserName", Icons.numbers, false,
                    controller.phoneNo),
            const SizedBox(height: 20),
            reusableTextField("Enter Password", Icons.lock_outlined, true,
                    controller.password),
            const SizedBox(height:   10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if(_formKey.currentState!.validate()){
                    SignUpController.instance.registerUser(controller.email.text.trim(), controller.password.text.trim(),
                    controller.fullName.text.trim(),controller.phoneNo.text.trim());
                  }
                },
                child: const Text('signup'
                 // tSignup.toUpperCase()
                  ),
              ),
            )
          ],
        ),
      ),
    );
  }
}