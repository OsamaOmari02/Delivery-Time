import 'package:app/LogIn.dart';
import 'package:app/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'LanguageProvider.dart';

class UserState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var lanProvider = Provider.of<LanProvider>(context);
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Login();
          } else if (snapshot.hasData) {
            return MyHomepage();
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(lanProvider.texts("Error occurred !"),
                  style: TextStyle(fontSize: 20, color: Colors.red)),
            );
          }
          return Scaffold(
              body: Center(
                  child: Text(lanProvider.texts("something went wrong !"),
                      style: TextStyle(fontSize: 20, color: Colors.red))));
        });
  }
}
