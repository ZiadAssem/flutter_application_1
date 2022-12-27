import 'package:flutter_application_1/mixins/validation_mixin.dart';
import 'package:flutter_application_1/src2/authentication_repository.dart';
import 'package:get/get.dart';
import '../reusable_widgets/reusable_widget.dart';
import 'package:flutter/material.dart';
import '../src2/signup_controller.dart';
import '../classes/user.dart' as u;
import 'dart:io';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> with ValidationMixin {
  final signUpController = Get.put(SignUpController());
  final _formKey = GlobalKey<FormState>();
  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    MediaQueryData homeQuery = MediaQuery.of(context);
    return screenDecoration(
      context,
      const Text('sign up'),
      signUpDesign(
        signUpController,
        _formKey,
        context,
        validateEmail,
        validatePassword,
        IconButton(
          icon: const Icon(Icons.remove_red_eye_sharp),
          onPressed: () {
            setState(() {
              showPassword = !showPassword;
            });
          },
        ),
        showPassword,
      ),
      homeQuery,
    );
  }
}

Widget screenDecoration(context, title, Widget child, homeQuery) {
  return Scaffold(
    extendBodyBehindAppBar: true,
    appBar: appBarCustom(context, homeQuery) as PreferredSize,
    body: Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fitWidth,
              image: AssetImage('assets/shelter illustration.jpg'),
            ),
            color: Colors.deepPurple,
            //Color(0xff69539C),
          ),
        ),
        Center(
          child: Card(
            color: Colors.transparent,
            surfaceTintColor: Colors.black,
            shadowColor: Colors.black,
            elevation: 30,
            child: Container(
              width: 0.4 * MediaQuery.of(context).size.width,
              height: 0.8 * MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.6),
                border: Border.all(color: Colors.black),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 50, 20, 10),
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget signUpDesign(controller, formKey, context, validateEmail,
    validatePassword, passwordIcon, showPassword) {
  return Form(
    key: formKey,
    child: Column(
      children: [
        const Text(
          'SIGN UP, SAVE A LIFE',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 20),
        reusableTextField("Enter full name", Icons.person_outline, false,
            controller.fullName),
        const SizedBox(height: 20),
        reusableTextField(
            "Enter email", Icons.email, false, controller.email, validateEmail),
        const SizedBox(height: 20),
        reusableTextField(
            "Enter phone number", Icons.numbers, false, controller.phoneNo),
        const SizedBox(height: 20),
        reusableTextField("Enter Password", Icons.lock_outlined, true,
            controller.password, validatePassword, passwordIcon, showPassword),
        const SizedBox(height: 20),
        firebaseUIButton(context, "Sign Up", ()  async {
          
          if (formKey.currentState!.validate()) {
            
            SignUpController.instance.registerUser(
                controller.email.text.trim(), controller.password.text.trim(),
                 controller.fullName.text.trim(),controller.phoneNo.text.trim(),

                );
            
           
          }
        }, 0.25 * MediaQuery.of(context).size.width),
      ],
    ),
  );
}
