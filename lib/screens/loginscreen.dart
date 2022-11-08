import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'success.dart';
import 'package:flutter_application_1/screens/homescreen.dart';
import 'package:flutter_application_1/screens/registerscreen2.dart';
import 'package:flutter_application_1/src2/signup_form.dart';
import '../src2/authentication_repository.dart';

//import 'package:flutter_application_1/screens/registerscreen2.dart';
import 'package:flutter_application_1/themes/style.dart';
import 'package:get/get.dart';
import '../mixins/validation_mixin.dart';
import '../src2/login_controller.dart';
import 'registerscreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> with ValidationMixin {
  final controller = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();

  String? email = '';
  String? password = '';

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(),
      body: LayoutBuilder(builder: (context, constraints) {
        return Row(
          children: [
            Expanded(
                child: Stack(
              children: [
                Container(
                  color: const Color(0xff69539C),
                  constraints: const BoxConstraints(
                    maxHeight: double.infinity,
                  ),
                ),
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(100),
                    ),
                    Container(
                      alignment: Alignment.center,
                      constraints: const BoxConstraints(maxHeight: 200),
                      child: Image.asset('assets/download.png'),
                    )
                  ],
                )
              ],
            )),
            Expanded(
              child: Column(children: [
                Container(margin: const EdgeInsets.only(top: 50.0)),
                Container(
                  child: loginForm(controller),
                ),
                Container(margin: const EdgeInsets.only(top: 50.0)),
                newUserButton(context),
              ]),
            )
          ],
        );
      }),
    );
  }

  Widget backgroundImage() {
    return ConstrainedBox(
      constraints: const BoxConstraints(
          // maxHeight: 500.0,
          ),
      child: const DecoratedBox(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill, image: AssetImage('assets/download2.png'))),
      ),
    );
  }

  Widget loginForm(controller) {
    return Container(
      alignment: Alignment.centerRight,
      margin: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            emailField(controller),
            passwordField(controller),
            Container(margin: const EdgeInsets.only(top: 50.0)),
            submitButton(controller),
          ],
        ),
      ),
    );
  }

  Widget emailField(controller) {
    return TextFormField(
      validator: validateEmail,
      controller: controller.email,
      // onSaved: (String? value) {
      //   controller.email = value;
      // },
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        labelText: 'Enter Email Address',
        hintText: 'you@example.com',
      ),
    );
  }

  Widget passwordField(controller) {
    return TextFormField(
      validator: validatePassword,
      controller: controller.password,
      // onSaved: (String? value) {
      //   controller.password = value;
      // },
      obscureText: true,
      decoration: const InputDecoration(
        labelText: 'Enter Password',
        hintText: 'Password',
      ),
    );
  }

  Widget submitButton(controller) {
    return ElevatedButton(
      onPressed: ()  {
        if (_formKey.currentState!.validate()) {
          //loginFormKey.currentState?.save();
          LoginController.instance.loginUser(controller.email.text.trim() as String, controller.password.text.trim() as String);
          //  Navigator.of(context)
          //        .push(MaterialPageRoute(builder: (context) => const Success()));
       
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
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const SignUpScreen()));
            },
            child: const Text('REGISTER'))
      ],
    );
  }
}
