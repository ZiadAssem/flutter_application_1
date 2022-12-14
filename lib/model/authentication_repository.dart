import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../view/homescreen.dart';
//import 'package:login_flutter_app/src/features/authentication/screens/welcome/welcome_screen.dart';
//import 'package:login_flutter_app/src/features/core/screens/dashboard/dashboard.dart';

import '../controller/exceptions/auth_exception_other.dart';
import '../controller/exceptions/login_with_email_and_pssword_failure.dart';
import '../controller/exceptions/signup_email_password_failure.dart';

enum AuthStatus {
  successful,
  wrongPassword,
  emailAlreadyExists,
  invalidEmail,
  weakPassword,
  unknown,
}

class AuthenticationRepository extends GetxController {
  static late AuthStatus _status;
  // Singleton
  static AuthenticationRepository get instance => Get.find();

  
  static final auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  //Will be load when app launches this func will be called and set the firebaseUser state
  @override
  void onReady() {
    firebaseUser = Rx<User?>(auth.currentUser);
    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  /// If we are setting initial screen from here
  /// then in the main.dart => App() add CircularProgressIndicator()
  _setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => const HomeScreen())
        : Get.offAll(() => const HomeScreen()); //changelater
  }



  Future<String?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      firebaseUser.value != null
          ? Get.offAll(() => const HomeScreen())
          : Get.to(() => const HomeScreen());
    } on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      return ex.message;
    } catch (_) {
      const ex = SignUpWithEmailAndPasswordFailure();
      return ex.message;
    }
    return null;
  }

  Future<String?> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      final ex = LogInWithEmailAndPasswordFailure.fromCode(e.code);
      return ex.message;
    } catch (_) {
      const ex = LogInWithEmailAndPasswordFailure();
      return ex.message;
    }
    return null;
  }

  // delete account from Firebase Authentication
  Future deleteAccount() async {
    try {
      final user = await auth.currentUser!;
      user.delete();
    } catch (e) {
      Get.showSnackbar(GetSnackBar(
        message: e.toString(),
        duration: const Duration(seconds: 2),
      ));
      return null;
    }
  }
  // sends email with link to reset password
   Future resetPassword({required String email}) async {
    
    await auth
        .sendPasswordResetEmail(email: email)
        .then((value) =>  _status = AuthStatus.successful)
        .catchError((e) => _status = AuthExceptionHandler.handleAuthException(e));
    return _status;
  }

  static Future<void> logout() async => await auth.signOut();
}
