import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Drawer.dart';

class MyPassword extends StatefulWidget {
  @override
  _MyPasswordState createState() => _MyPasswordState();
}

class _MyPasswordState extends State<MyPassword> {
  bool isVisible = true;
  var myPass = TextEditingController();
  var myNewPass = TextEditingController();

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("Change password"),
      ),
      body: Column(
        children: [
          SizedBox(height:height*0.05),
          Container(
            child: TextField(
              controller: myNewPass,
              obscureText: isVisible,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isVisible = !isVisible;
                    });
                  },
                  icon: Icon(isVisible == true ? Icons.visibility : Icons.visibility_off),),
                icon: Icon(
                  Icons.edit,
                  color: Colors.blue,
                ),
                labelText: "Current Password",
              ),
            ),
          ),
          Container(
            child: TextField(
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                icon: Icon(
                  Icons.edit,
                  color: Colors.blue,
                ),
                labelText: "New Password",
              ),
            ),
          ),
          Container(
            child: TextField(
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                icon: Icon(Icons.edit, color: Colors.blue,),
                labelText: "Confirm Password",
              ),
            ),
          ),
          SizedBox(height:height*0.06),
          ElevatedButton(
            onPressed: () {
              setState(() {
                myPass = myNewPass;
                Navigator.of(context).pop('password');
              });
            },
            child: Text("Save & exit", style: TextStyle(fontSize: 18, color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
