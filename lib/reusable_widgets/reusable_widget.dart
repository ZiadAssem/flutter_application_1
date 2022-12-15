import 'package:flutter/material.dart';
import '../screens/homescreen.dart';
import '../screens/loginscreen.dart';
import '../screens/adoptscreen.dart';



Image logoWidget(String imageName) {//logo image
  return Image.asset(
    imageName,
    fit: BoxFit.fitWidth,
    width: 240,
    height: 240,
    color: Colors.white,
  );
}

//text form field
TextFormField reusableTextField(String text, IconData icon, bool isPasswordType,
    TextEditingController controller) {
  return TextFormField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.white,
    style: TextStyle(color: Colors.white.withOpacity(0.9)),
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: Colors.white70,
      ),
      labelText: text,
      labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.white.withOpacity(0.3),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
    ),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}

Container firebaseUIButton(BuildContext context, String title, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.black26;
            }
            return Colors.white;
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
      child: Text(
        title,
        style: const TextStyle(
            color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16),
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

Widget appBarButton(Widget navigateTo, String title,context){ //buttons for appbar navigation
  return TextButton(
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) =>  navigateTo));
      },
      child:  Text(
        title,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
}
Widget appBarCustom(context){
  return AppBar(
          title: homeButton(context),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            Row(
              children: [
                Visibility(
                  visible: ! LoginScreenState.loggedIn,
                  child:                 appBarButton(const LoginScreen(), 'LOGIN', context),
              ),
                Container(padding: const EdgeInsets.all(10)),
                appBarButton(AdoptionScreen(), 'ADOPT  ', context)
              ],
            ),
          ],
          backgroundColor: const Color(0xff69539C),
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