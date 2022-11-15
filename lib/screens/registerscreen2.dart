import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../reusable_widgets/reusable_widget.dart';
import 'package:flutter/material.dart';
import '../reusable_widgets/colors.dart';
import '../src2/signup_controller.dart';
import '../classes/user.dart' as u;
import 'homescreen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
 final signUpController = Get.put(SignUpController());
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return ScreenDecoration(context, Text('sign up'), form(context, signUpController, _formKey));
    
  }
}
Widget ScreenDecoration(context,title,Widget child){
  return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: title,
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            hexStringToColor("CB2B93"),
            hexStringToColor("9546C4"),
            hexStringToColor("5E61F4")
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
            child:child,
          ))),
    );
}
Widget form(context,controller,_formKey){
  return Form(
    key:_formKey,
    child: Column(
              children: <Widget>[
                const SizedBox(height: 20),
                 reusableTextField("Enter full name", Icons.person_outline, false,
                    controller.fullName),
                const SizedBox(height: 20),
                reusableTextField("Enter email", Icons.person_outline, false,
                    controller.email),
                const SizedBox(height: 20),
                reusableTextField("Enter phone number", Icons.numbers, false,
                    controller.phoneNo),
                const SizedBox(height: 20),
                reusableTextField("Enter Password", Icons.lock_outlined, true,
                    controller.password),
                const SizedBox(height: 20),
                firebaseUIButton(context, "Sign Up",   () {
                  if(_formKey.currentState!.validate()){
                    u.User.addUser(controller.fullName.text.trim(),controller.email.text.trim(),controller.phoneNo.text.trim());
                    SignUpController.instance.registerUser(controller.email.text.trim(), controller.password.text.trim());
                  }
                },)
              ],
            ),
  );
}


// Scaffold(
    //   extendBodyBehindAppBar: true,
    //   appBar: AppBar(
    //     backgroundColor: Colors.transparent,
    //     elevation: 0,
    //     title: const Text(
    //       "Sign Up",
    //       style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    //     ),
    //   ),
    //   body: Container(
    //       width: MediaQuery.of(context).size.width,
    //       height: MediaQuery.of(context).size.height,
    //       decoration: BoxDecoration(
    //           gradient: LinearGradient(colors: [
    //         hexStringToColor("CB2B93"),
    //         hexStringToColor("9546C4"),
    //         hexStringToColor("5E61F4")
    //       ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
    //       child: SingleChildScrollView(
    //           child: Padding(
    //         padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
    //         child: Column(
    //           children: <Widget>[
    //             const SizedBox(height: 20),
    //             reusableTextField("Enter UserName", Icons.person_outline, false,
    //                 _userNameTextController),
    //             const SizedBox(height: 20),
    //             reusableTextField("Enter Email Id", Icons.person_outline, false,
    //                 _emailTextController),
    //             const SizedBox(height: 20),
    //             reusableTextField("Enter Password", Icons.lock_outlined, true,
    //                 _passwordTextController),
    //             const SizedBox(height: 20),
    //             firebaseUIButton(context, "Sign Up", () {
    //               FirebaseAuth.instance
    //                   .createUserWithEmailAndPassword(
    //                       email: _emailTextController.text,
    //                       password: _passwordTextController.text)
    //                   .then((value) {
    //                 print("Created New Account");
    //                 Navigator.push(
    //                     context,
    //                     MaterialPageRoute(
    //                         builder: (context) => const HomeScreen()));
    //               }).onError((error, stackTrace) {
    //                 print("Error ${error.toString()}");
    //               });
    //             })
    //           ],
    //         ),
    //       ))),
    // );