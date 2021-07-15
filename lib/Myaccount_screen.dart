import 'dart:ffi';

import 'package:app/Drawer.dart';
import 'package:app/Myprovider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyAccount extends StatefulWidget {
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  bool isVisible = true;
  var _myName = TextEditingController();
  var _myOldPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var provider = Provider.of<MyProvider>(context);
    dialog(title) {
      return showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return AlertDialog(
              title: Row(
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 30,
                    color: Colors.red,
                  ),
                  SizedBox(width: 17),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(fontSize: 23, color: Colors.red),
                    ),
                  ),
                ],
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 8),
              elevation: 24,
              content: Container(
                height: MediaQuery.of(context).size.height * 0.05,
                child: Divider(),
                alignment: Alignment.topCenter,
              ),
              actions: [
                TextButton(
                    child: Text("OK", style: TextStyle(fontSize: 21)),
                    onPressed: () => Navigator.of(context).pop()),
              ],
            );
          });
    }
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text("My account"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        children: [
          SizedBox(height: height * 0.02),
          Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  initialValue: provider.authData['name'],
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.person,
                      color: Colors.blue,
                    ),
                    labelText: "Full Name",
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  enabled: false,
                  initialValue: provider.authData['email'],
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.alternate_email_outlined,
                      color: Colors.blue,
                    ),
                    labelText: "E-mail",
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: TextFormField(
                  keyboardType: TextInputType.phone,
                  initialValue: provider.authData['phone'],
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.phone,
                      color: Colors.blue,
                    ),
                    labelText: "Phone Number",
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: height * 0.02),
          TextButton(
            onPressed: () {
              setState(() {
                Navigator.of(context).pushNamed('password');
              });
            },
            child: Text("Change password",
                style: TextStyle(fontSize: 16, color: Colors.black45)),
          ),
          SizedBox(height: height * 0.02),
          Container(
            padding: EdgeInsets.symmetric(horizontal: width*0.36),
            child: ElevatedButton(
              onPressed: () {
                setState(() {

                });
              },
              child: Text(
                "Save",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
