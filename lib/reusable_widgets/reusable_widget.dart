import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/admin-screens/addcatscreen.dart';
import 'package:flutter_application_1/src2/authentication_repository.dart';
import 'package:flutter_application_1/utils/database.dart';
import '../screens/homescreen.dart';
import '../screens/loginscreen.dart';
import '../screens/adoptscreen.dart';

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
    [validator,suffixIcon,bool showPassword= true]) {
      
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
    color: Colors.transparent,
    elevation: 10,
    child: TextFormField(
      validator: validator,
      controller: controller,
      obscureText:  !showPassword,
      enableSuggestions: !isPasswordType,
      autocorrect: !isPasswordType,
      style: TextStyle(color: Colors.black.withOpacity(0.9)),
      decoration: InputDecoration(
       suffixIcon:  suffixIcon,
        prefixIcon: Icon(
          icon,
          color: const Color(0xff69539C),
          
        ),
        labelText: text,
        labelStyle: TextStyle(color: Colors.black.withOpacity(0.9)),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0),),
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
          //MaterialStateProperty.resolveWith((states) {
          // if (states.contains(MaterialState.pressed)) {
          //   return Colors.purple;
          // }
          //return const Color(0xff69539C);
          //}
          //),
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
Widget buildImage(String urlImage) => Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      color: Colors.grey,
      child: Image.network(
        urlImage,
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

Widget appBarCustom(context, homeQuery) {
  var userFirebaseId = AuthenticationRepository.auth.currentUser?.uid;
  return PreferredSize(
    preferredSize: Size.fromHeight(0.07 * homeQuery.size.height),
    child: AppBar(
      title: homeButton(context),
      automaticallyImplyLeading: false,
      actions: <Widget>[
        Row(
          children: [
              if(AuthenticationRepository.auth.currentUser==null) appBarButton(const LoginScreen(), 'LOGIN', context)
              else if  ( DbHelper.ref.child('user/$userFirebaseId/.../admin')==true) TextButton(onPressed: (){}, child: Text('admin'))
              
              else TextButton(
                onPressed: (){
                  AuthenticationRepository.logout();
                },
               child: const Text('LOGOUT',style: TextStyle(color: Colors.white),)),
            
            Container(padding: const EdgeInsets.all(10)),
            appBarButton(AdoptionScreen(), 'ADOPT  ', context),
            Container(padding: const EdgeInsets.all(10)),
            appBarButton(const AddCat(), 'Add Cat', context)
          ],
        ),
      ],
      backgroundColor: const Color(0xff69539C),
    ),
  );
}

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
