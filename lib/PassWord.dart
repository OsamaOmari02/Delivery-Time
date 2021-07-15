import 'package:app/Myprovider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Drawer.dart';

class MyPassword extends StatefulWidget {
  @override
  _MyPasswordState createState() => _MyPasswordState();
}

class _MyPasswordState extends State<MyPassword> {
  bool isVisible = true;

  var myPass = TextEditingController();
  var myNewPass = TextEditingController();
  var myNewPassConf = TextEditingController();

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
      appBar: AppBar(
        title: Text("Change password"),
      ),
      body: Column(
        children: [
          SizedBox(height: height * 0.05),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 7),
            child: TextField(
              controller: myPass,
              obscureText: isVisible,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isVisible = !isVisible;
                    });
                  },
                  icon: Icon(isVisible == true
                      ? Icons.visibility
                      : Icons.visibility_off),
                ),
                icon: Icon(
                  Icons.edit,
                  color: Colors.blue,
                ),
                labelText: "Current Password",
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 7),
            child: TextField(
              obscureText: true,
              controller: myNewPass,
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
            padding: EdgeInsets.symmetric(horizontal: 7),
            child: TextField(
              obscureText: true,
              controller: myNewPassConf,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                icon: Icon(
                  Icons.edit,
                  color: Colors.blue,
                ),
                labelText: "Confirm Password",
              ),
            ),
          ),
          SizedBox(height: height * 0.06),
          ElevatedButton(
            onPressed: () async {
              if (myPass.text != provider.authData['password']) {
                 return dialog('Your current password is not correct');
              }  if(myNewPass.text.isEmpty || myPass.text.isEmpty ||
                  myNewPassConf.text.isEmpty) {
                return dialog('Empty field!');
              }
                 if(myNewPassConf.text!=myNewPass.text){
                  return dialog('The passwords do not match!');
              }
                 if (myNewPass.text.length<6){
                   return dialog('Password must be at least 6 characters');
                 }
                 if (myNewPass.text==provider.authData['password']){
                   return dialog('New password must be different than old password');
                 }
                {
              setState(() {
                //نغير الباسوورد بالفايربيس اول
              });
                Navigator.of(context).pop('password');
              }
            },
            child: Text("Save & exit",
                style: TextStyle(fontSize: 18, color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
