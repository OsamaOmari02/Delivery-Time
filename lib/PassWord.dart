import 'package:app/Myprovider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    var user = FirebaseAuth.instance.currentUser;
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
      body: ListView(
        padding: EdgeInsets.all(10),
        children: [
          SizedBox(height: height * 0.005),
          Container(
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
          if(provider.authState==authStatus.Authenticating)
            Container(child: CircularProgressIndicator(),
              alignment: Alignment.center),
          if(provider.authState!=authStatus.Authenticating)
            Container(
              padding: EdgeInsets.symmetric(horizontal: width*0.26),
              child: ElevatedButton(
                onPressed: () async {
                  try{
                    if(myNewPass.text.isEmpty || myPass.text.isEmpty ||
                        myNewPassConf.text.isEmpty) {
                      return dialog('Empty field!');
                    }  if (myPass.text != provider.authData['password']) {
                      return dialog('Your current password is not correct');
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
                    setState(() {
                      provider.authState=authStatus.Authenticating;
                    });
                    await
                    FirebaseAuth.instance.currentUser!.updatePassword(myNewPass.text);
                    await
                    FirebaseFirestore.instance.collection('users')
                        .doc(user!.uid)
                        .update({'password':myNewPass.text});
                    setState(() {
                      provider.authData['password'] = myNewPass.text;
                      provider.authState=authStatus.Authenticated;
                    });
                    Navigator.of(context).pop('password');
                  }catch(e)
                  {
                    print(e);
                    provider.authState=authStatus.unAuthenticated;
                  }
                },
                child: Text("Save & exit",
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
        ],
      ),
    );
  }
}
