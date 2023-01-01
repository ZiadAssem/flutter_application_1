// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/admin-screens/addcatscreen.dart';
import 'package:flutter_application_1/model/authentication_repository.dart';
import 'package:flutter_application_1/model/database.dart';
import 'package:get/get.dart';
import '../classes/user.dart';
import '../screens/homescreen.dart';
import '../screens/adoptscreen.dart';
import 'package:flutter_application_1/screens/loginscreen2.dart';

Image logoWidget(String imageName) {
  //logo image
  return Image.asset(
    imageName,
    fit: BoxFit.fitWidth,
    width: 240,
    height: 240,
    color: Colors.white,
  );
}

//text form field
Widget reusableTextField(String text, IconData icon, bool isPasswordType,
    TextEditingController controller,
    [validator, suffixIcon, bool showPassword = true]) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
    color: Colors.transparent,
    elevation: 10,
    child: TextFormField(
      validator: validator,
      controller: controller,
      obscureText: !showPassword,
      enableSuggestions: !isPasswordType,
      autocorrect: !isPasswordType,
      style: TextStyle(color: Colors.black.withOpacity(0.9)),
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        prefixIcon: Icon(
          icon,
          color: const Color(0xff69539C),
        ),
        labelText: text,
        labelStyle: TextStyle(color: Colors.black.withOpacity(0.9)),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      keyboardType: isPasswordType
          ? TextInputType.visiblePassword
          : TextInputType.emailAddress,
    ),
  );
}

//SignUpbutton in register screen 2
Container firebaseUIButton(
    BuildContext context, String title, Function onTap, width) {
  return Container(
    width: width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
      child: Text(
        title,
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
      ),
    ),
  );
}

//builds image for slideshow
Widget buildImage(String urlImage, [homeQuery]) => Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      //width:homeQuery==Null?Null: homeQuery.size.width *0.3,
      color: Colors.grey,
      child: Image.network(
        urlImage,
        fit: BoxFit.cover,
      ),
    );

Widget buildRequestImage(String urlImage, [homeQuery]) => Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      width: homeQuery == Null ? Null : homeQuery.size.width * 0.3,
      color: Colors.grey,
      child: Image.network(
        urlImage.trim(),
        fit: BoxFit.cover,
      ),
    );

Widget appBarButton(Widget navigateTo, String title, context) {
  //buttons for appbar navigation
  return TextButton(
    onPressed: () {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => navigateTo));
    },
    child: Text(
      title,
      style: const TextStyle(
        color: Colors.white,
      ),
    ),
  );
}

//A custom appbar for easy implementation
appBarCustom(context, homeQuery, Widget InvoiceButton) {
  bool test = User.isAdmin;
  return PreferredSize(
    preferredSize: Size.fromHeight(0.07 * homeQuery.size.height),
    child: AppBar(
      title: homeButton(context),
      automaticallyImplyLeading: false,
      actions: <Widget>[
        Row(
          children: [
            if (AuthenticationRepository.auth.currentUser != null)
              helloUser(context)
            else
              Container(),

            InvoiceButton,
            adminButton(context),
            // appBarButton(TestScreen(), 'test', context),
            if (AuthenticationRepository.auth.currentUser == null)
              appBarButton(const LoginScreen2(), 'LOGIN', context)
            else
              TextButton(
                  onPressed: () {
                    AuthenticationRepository.logout();
                  },
                  child: const Text(
                    'LOGOUT',
                    style: TextStyle(color: Colors.white),
                  )),
            appBarButton(AdoptionScreen(), 'ADOPT  ', context),
            Container(padding: const EdgeInsets.all(10)),
          ],
        ),
      ],
      backgroundColor: const Color(0xff69539C),
    ),
  );
}

//Custom button for appbar
Widget homeButton(context) {
  return IconButton(
    icon: Image.asset('assets/download2.png'),
    iconSize: 50,
    onPressed: () {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const HomeScreen()));
    },
  );
}

Widget adminButton(context) {
  return TextButton(
      onPressed: () async {
        if (AuthenticationRepository.auth.currentUser == null) {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const LoginScreen2()));
        } else if (await DbHelper.isAdmin()) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const AddCat()));
        } else {
          // Navigator.of(context).push(
          //     MaterialPageRoute(builder: (context) => const HomeScreen()));
          Get.showSnackbar(const GetSnackBar(
            message: 'UNAUTHORIZED ACCESS',
          ));
        }
      },
      child: const Text('ADMIN',
          style: TextStyle(
            color: Colors.white,
          )));
}

Widget helloUser(context) {
  return TextButton(
      onPressed: (() async => await userPopUp(context)),
      child: Text('Hello ' + User.helperName,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)));
}

Future userPopUp(context) async {
  final userInfo = await DbHelper.queryUserInfo();
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Stack(
            children: <Widget>[
              Positioned(
                right: -40.0,
                top: -40.0,
                child: InkResponse(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const CircleAvatar(
                    backgroundColor: Colors.red,
                    child: Icon(Icons.close),
                  ),
                ),
              ),
              Column(
                children: [
                  Text('Hello ' + userInfo['fullName'],
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('Email: ' + userInfo['email'],
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('Phone: ' + userInfo['phoneNo'],
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 10,
                  ),
                  deleteAccount(),
                ],
              ),
            ],
          ),
        );
      });
}

Widget deleteAccount() {
  return ElevatedButton(
    onPressed: () async {
      await AuthenticationRepository.instance.deleteAccount();
      await DbHelper.deleteAccount();
      await AuthenticationRepository.logout().then((value) {
        Get.showSnackbar(const GetSnackBar(
          message: 'Account Deleted',
          duration: Duration(seconds: 2),
        ));
      });
    },
    child: const Text('Delete Account'),
  );
}
