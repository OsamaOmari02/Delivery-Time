import 'dart:math';

import 'package:app/Drawer.dart';
import 'package:app/Myprovider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyAccount extends StatefulWidget {
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
          title: Text("My Account"),
          centerTitle: true,
          backgroundColor: Colors.blue),
      body: ListView(
        children: [
            SizedBox(height: height * 0.02),
            ListTile(
              title: Text("My Email",style: TextStyle(fontSize: 19),),
              leading: Icon(Icons.alternate_email),
              trailing: Icon(Icons.arrow_forward),
              onTap: ()=>Navigator.of(context).pushNamed('Email'),
            ),
            Divider(thickness: 1),
            ListTile(
              title: Text("My Name",style: TextStyle(fontSize: 19),),
              leading: Icon(Icons.person),
              trailing: Icon(Icons.arrow_forward),
              onTap: ()=>Navigator.of(context).pushNamed('Name'),
            ),
            Divider(thickness: 1),
            // ListTile(
            //   title: Text("My Phone Number",style: TextStyle(fontSize: 19),),
            //   leading: Icon(Icons.phone),
            //   trailing: Icon(Icons.arrow_forward),
            //   onTap: ()=>Navigator.of(context).pushNamed('Phone'),
            // ),
            // Divider(thickness: 1),
            ListTile(
              title: Text("My Password",style: TextStyle(fontSize: 19),),
              leading: Icon(Icons.password),
              trailing: Icon(Icons.arrow_forward),
              onTap: ()=>Navigator.of(context).pushNamed('password'),
            ),
          ],
        ),
    );
  }
}

//-------------------Email-----------------------------
class Email extends StatefulWidget {
  @override
  _EmailState createState() => _EmailState();
}

class _EmailState extends State<Email> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var provider = Provider.of<MyProvider>(context);
    TextEditingController _email = TextEditingController();
    TextEditingController _password = TextEditingController();
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
          title: Text("Change E-mail"),
          centerTitle: true,
        ),
        body: ListView(
            children: [
            SizedBox(height: height * 0.02),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                autofocus: true,
                controller: _email,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.alternate_email,
                    color: Colors.blue,
                  ),
                  labelText: "E-mail",
                  hintText: provider.authData['email'],
                  helperText: "Tap two times",
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: TextField(
                keyboardType: TextInputType.visiblePassword,
                controller: _password,
                obscureText: true,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.password,
                    color: Colors.blue,
                  ),
                  labelText: "Password",
                ),
              ),
            ),
              SizedBox(height: height*0.08),
              if(provider.authState==authStatus.Authenticating)
                Container(child: CircularProgressIndicator(),
                    alignment: Alignment.center),
              if(provider.authState!=authStatus.Authenticating)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: width*0.26),
                  child: ElevatedButton(
                    onPressed: () async {
                      try{
                        if(_email.text.isEmpty || _password.text.isEmpty) {
                          return dialog('Empty field!');
                        }  if (_password.text != provider.authData['password']) {
                          return dialog('Your password is not correct');
                        } if (_email.text == provider.authData['email']) {
                          return dialog('Your new email must be different than your current email');
                        }
                        setState(() {
                          provider.authState=authStatus.Authenticating;
                        });
                        await
                        FirebaseAuth.instance.currentUser!.updateEmail(_email.text);
                        await
                        FirebaseFirestore.instance.collection('users')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .update({'email':_email.text});
                        setState(() {
                          provider.authData['email'] = _email.text;
                          provider.authState=authStatus.Authenticated;
                        });
                        Navigator.of(context).pop();
                      } on FirebaseAuthException catch (e) {
                        dialog(e.message);
                        setState(() {
                          provider.authState = authStatus.unAuthenticated;
                        });
                      } catch(e)
                      {
                        dialog('error!');
                        provider.authState=authStatus.unAuthenticated;
                      }
                    },
                    child: Text("Save & exit",
                        style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                ),
        ]));
  }
}

//---------------------name ---------------------
class Name extends StatefulWidget {
  @override
  _NameState createState() => _NameState();
}

class _NameState extends State<Name> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var provider = Provider.of<MyProvider>(context);
    var _myName = TextEditingController();
    var _password = TextEditingController();
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
          title: Text("Change Name"),
          centerTitle: true,
        ),
        body: ListView(
            children: [
          SizedBox(height: height * 0.02),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: TextFormField(
                keyboardType: TextInputType.text,
                controller: _myName,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.person,
                    color: Colors.blue,
                  ),
                  labelText: "Name",
                  hintText: provider.authData['name'],
                  helperText: "Tap two times",
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: TextFormField(
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                controller: _password,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.password,
                    color: Colors.blue,
                  ),
                  labelText: "Password",
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
                    if(_myName.text.isEmpty || _password.text.isEmpty) {
                      return dialog('Empty field!');
                    }  if (_password.text != provider.authData['password']) {
                      return dialog('Your password is not correct');
                    }
                    if(_myName.text==provider.authData['name']){
                      return dialog('Your new name must be different than your current name');
                    }
                    setState(() {
                      provider.authState=authStatus.Authenticating;
                    });
                    await
                    FirebaseAuth.instance.currentUser!.updateDisplayName(_myName.text);
                    await
                    FirebaseFirestore.instance.collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .update({'username':_myName.text});
                    setState(() {
                      provider.authData['name'] = _myName.text;
                      provider.authState=authStatus.Authenticated;
                    });
                    Navigator.of(context).pop();
                  } on FirebaseAuthException catch (e) {
                    dialog(e.message);
                    setState(() {
                      provider.authState = authStatus.unAuthenticated;
                    });
                  } catch(e)
                  {
                    dialog('error!');
                    provider.authState=authStatus.unAuthenticated;
                  }
                },
                child: Text("Save & exit",
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
        ]));
  }
}

//----------------phone number--------------------------
class Phone extends StatefulWidget {
  @override
  _PhoneState createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var provider = Provider.of<MyProvider>(context);
    TextEditingController _phone = TextEditingController();
    TextEditingController _password = TextEditingController();
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
          title: Text("Change Phone"),
          centerTitle: true,
        ),
        body: ListView(children: [
          SizedBox(height: height * 0.02),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: TextFormField(
                keyboardType: TextInputType.phone,
                controller: _phone,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.phone,
                    color: Colors.blue,
                  ),
                  labelText: "Phone",
                  hintText: provider.authData['phone'],
                  helperText: "Tap two times",
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: TextFormField(
                keyboardType: TextInputType.visiblePassword,
                controller: _password,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.password,
                    color: Colors.blue,
                  ),
                  labelText: "Password",
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
                    if(_phone.text.isEmpty || _password.text.isEmpty) {
                      return dialog('Empty field!');
                    }
                    if (_password.text != provider.authData['password']) {
                      return dialog('Your password is not correct');
                    }
                    if (_phone.text==provider.authData['phone']){
                      return dialog('New Phone number must be different than current phone number');
                    }
                    setState(() {
                      provider.authState=authStatus.Authenticating;
                    });
                    // PhoneAuthCredential credential = PhoneAuthProvider.credential(
                    //     verificationId: FirebaseAuth.instance.currentUser!.uid
                    //     , smsCode: '${Random()}');
                    // await
                    // FirebaseAuth.instance.currentUser!.updatePhoneNumber(credential);
                    await
                    FirebaseFirestore.instance.collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .update({'phone':_phone.text});
                    setState(() {
                      provider.authData['phone'] = _phone.text;
                      provider.authState=authStatus.Authenticated;
                    });
                    Navigator.of(context).pop();
                  } on FirebaseAuthException catch (e) {
                    dialog(e.message);
                    setState(() {
                      provider.authState = authStatus.unAuthenticated;
                    });
                  } catch(e)
                  {
                    dialog('error!');
                    provider.authState=authStatus.unAuthenticated;
                  }
                },
                child: Text("Save & exit",
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
        ]));
  }
}
