import 'package:flutter_application_1/mixins/validation_mixin.dart';
import 'package:flutter_application_1/screens/homescreen.dart';
import 'package:flutter_application_1/screens/registerscreen.dart';
import 'package:flutter_application_1/screens/registerscreen2.dart';
import 'package:flutter_application_1/src2/authentication_repository.dart';
import 'package:get/get.dart';
import '../classes/user.dart';
import '../reusable_widgets/reusable_widget.dart';
import 'package:flutter/material.dart';
import '../src2/Login_controller.dart';
import '../classes/user.dart' as u;
import 'dart:io';

import '../utils/database.dart';

class LoginScreen2 extends StatefulWidget {
  const LoginScreen2({Key? key}) : super(key: key);

  @override
  LoginScreen2State createState() => LoginScreen2State();
}

class LoginScreen2State extends State<LoginScreen2> with ValidationMixin {
  final controller = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();
  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    MediaQueryData homeQuery = MediaQuery.of(context);
    return screenDecoration(
      context,
      const Text('login'),
      LoginDesign(
        controller,
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

Widget LoginDesign(controller, formKey, context, validateEmail,
    validatePassword, passwordIcon, showPassword) {
  return Form(
    key: formKey,
    child: Column(
      children: [
        const Text(
          'Login!',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 20),
        reusableTextField(
            "Enter email", Icons.email, false, controller.email, validateEmail),
        const SizedBox(height: 20),
        reusableTextField("Enter Password", Icons.lock_outlined, true,
            controller.password, validatePassword, passwordIcon, showPassword),
        const SizedBox(height: 20),
        firebaseUIButton(context, "login", () async {
          if (formKey.currentState!.validate()) {
            //loginFormKey.currentState?.save();
            LoginController.instance.loginUser(
                controller.email.text.toLowerCase().trim() as String,
                controller.password.text.trim() as String);
            formKey.currentState.reset();

            if (AuthenticationRepository.auth.currentUser != null) {
              User.isAdmin = await DbHelper.isAdmin();

              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const HomeScreen()));
            } else {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const LoginScreen2()));
            }
          }
        }, 0.25 * MediaQuery.of(context).size.width),
        const SizedBox(
          height: 20,
        ),
        newUserButton(context)
      ],
    ),
  );
}

Widget submitButton(context, controller, formKey, loggedIn) {
  return ElevatedButton(
    onPressed: () async {
      if (formKey.currentState!.validate()) {
        //loginFormKey.currentState?.save();
        LoginController.instance.loginUser(
            controller.email.text.toLowerCase().trim() as String,
            controller.password.text.trim() as String);
        formKey.currentState.reset();

        if (AuthenticationRepository.auth.currentUser != null) {
          User.isAdmin = await DbHelper.isAdmin();

          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const HomeScreen()));
        } else {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const LoginScreen2()));
        }
      }
    },
    child: const Text('submit'),
  );
}

Widget newUserButton(context) {
  return Column(
    children: [
      const Text(
        "New User? Register Here",
        style: TextStyle(
          color: Colors.black,
          fontStyle: FontStyle.italic,
        ),
      ),
      ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const SignUpScreen()));
          },
          child: const Text('REGISTER'))
    ],
  );
}
