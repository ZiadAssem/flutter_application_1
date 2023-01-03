import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/classes/request.dart';
import 'package:flutter_application_1/model/authentication_repository.dart';
import 'package:flutter_application_1/model/database.dart';
import 'package:flutter_application_1/view/homescreen.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupSingletons() async {
  locator.registerLazySingleton<AuthenticationRepository>(() => AuthenticationRepository());
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupSingletons();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.web);
  runApp(App());
  //runApp(HomePage());
}

class App extends StatelessWidget {
  App({super.key});

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Scaffold(
              body: Center(
                child: Text('Error'),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
           
           return FutureBuilder(
            future: DbHelper.getButtons(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Scaffold(
                  body: Center(
                    child: Text('Error'),
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                return HomeScreen();
              }
              return const CircularProgressIndicator();
            },
           ); 
          }
          return const CircularProgressIndicator();
        },
      ),
      title: 'Animal Rights Association',
    );
  }
}
