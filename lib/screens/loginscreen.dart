import 'package:flutter/material.dart';
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
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            emailField(),
            passwordField(),
            Container(margin: EdgeInsets.only(top: 25.0)),
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
