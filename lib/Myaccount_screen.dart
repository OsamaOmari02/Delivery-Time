import 'package:app/Drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({Key? key}) : super(key: key);

  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  Container con(icon, text, type, flag, user, cont) {
    return Container(
      child: TextField(
        controller: cont,
        readOnly: flag,
        keyboardType: type,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: Colors.blue,
          ),
          labelText: text,
          hintText: user,
        ),
      ),
    );
  }

  bool isVisible = true;
  var userName = "";
  var userEmail = "osama@gmail.com";
  var userPassword = "osama";
  var userPhoneNum = "";
  var myPhone = TextEditingController();
  var myName = TextEditingController();
  var myEmail = TextEditingController();
  var myOldPass = TextEditingController();

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text("My account"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        children: [
          SizedBox(height: height*0.02),
          Column(
            children: [
              con(Icons.person, "Full Name", TextInputType.text, false, userName, myName),
              con(Icons.alternate_email, "Email", TextInputType.emailAddress, true, userEmail, myEmail),
              con(Icons.phone, "Phone number", TextInputType.number, false, userPhoneNum, myPhone),
            ],
          ),
          SizedBox(height: height*0.02),
          TextButton(
            onPressed: () {
              setState(() {
                Navigator.of(context).pushNamed('password');
              });
            },
            child: Text("Change password", style: TextStyle(fontSize: 16, color: Colors.black45)),
          ),
          SizedBox(height: height*0.02),
          Container(
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  userName=myName as String;
                  userPhoneNum=myPhone as String;
                });
              },
              child: Text("Save",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
            ),
          ),
        ],
      ),
    );
  }
}
