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
  var user = FirebaseAuth.instance.currentUser;
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
                    child: Text( Provider.of<LanProvider>(context,listen: false).texts('ok'), style:const TextStyle(fontSize: 21)),
                    onPressed: () => Navigator.of(context).pop()),
              ],
            );
          });
    }

    return Directionality(
      textDirection:  Provider.of<LanProvider>(context,listen: false).isEn?TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text( Provider.of<LanProvider>(context,listen: false).texts('my password')),
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
                  labelText:  Provider.of<LanProvider>(context,listen: false).texts('current pass'),
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
                  labelText:  Provider.of<LanProvider>(context,listen: false).texts('new pass'),
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
                  labelText:  Provider.of<LanProvider>(context,listen: false).texts('confirm pass'),
                ),
              ),
            ),
            SizedBox(height: height * 0.06),
            if(Provider.of<MyProvider>(context,listen: false).authState==authStatus.Authenticating)
              Container(child: const CircularProgressIndicator(),
                alignment: Alignment.center),
            if(Provider.of<MyProvider>(context,listen: false).authState!=authStatus.Authenticating)
              Container(
                padding: EdgeInsets.symmetric(horizontal: width*0.26),
                child: ElevatedButton(
                  onPressed: () async {
                    try{
                      if(myNewPass.text.isEmpty || myPass.text.isEmpty ||
                          myNewPassConf.text.isEmpty) {
                        return dialog( Provider.of<LanProvider>(context,listen: false).texts('empty field'));
                      }  if (myPass.text != Provider.of<MyProvider>(context,listen: false).authData['password']) {
                        return dialog( Provider.of<LanProvider>(context,listen: false).texts('ur password isnt correct'));
                      }
                      if(myNewPassConf.text!=myNewPass.text){
                        return dialog( Provider.of<LanProvider>(context,listen: false).texts('passwords dont match'));
                      }
                      if (myNewPass.text.length<6){
                        return dialog( Provider.of<LanProvider>(context,listen: false).texts('pass must be 6'));
                      }
                      if (myNewPass.text==Provider.of<MyProvider>(context,listen: false).authData['password']){
                        return dialog( Provider.of<LanProvider>(context,listen: false).texts('new pass must be'));
                      }
                      setState(() {
                        Provider.of<MyProvider>(context,listen: false).authState=authStatus.Authenticating;
                      });
                      await
                      FirebaseAuth.instance.currentUser!.updatePassword(myNewPass.text);
                      await
                      FirebaseFirestore.instance.collection('users')
                          .doc(user!.uid)
                          .update({'password':myNewPass.text});
                      setState(() {
                        Provider.of<MyProvider>(context,listen: false).authData['password'] = myNewPass.text;
                        Provider.of<MyProvider>(context,listen: false).authState=authStatus.Authenticated;
                      });
                      Navigator.of(context).pop('password');
                      Fluttertoast.showToast(
                          msg:  Provider.of<LanProvider>(context,listen: false).texts('Pass Updated'),
                          toastLength: Toast.LENGTH_SHORT,
                          backgroundColor: Colors.grey,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                    } on FirebaseException catch (e){
                      if (e.message=="This operation is sensitive and requires"
                          " recent authentication. Log in again before retrying this request.") {
                        setState(() {
                          Provider.of<MyProvider>(context,listen: false).authState = authStatus.Authenticating;
                        });
                        AuthCredential credential = EmailAuthProvider
                            .credential(email: Provider.of<MyProvider>(context,listen: false).authData['email']!,
                            password: Provider.of<MyProvider>(context,listen: false).authData['password']!);
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
                          Provider.of<MyProvider>(context,listen: false).authData['password'] = myNewPass.text;
                          Provider.of<MyProvider>(context,listen: false).authState = authStatus.Authenticated;
                        });
                        Navigator.of(context).pop('password');
                        Fluttertoast.showToast(
                            msg:  Provider.of<LanProvider>(context,listen: false).texts('Pass Updated'),
                            toastLength: Toast.LENGTH_SHORT,
                            backgroundColor: Colors.grey,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }
                      else {
                        dialog(e.message);
                        setState(() {
                          Provider.of<MyProvider>(context,listen: false).authState = authStatus.unAuthenticated;
                        });
                      }
                    }
                    catch(e) {
                      dialog( Provider.of<LanProvider>(context,listen: false).texts('Error occurred !'));
                      print(e);
                      setState(() {
                        Provider.of<MyProvider>(context,listen: false).authState=authStatus.unAuthenticated;
                      });
                    }
                  },
                  child: Text( Provider.of<LanProvider>(context,listen: false).texts('save&exit'),
                      style: const TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
