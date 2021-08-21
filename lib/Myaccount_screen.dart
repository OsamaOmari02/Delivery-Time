
import 'package:app/Drawer.dart';
import 'package:app/Myprovider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'LanguageProvider.dart';

class MyAccount extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    var lanProvider = Provider.of<LanProvider>(context);
    return Directionality(
      textDirection: lanProvider.isEn?TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
            title: Text(lanProvider.texts('my account')),
            centerTitle: true,
            backgroundColor: Colors.blue),
        body: ListView(
          children: [
              SizedBox(height: height * 0.02),
              ListTile(
                title: Text(lanProvider.texts('my email'),style: const TextStyle(fontSize: 19),),
                leading: const Icon(Icons.alternate_email),
                trailing: const Icon(Icons.arrow_forward),
                onTap: ()=>Navigator.of(context).pushNamed('Email'),
              ),
              const Divider(thickness: 1),
              ListTile(
                title: Text(lanProvider.texts('my name'),style:const TextStyle(fontSize: 19),),
                leading: const Icon(Icons.person),
                trailing: const Icon(Icons.arrow_forward),
                onTap: ()=>Navigator.of(context).pushNamed('Name'),
              ),
              const Divider(thickness: 1),
              // ListTile(
              //   title: Text("My Phone Number",style: TextStyle(fontSize: 19),),
              //   leading: Icon(Icons.phone),
              //   trailing: Icon(Icons.arrow_forward),
              //   onTap: ()=>Navigator.of(context).pushNamed('Phone'),
              // ),
              // Divider(thickness: 1),
              ListTile(
                title: Text(lanProvider.texts('my password'),style: const TextStyle(fontSize: 19),),
                leading: const Icon(Icons.lock),
                trailing: const Icon(Icons.arrow_forward),
                onTap: ()=>Navigator.of(context).pushNamed('password'),
              ),
            ],
          ),
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

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var provider = Provider.of<MyProvider>(context);
    var lanProvider = Provider.of<LanProvider>(context);
    dialog(title) {
      return showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return AlertDialog(
              title: Row(
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 30,
                    color: Colors.red,
                  ),
                  const SizedBox(width: 17),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(fontSize: 23, color: Colors.red),
                    ),
                  ),
                ],
              ),
              contentPadding:const EdgeInsets.symmetric(vertical: 8),
              elevation: 24,
              content: Container(
                height: MediaQuery.of(context).size.height * 0.05,
                child: const Divider(),
                alignment: Alignment.topCenter,
              ),
              actions: [
                TextButton(
                    child: Text(lanProvider.texts('ok'), style: const TextStyle(fontSize: 21)),
                    onPressed: () => Navigator.of(context).pop()),
              ],
            );
          });
    }
    return Directionality(
      textDirection: lanProvider.isEn?TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
            title: Text(lanProvider.texts('change email')),
            centerTitle: true,
          ),
          body: ListView(
              children: [
              SizedBox(height: height * 0.02),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _email,
                  decoration: InputDecoration(
                    icon: const Icon(
                      Icons.alternate_email,
                      color: Colors.blue,
                    ),
                    labelText: lanProvider.texts("email"),
                    hintText: provider.authData['email'],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: TextField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: _password,
                  obscureText: true,
                  decoration: InputDecoration(
                    icon: const Icon(
                      Icons.lock,
                      color: Colors.blue,
                    ),
                    labelText: lanProvider.texts('pass'),
                  ),
                ),
              ),
                SizedBox(height: height*0.08),
                if(provider.authState==authStatus.Authenticating)
                  Container(child: const CircularProgressIndicator(),
                      alignment: Alignment.center),
                if(provider.authState!=authStatus.Authenticating)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: width*0.26),
                    child: ElevatedButton(
                      onPressed: () async {
                        try{
                          if(_email.text.trim().isEmpty || _password.text.isEmpty) {
                            return dialog(lanProvider.texts('empty field'));
                          }  if (_password.text != provider.authData['password']) {
                            return dialog(lanProvider.texts('ur password isnt correct'));
                          } if (_email.text.trim() == provider.authData['email']) {
                            return dialog(lanProvider.texts('new email must diff'));
                          }
                          setState(() {
                            provider.authState=authStatus.Authenticating;
                          });
                          await
                          FirebaseAuth.instance.currentUser!.updateEmail(_email.text.trim());
                          await
                          FirebaseFirestore.instance.collection('users')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .update({'email':_email.text.trim()});
                          setState(() {
                            provider.authData['email'] = _email.text.trim();
                            provider.authState=authStatus.Authenticated;
                          });
                          Navigator.of(context).pop();
                          Fluttertoast.showToast(
                              msg: lanProvider.texts('Email Updated Successfully'),
                              toastLength: Toast.LENGTH_SHORT,
                              backgroundColor: Colors.grey,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                        } on FirebaseAuthException catch (e) {
                          if (e.message=="This operation is sensitive and requires"
                              " recent authentication. Log in again before retrying this request.")
                            {
                              setState(() {
                                provider.authState=authStatus.Authenticating;
                              });
                              AuthCredential credential = EmailAuthProvider.credential(email: provider.authData['email']!, password: provider.authData['password']!);
                              await FirebaseAuth.instance.currentUser!.reauthenticateWithCredential(credential);
                              await
                              FirebaseAuth.instance.currentUser!.updateEmail(_email.text.trim());
                              await
                              FirebaseFirestore.instance.collection('users')
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .update({'email':_email.text.trim()});
                              setState(() {
                                provider.authData['email'] = _email.text.trim();
                                provider.authState=authStatus.Authenticated;
                              });
                              Navigator.of(context).pop();
                              Fluttertoast.showToast(
                                  msg: lanProvider.texts('Email Updated Successfully'),
                                  toastLength: Toast.LENGTH_SHORT,
                                  backgroundColor: Colors.grey,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                            }
                          else
                            {
                              if (e.message=="The email address is badly formatted.")
                              dialog(lanProvider.texts('badly formatted'));
                              else
                                dialog(e.message);
                              setState(() {
                                provider.authState = authStatus.unAuthenticated;
                              });
                            }
                          print(e.message);
                        } catch(e)
                        {
                          dialog(lanProvider.texts('Error occurred !'));
                          print(e);
                          setState(() {
                            provider.authState=authStatus.unAuthenticated;
                          });
                        }
                      },
                      child: Text(lanProvider.texts('save&exit'),
                          style: const TextStyle(fontSize: 18, color: Colors.white)),
                    ),
                  ),
          ])),
    );
  }

}

//---------------------name ---------------------
class Name extends StatefulWidget {
  @override
  _NameState createState() => _NameState();
}

class _NameState extends State<Name> {
  TextEditingController _myName = TextEditingController();
  TextEditingController _password = TextEditingController();
  @override
  void dispose() {
    _myName.dispose();
    _password.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var provider = Provider.of<MyProvider>(context);
    var lanProvider = Provider.of<LanProvider>(context);
    dialog(title) {
      return showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return AlertDialog(
              title: Row(
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 30,
                    color: Colors.red,
                  ),
                  const SizedBox(width: 17),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(fontSize: 23, color: Colors.red),
                    ),
                  ),
                ],
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 8),
              elevation: 24,
              content: Container(
                height: MediaQuery.of(context).size.height * 0.05,
                child: const Divider(),
                alignment: Alignment.topCenter,
              ),
              actions: [
                TextButton(
                    child: Text(lanProvider.texts('ok'), style: const TextStyle(fontSize: 21)),
                    onPressed: () => Navigator.of(context).pop()),
              ],
            );
          });
    }
    return Directionality(
      textDirection: lanProvider.isEn?TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
            title: Text(lanProvider.texts('change name')),
            centerTitle: true,
          ),
          body: ListView(
              padding: EdgeInsets.symmetric(horizontal: 12),
                children: [
              SizedBox(height: height * 0.02),
              TextFormField(
                    keyboardType: TextInputType.text,
                    controller: _myName,
                    decoration: InputDecoration(
                      icon: const Icon(
                        Icons.person,
                        color: Colors.blue,
                      ),
                      labelText: lanProvider.texts('name'),
                      hintText: provider.authData['name'],
                    ),
                  ),
               TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    controller: _password,
                    decoration: InputDecoration(
                      icon: const Icon(
                        Icons.lock,
                        color: Colors.blue,
                      ),
                      labelText: lanProvider.texts('pass'),
                    ),
                  ),
              SizedBox(height: height * 0.06),
              if(provider.authState==authStatus.Authenticating)
                Container(child: const CircularProgressIndicator(),
                    alignment: Alignment.center),
              if(provider.authState!=authStatus.Authenticating)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: width*0.26),
                  child: ElevatedButton(
                    onPressed: () async {
                      try{
                        if(_myName.text.isEmpty || _password.text.isEmpty) {
                          return dialog(lanProvider.texts('empty field'));
                        }  if (_password.text != provider.authData['password']) {
                          return dialog(lanProvider.texts('ur password isnt correct'));
                        }
                        if(_myName.text==provider.authData['name']){
                          return dialog(lanProvider.texts('new name must diff'));
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
                        Fluttertoast.showToast(
                            msg: lanProvider.texts('Name Updated Successfully'),
                            toastLength: Toast.LENGTH_SHORT,
                            backgroundColor: Colors.grey,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      } on FirebaseAuthException catch (e) {
                        dialog(e.message);
                        setState(() {
                          provider.authState = authStatus.unAuthenticated;
                        });
                      } catch(e)
                      {
                        dialog(lanProvider.texts('Error occurred !'));
                        provider.authState=authStatus.unAuthenticated;
                      }
                    },
                    child: Text(lanProvider.texts('save&exit'),
                        style: const TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                ),
            ]),
          ),
    );
  }
}

//----------------phone number--------------------------
class Phone extends StatefulWidget {
  @override
  _PhoneState createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  TextEditingController _phone = TextEditingController();
  TextEditingController _password = TextEditingController();
  void dispose() {
    _phone.dispose();
    _password.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var provider = Provider.of<MyProvider>(context);
    var lanProvider = Provider.of<LanProvider>(context);
    dialog(title) {
      return showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return AlertDialog(
              title: Row(
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 30,
                    color: Colors.red,
                  ),
                  const SizedBox(width: 17),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(fontSize: 23, color: Colors.red),
                    ),
                  ),
                ],
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 8),
              elevation: 24,
              content: Container(
                height: MediaQuery.of(context).size.height * 0.05,
                child: const Divider(),
                alignment: Alignment.topCenter,
              ),
              actions: [
                TextButton(
                    child: Text(lanProvider.texts('ok'), style: const TextStyle(fontSize: 21)),
                    onPressed: () => Navigator.of(context).pop()),
              ],
            );
          });
    }
    return Directionality(
      textDirection: lanProvider.isEn?TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
            title: Text("Change Phone"),
            centerTitle: true,
          ),
          body: ListView(children: [
            SizedBox(height: height * 0.02),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: _phone,
                  decoration: InputDecoration(
                    icon: const Icon(
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
                    icon: const Icon(
                      Icons.lock,
                      color: Colors.blue,
                    ),
                    labelText: "Password",
                  ),
                ),
              ),
            SizedBox(height: height * 0.06),
            if(provider.authState==authStatus.Authenticating)
              Container(child: const CircularProgressIndicator(),
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
                      dialog(lanProvider.texts('Error occurred !'));
                      provider.authState=authStatus.unAuthenticated;
                    }
                  },
                  child: Text(lanProvider.texts('save&exit'),
                      style: const TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ),
          ])),
    );
  }
}
