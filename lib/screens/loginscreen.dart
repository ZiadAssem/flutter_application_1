import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/registerscreen2.dart';
//import 'package:flutter_application_1/screens/registerscreen2.dart';
import 'package:flutter_application_1/themes/style.dart';
import '../mixins/validation_mixin.dart';
import 'registerscreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> with ValidationMixin {
  final loginFormKey = GlobalKey<FormState>();
  String? email = '';
  String? password = '';

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
                  child: loginForm(),
                  
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

  Widget loginForm() {
    return Container(
      alignment: Alignment.centerRight,
      margin: const EdgeInsets.all(20.0),
      child: Form(
        key: loginFormKey,
        child: Column(
          children: [
            emailField(),
            passwordField(),
            Container(margin: const EdgeInsets.only(top: 50.0)),
            submitButton(),
          ],
        ),
      ),
    );
  }

  Widget emailField() {
    return TextFormField(
      validator: validateEmail,
      onSaved: (String? value) {
        email = value;
      },
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        labelText: 'Enter Email Address',
        hintText: 'you@example.com',
      ),
    );
  }

  Widget passwordField() {
    return TextFormField(
      validator: validatePassword,
      onSaved: (String? value) {
        password = value;
      },
      obscureText: true,
      decoration: const InputDecoration(
        labelText: 'Enter Password',
        hintText: 'Password',
      ),
    );
  }

  Widget submitButton() {
    return ElevatedButton(
      onPressed: () {
        if (loginFormKey.currentState!.validate()) {
          loginFormKey.currentState?.save();
        }
      },
      child: const Text('submit'),
    );
  }
 
  Widget newUserButton(context){
    return Column(
        children:  [
          const Text(
            "New User? Register Here",
            style: TextStyle(
              color: Colors.black,
              fontStyle: FontStyle.italic,
            ),
          ),
          ElevatedButton(
            onPressed: (){
               Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const SignUpScreen()));
            },
             child: const Text('REGISTER'))
        ],
    );
  }
}
