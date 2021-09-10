import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'Myprovider.dart';

class Register extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _repasswordController = TextEditingController();
  FocusNode nameNode = FocusNode();
  FocusNode emailNode = FocusNode();
  FocusNode passNode = FocusNode();
  FocusNode repassNode = FocusNode();
  bool isVisible = true;
  @override
  void initState() {
    nameNode = FocusNode();
    emailNode = FocusNode();
    passNode = FocusNode();
    repassNode = FocusNode();
    super.initState();
  }
  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _repasswordController.dispose();
    nameNode.dispose();
    emailNode.dispose();
    passNode.dispose();
    repassNode.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    var provider = Provider.of<MyProvider>(context);
    LogoutFun(title) {
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
                    child: Text("OK", style: const TextStyle(fontSize: 21)),
                    onPressed: () => Navigator.of(context).pop()),
              ],
            );
          });
    }
    void requestNode(BuildContext context,FocusNode focusNode){
      FocusScope.of(context).requestFocus(focusNode);
    }
    final usernameField = TextFormField(
      focusNode: nameNode,
      onEditingComplete: ()=>requestNode(context,emailNode),
      textInputAction: TextInputAction.next,
      controller: _usernameController,
      keyboardType: TextInputType.text,
      style: const TextStyle(
        color: Colors.white,
      ),
      cursorColor: Colors.white,
      decoration: const InputDecoration(
        icon: const Icon(Icons.person,color: Colors.white),
        focusedBorder: const UnderlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
        labelText: "First Name",
        labelStyle: const TextStyle(
          color: Colors.white,
        ),
      ),
    );


    final emailField = TextFormField(
      focusNode: emailNode,
      onEditingComplete: ()=>requestNode(context,passNode),
      textInputAction: TextInputAction.next,
      controller: _emailController,
      // key: ValueKey('email'),
      keyboardType: TextInputType.emailAddress,
      style: const TextStyle(
        color: Colors.white,
      ),
      cursorColor: Colors.white,
      decoration: const InputDecoration(
        icon: const Icon(Icons.alternate_email_outlined,color: Colors.white),
        focusedBorder: const UnderlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
        hintText: "something@example.com",
        labelText: "Email",
        labelStyle:const TextStyle(
          color: Colors.white,
        ),
        hintStyle: const TextStyle(
          color: Colors.white,
        ),
      ),
    );

    final passwordField = Container(
      child: TextField(
        focusNode: passNode,
        onEditingComplete: ()=>requestNode(context,repassNode),
        textInputAction: TextInputAction.next,
        controller: _passwordController,
        obscureText: isVisible,
        keyboardType: TextInputType.visiblePassword,
        style: const TextStyle(
          color: Colors.white,
        ),
        cursorColor: Colors.white,
        decoration: InputDecoration(
          icon: const Icon(Icons.lock,color: Colors.white),
          focusedBorder: const UnderlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.white,
            ),
          ),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                isVisible = !isVisible;
              });
            },
            icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off),color: Colors.white,),
          labelText: "Password",
          labelStyle: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

    final repasswordField = TextFormField(
      focusNode: repassNode,
      obscureText: true,
      controller: _repasswordController,
      style: const TextStyle(
        color: Colors.white,
      ),
      cursorColor: Colors.white,
      decoration: const InputDecoration(
        icon: const Icon(Icons.lock,color: Colors.white),
        focusedBorder: const UnderlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
        hintText: "password",
        labelText: "Re-enter Password",
        labelStyle: const TextStyle(
          color: Colors.white,
        ),
        hintStyle: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
    final fields = Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          usernameField,
          emailField,
          passwordField,
          repasswordField,
        ],
      ),
    );

    final registerButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.white,
      child: MaterialButton(
        minWidth: mq.size.width / 1.2,
        padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
        child: Text(
          "Register",
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () async {
          if (_usernameController.text.isEmpty)
            return LogoutFun("Empty field!");
          if (_passwordController.text!=_repasswordController.text)
            return LogoutFun("Passwords do not match");
          try {
            setState(() {
              provider.authState = authStatus.Authenticating;
            });
                UserCredential authRes = await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text,
                );
                  await FirebaseFirestore.instance.collection('users')
                      .doc(authRes.user!.uid).set({
                    'email': _emailController.text.trim(),
                    'username':_usernameController.text,
                    'password':_passwordController.text,
                  });
                  setState(() {
                    provider.authState = authStatus.Authenticated;
                  });
                  provider.fetch();
                  Navigator.of(context).pushReplacementNamed('MyHomepage');
          } on FirebaseAuthException catch (e) {
             e.message=='Given String is empty or null'?LogoutFun('Empty field!'):LogoutFun(e.message);
            print(e);
             setState(() {
               provider.authState = authStatus.unAuthenticated;
               _passwordController.clear();
               _repasswordController.clear();
             });
          } catch (e) {
            print(e);
            setState(() {
              provider.authState = authStatus.unAuthenticated;
              _passwordController.clear();
              _repasswordController.clear();
            });
          }
        },
      ),
    );

    final bottom = Column(
      children: <Widget>[
        SizedBox(height: MediaQuery.of(context).size.height*0.05),
        if (provider.authState==authStatus.Authenticating)
          CircularProgressIndicator(color: Colors.white),
        if (provider.authState==authStatus.unAuthenticated||provider.authState==authStatus.Authenticated)
          registerButton,
        Padding(
          padding: EdgeInsets.all(8.0),
        ),
        if (provider.authState==authStatus.unAuthenticated||provider.authState==authStatus.Authenticated)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Already have an account?",
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: Colors.white,
                  ),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('login');
              },
              child: Text(
                "Login",
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                    ),
              ),
            ),
          ],
        ),
      ],
    );

    return Scaffold(
      backgroundColor: Colors.blue,
      body: Form(
        key: _formKey,
          child: Container(
            height: mq.size.height,
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: ListView(
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height*0.15),
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.deepOrange,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 8,
                          color: Colors.black,
                          offset: const Offset(0, 2)),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 70),
                    child: const Text(
                      "Delivery Time",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                fields,
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: bottom,
                ),
              ],
            ),
          ),
        ),
    );
  }
}
