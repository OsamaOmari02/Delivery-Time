
import 'package:flutter/material.dart';


enum AuthMode { LogIn, SignUp }
class MyProvider with ChangeNotifier {

  List imageFun = [
    'file/burger.jpg',
    'file/fahita.jpg',
    'file/shawarmah.jpg',
  ];

  bool isDark = false;

  void darkMode(bool val) {
    isDark = val;
    notifyListeners();
  }

  //-----------auth--------
  AuthMode authMode = AuthMode.LogIn;
  Map<String, String> authData = {
    'email': '',
    'password': '',
    'phone': '',
    'name': '',
  };
  bool isLoading = false;
  // final passwordController = TextEditingController();
  // final phoneController = TextEditingController();
  // late final emailController = TextEditingController();
  final nameController = TextEditingController();
  // final rePasswordController = TextEditingController();
  // Future <void> submit() async {
  //   if (!formKey.currentState!.validate())
  //     return;
  //   isLoading = true;
  //
  //   notifyListeners();
  //   try {
  //   } catch (e) {
  //     print(e);
  //   }
  //   isLoading = false;
  //   notifyListeners();
  // }

  void switchAuth() {
    if (authMode == AuthMode.LogIn) {
      authMode = AuthMode.SignUp;
      notifyListeners();
    }
    else {
      authMode = AuthMode.LogIn;
      notifyListeners();
    }
  }

  //-------------auth2------------
  // Future<String> authintecation() async {
  //   FirebaseAuth fireBase = FirebaseAuth.instance;
  //   UserCredential user;
  //   try {
  //     if (authMode == AuthMode.SignUp) {
  //       user = await fireBase.createUserWithEmailAndPassword(
  //         email: emailController.text.trim(),
  //         password: passwordController.text.trim(),
  //       );
  //     } else {
  //       user = await fireBase.signInWithEmailAndPassword(
  //         email: emailController.text.trim(),
  //         password: passwordController.text.trim(),
  //       );
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     print(e);
  //   } catch (e) {
  //     print(e);
  //   }
  // }
}