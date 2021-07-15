
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


// enum AuthMode { LogIn, SignUp }
enum authStatus {Authenticating,unAuthenticated,Authenticated}
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
  // AuthMode authMode = AuthMode.LogIn;
  authStatus authState = authStatus.Authenticated;
  Map<String, String> authData = {
    'email': '',
    'password': '',
    'phone': '',
    'name': '',
  };
  bool isLoading = true;
  fetch() async{
    final userData = FirebaseAuth.instance.currentUser;
    if (userData!=null)
      await FirebaseFirestore.instance.collection('users').doc(userData.uid)
          .get().then((val){
            authData['email'] = val.data()?['email'];
            authData['phone'] = val.data()?['phone'];
            authData['password'] = val.data()?['password'];
            authData['name'] = val.data()?['username'];
            notifyListeners();
    });
  }
  // final passwordController = TextEditingController();
  // final phoneController = TextEditingController();
  // final emailController = TextEditingController();
  // final nameController = TextEditingController();
  // final rePasswordController = TextEditingController();




  //-------------auth2------------

}