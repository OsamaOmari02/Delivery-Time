import 'package:app/Myprovider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'LanguageProvider.dart';

class MyPassword extends StatefulWidget {
  @override
  _MyPasswordState createState() => _MyPasswordState();
}

class _MyPasswordState extends State<MyPassword> {
  bool isVisible = true;

  TextEditingController myPass = TextEditingController();
  TextEditingController myNewPass = TextEditingController();
  TextEditingController myNewPassConf = TextEditingController();
  @override
  void dispose() {
    myPass.dispose();
    myNewPass.dispose();
    myNewPassConf.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var provider = Provider.of<MyProvider>(context);
    var lanProvider = Provider.of<LanProvider>(context);
    var user = FirebaseAuth.instance.currentUser;
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
                    child: Text(lanProvider.texts('ok'), style:const TextStyle(fontSize: 21)),
                    onPressed: () => Navigator.of(context).pop()),
              ],
            );
          });
    }

    return Directionality(
      textDirection: lanProvider.isEn?TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(lanProvider.texts('my password')),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: ListView(
          padding: const EdgeInsets.all(10),
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
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.blue,
                  ),
                  labelText: lanProvider.texts('current pass'),
                ),
              ),
            ),
            Container(
              child: TextField(
                obscureText: true,
                controller: myNewPass,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.blue,
                  ),
                  labelText: lanProvider.texts('new pass'),
                ),
              ),
            ),
            Container(
              child: TextField(
                obscureText: true,
                controller: myNewPassConf,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.blue,
                  ),
                  labelText: lanProvider.texts('confirm pass'),
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
                      if(myNewPass.text.isEmpty || myPass.text.isEmpty ||
                          myNewPassConf.text.isEmpty) {
                        return dialog(lanProvider.texts('empty field'));
                      }  if (myPass.text != provider.authData['password']) {
                        return dialog(lanProvider.texts('ur password isnt correct'));
                      }
                      if(myNewPassConf.text!=myNewPass.text){
                        return dialog(lanProvider.texts('passwords dont match'));
                      }
                      if (myNewPass.text.length<6){
                        return dialog(lanProvider.texts('pass must be 6'));
                      }
                      if (myNewPass.text==provider.authData['password']){
                        return dialog(lanProvider.texts('new pass must be'));
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
                      Fluttertoast.showToast(
                          msg: lanProvider.texts('Pass Updated'),
                          toastLength: Toast.LENGTH_SHORT,
                          backgroundColor: Colors.grey,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                    } on FirebaseException catch (e){
                      if (e.message=="This operation is sensitive and requires"
                          " recent authentication. Log in again before retrying this request.") {
                        setState(() {
                          provider.authState = authStatus.Authenticating;
                        });
                        AuthCredential credential = EmailAuthProvider
                            .credential(email: provider.authData['email']!,
                            password: provider.authData['password']!);
                        await FirebaseAuth.instance.currentUser!
                            .reauthenticateWithCredential(credential);
                        await
                        FirebaseAuth.instance.currentUser!.updatePassword(
                            myNewPass.text);
                        await
                        FirebaseFirestore.instance.collection('users')
                            .doc(user!.uid)
                            .update({'password': myNewPass.text});
                        setState(() {
                          provider.authData['password'] = myNewPass.text;
                          provider.authState = authStatus.Authenticated;
                        });
                        Navigator.of(context).pop('password');
                        Fluttertoast.showToast(
                            msg: lanProvider.texts('Pass Updated'),
                            toastLength: Toast.LENGTH_SHORT,
                            backgroundColor: Colors.grey,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }
                      else {
                        dialog(e.message);
                        setState(() {
                          provider.authState = authStatus.unAuthenticated;
                        });
                      }
                    }
                    catch(e) {
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
          ],
        ),
      ),
    );
  }
}
