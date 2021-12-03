import 'package:app/LogIn.dart';
import 'package:app/Myprovider.dart';
import 'package:app/callCenter.dart';
import 'package:app/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'LanguageProvider.dart';

class UserState extends StatefulWidget {

  @override
  State<UserState> createState() => _UserStateState();
}
class _UserStateState extends State<UserState> {
  var stream;
  @override
  void initState() {
    setState(() {
      stream = FirebaseAuth.instance.authStateChanges();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Login();
          } else if (snapshot.hasData) {
            if (Provider.of<MyProvider>(context,listen: false).admin)
              return CallCenter();
            else
              return MyHomepage();
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(Provider.of<LanProvider>(context,listen: false).texts("Error occurred !"),
                  style: const TextStyle(fontSize: 20, color: Colors.red)),
            );
          }
          return Scaffold(
              body: Center(
                  child: Text( Provider.of<LanProvider>(context,listen: false).texts("something went wrong !"),
                      style:
                          const TextStyle(fontSize: 20, color: Colors.red))));
        });
  }
}
