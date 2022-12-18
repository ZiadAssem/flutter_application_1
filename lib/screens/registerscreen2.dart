import 'package:flutter_application_1/mixins/validation_mixin.dart';
import 'package:get/get.dart';
import '../reusable_widgets/reusable_widget.dart';
import 'package:flutter/material.dart';
import '../reusable_widgets/colors.dart';
import '../src2/signup_controller.dart';
import '../classes/user.dart' as u;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> with ValidationMixin {
  final signUpController = Get.put(SignUpController());
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    MediaQueryData homeQuery = MediaQuery.of(context);
    return screenDecoration(
      context,
      const Text('sign up'),
      // form(context, signUpController, _formKey, validateEmail,
      //     validatePassword)
      signUpDesign(
          signUpController, _formKey, context, validateEmail, validatePassword),
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
                  color: Colors.white,
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

Widget form(context, controller, formKey, validateEmail, validatePassword) {
  return Form(
    key: formKey,
    child: Column(
      children: <Widget>[
        const SizedBox(height: 20),
        reusableTextField("Enter full name", Icons.person_outline, false,
            controller.fullName,context),
        const SizedBox(height: 20),
        reusableTextField("Enter email", Icons.person_outline, false,
            controller.email, validateEmail),
        const SizedBox(height: 20),
        reusableTextField(
            "Enter phone number", Icons.numbers, false, controller.phoneNo),
        const SizedBox(height: 20),
        reusableTextField("Enter Password", Icons.lock_outlined, true,
            controller.password, validatePassword),
        const SizedBox(height: 20),
        // firebaseUIButton(
        //   context,
        //   "Sign Up",
        //   () {
        //     if (formKey.currentState!.validate()) {
        //       u.User.addUser(controller.fullName.text.trim(),
        //           controller.email.text.trim(), controller.phoneNo.text.trim());
        //       SignUpController.instance.registerUser(
        //           controller.email.text.trim(),
        //           controller.password.text.trim());
        //     }
        //   },
        // )
      ],
    ),
  );
}

Widget signUpDesign(
    controller, formKey, context, validateEmail, validatePassword) {
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
        reusableTextField("Enter email", Icons.email, false,
            controller.email, validateEmail),
        const SizedBox(height: 20),
        reusableTextField(
            "Enter phone number", Icons.numbers, false, controller.phoneNo),
        const SizedBox(height: 20),
        reusableTextField("Enter Password", Icons.lock_outlined, true,
            controller.password, validatePassword),
        const SizedBox(height: 20),
        firebaseUIButton(context, "Sign Up", () {
          if (formKey.currentState!.validate()) {
            u.User.addUser(controller.fullName.text.trim(),
                controller.email.text.trim(), controller.phoneNo.text.trim());
            SignUpController.instance.registerUser(
                controller.email.text.trim(), controller.password.text.trim());
          }
        }, 0.25 * MediaQuery.of(context).size.width),
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
