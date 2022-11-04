

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/homescreen.dart';
import '../utils/authentication.dart';
import '../mixins/validation_mixin.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  

  @override
  Widget build(BuildContext context) {
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
                Container(margin: const EdgeInsets.only(top: 20.0)),
                Container(
                  child: registerForm(context),
                ),
                Container(margin: const EdgeInsets.only(top: 50.0)),
              ]),
            )
          ],
        );
      }),
    );
  }
}

Widget registerForm(context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        children: [
          signupText(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(width: 250, child: makeInput(label: 'First Name')),
                    const SizedBox(
                      width: 100,
                    ),
                    SizedBox(width: 250, child: makeInput(label: 'Last Name')),
                  ],
                ),
                makeInput(label: "Email",),
                makeInput(label: "Phone Number"),
                makeInput(label: "Password", obsureText: true),
                makeInput(label: "Confirm Pasword", obsureText: true)
              ],
            ),
          ),
          signupButton(context),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("Already have an account? "),
              Text(
                "Login",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
            ],
          )
        ],
      ),
    ],
  );
}

Widget makeInput({label, obsureText = false,validator}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
            fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
      ),
      const SizedBox(
        height: 5,
      ),
      SizedBox(
        height: 30,
        child: TextFormField(
          validator: validator,
          obscureText: obsureText,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey[400]!,
              ),
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400]!)),
          ),
        ),
      ),
      const SizedBox(
        height: 10,
      )
    ],
  );
}

Widget signupText() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      const Text(
        "Sign up",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      Text(
        "Create an Account,Its free",
        style: TextStyle(
          fontSize: 15,
          color: Colors.grey[700],
        ),
      ),
      const SizedBox(
        height: 30,
      )
    ],
  );
}

Widget signupButton(context) {
  return MaterialButton(
      minWidth: double.infinity,
      height: 60,
      onPressed: () {
        // FirebaseAuth.instance.createUserWithEmailAndPassword(email: _emailTextController.text,
        //                        password: _passwordTextController.text);
        Navigator.push(context,
         MaterialPageRoute(builder: ((context) => HomeScreen())
         ));
      },
      color: Colors.redAccent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      child: Text(
        "Sign Up",
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ));
}
