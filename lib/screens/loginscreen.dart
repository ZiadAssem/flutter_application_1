import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/homescreen.dart';
import 'package:flutter_application_1/screens/registerscreen2.dart';
import 'package:flutter_application_1/src2/authentication_repository.dart';

//import 'package:flutter_application_1/screens/registerscreen2.dart';
import 'package:get/get.dart';
import '../mixins/validation_mixin.dart';
import '../src2/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> with ValidationMixin {
  static final controller = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();
  static bool loggedIn = false;
  static String? email = '';
  static String? password = '';

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
                  child: loginForm(context, controller, _formKey, validateEmail, loggedIn),
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

Widget loginForm(
    context, controller, _formKey, validateEmail, loggedIn) {
  return Container(
    alignment: Alignment.centerRight,
    margin: const EdgeInsets.all(20.0),
    child: Form(
      key: _formKey,
      child: Column(
        children: [
          emailField(controller, validateEmail),
          passwordField(controller),
          Container(margin: const EdgeInsets.only(top: 50.0)),
          submitButton(context, controller, _formKey, loggedIn),
        ],
      ),
    ),
  );
}

Widget emailField(controller, validateEmail) {
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

Widget submitButton(context, controller, formKey, loggedIn)   {
  return ElevatedButton(
    onPressed: ()  {
      if (formKey.currentState!.validate()) {
        //loginFormKey.currentState?.save();
        LoginController.instance.loginUser(
            controller.email.text.trim() as String,
            controller.password.text.trim() as String);
        if ( AuthenticationRepository.auth.currentUser != null) {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const HomeScreen()));
        }else{
          Navigator.of(context).push(
           MaterialPageRoute(builder: (context) => const LoginScreen()));
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



