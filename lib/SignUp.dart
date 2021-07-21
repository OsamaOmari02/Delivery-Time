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
  TextEditingController _phoneController = TextEditingController();
  bool isVisible = true;
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
    final usernameField = TextFormField(
      controller: _usernameController,
      keyboardType: TextInputType.text,
      style: TextStyle(
        color: Colors.white,
      ),
      cursorColor: Colors.white,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        labelText: "First Name",
        labelStyle: TextStyle(
          color: Colors.white,
        ),
      ),
    );

    final phoneField = TextFormField(
      controller: _phoneController,
      keyboardType: TextInputType.phone,
      style: TextStyle(
        color: Colors.white,
      ),
      cursorColor: Colors.white,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        labelText: "Phone Number",
        labelStyle: TextStyle(
          color: Colors.white,
        ),
        hintStyle: TextStyle(
          color: Colors.white,
        ),
      ),
    );

    final emailField = TextFormField(
      controller: _emailController,
      // key: ValueKey('email'),
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(
        color: Colors.white,
      ),
      cursorColor: Colors.white,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        hintText: "something@example.com",
        labelText: "Email",
        labelStyle: TextStyle(
          color: Colors.white,
        ),
        hintStyle: TextStyle(
          color: Colors.white,
        ),
      ),
    );

    final passwordField = Container(
      child: TextField(
        controller: _passwordController,
        obscureText: isVisible,
        keyboardType: TextInputType.visiblePassword,
        style: TextStyle(
          color: Colors.white,
        ),
        cursorColor: Colors.white,
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                isVisible = !isVisible;
              });
            },
            icon: Icon(isVisible == true ? Icons.visibility : Icons.visibility_off),),
          labelText: "Password",
          labelStyle: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

    final repasswordField = TextFormField(
      obscureText: true,
      controller: _repasswordController,
      style: TextStyle(
        color: Colors.white,
      ),
      cursorColor: Colors.white,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        hintText: "password",
        labelText: "Re-enter Password",
        labelStyle: TextStyle(
          color: Colors.white,
        ),
        hintStyle: TextStyle(
          color: Colors.white,
        ),
      ),
    );
    final fields = Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          usernameField,
          phoneField,
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
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () async {
          if (_usernameController.text.isEmpty)
            return LogoutFun("Empty field!");
          if (_phoneController.text.length!=10 || !_phoneController.text.startsWith("07"))
            return LogoutFun("Invalid phone number");
          if (_passwordController.text!=_repasswordController.text)
            return LogoutFun("Passwords do not match");
          try {
            setState(() {
              provider.authState = authStatus.Authenticating;
            });
                UserCredential authres = await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text,
                );
                  await FirebaseFirestore.instance.collection('users')
                      .doc(authres.user!.uid).set({
                    'email': _emailController.text.trim(),
                    'phone':_phoneController.text,
                    'username':_usernameController.text,
                    'password':_passwordController.text,
                    'uid':authres.user!.uid,
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
      // mainAxisAlignment: MainAxisAlignment.start,
      // crossAxisAlignment: CrossAxisAlignment.stretch,
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
      backgroundColor: Color.fromRGBO(20, 200, 140, 1).withOpacity(0.65),
      body: Form(
        key: _formKey,
          child: Container(
            height: mq.size.height,
            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: ListView(
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height*0.08),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.deepOrange,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 8,
                          color: Colors.black,
                          offset: Offset(0, 2)),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 70),
                  child: Text(
                    "Delivery Time",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                ),
                fields,
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: bottom,
                ),
              ],
            ),
          ),
        ),
    );
  }
}
