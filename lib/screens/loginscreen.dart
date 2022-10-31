import 'package:flutter/material.dart';
import 'package:flutter_application_1/themes/style.dart';
import '../mixins/validation_mixin.dart';

class LoginScreen extends StatefulWidget {
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> with ValidationMixin {
  final formKey = GlobalKey<FormState>();
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
                  constraints: BoxConstraints(
                    maxHeight: double.infinity,
                  ),
                ),
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(100),
                    ),
                    Container(
                      alignment: Alignment.center,
                      constraints: BoxConstraints(maxHeight: 200),
                      child: Image.asset('assets/download.png'),
                    )
                  ],
                )
              ],
            )),
            Expanded(
              child: Column(children: [
                Container(margin: EdgeInsets.only(top: 50.0)),
                Container(
                  child: loginForm(),
                )
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
      margin: EdgeInsets.all(20.0),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            emailField(),
            passwordField(),
            Container(margin: EdgeInsets.only(top: 50.0)),
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
        if (formKey.currentState!.validate()) {
          formKey.currentState?.save();
          print('Time to post $email and $password to an API!!');
        }
      },
      child: Text('submit'),
    );
  }
}
