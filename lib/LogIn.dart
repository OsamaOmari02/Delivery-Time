import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'Myprovider.dart';

class Login extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<Login> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
                children:
                [
                  Icon(Icons.error_outline,size: 30,color: Colors.red,),
                  SizedBox(width: 17),
                  Expanded(
                    child: Text(
                        title,
                        style: TextStyle(fontSize: 23,color: Colors.red),
                      ),
                  ),
                ],
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 8),
              elevation: 24,
              content: Container(
                height: MediaQuery.of(context).size.height*0.05,
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

    final emailField = TextFormField(
      controller: _emailController,
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

    final passwordField = Column(
      children: <Widget>[
        TextFormField(
          obscureText: true,
          controller: _passwordController,
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
            labelText: "Password",
            labelStyle: TextStyle(
              color: Colors.white,
            ),
            hintStyle: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(2.0),
        ),
        if (provider.authState==authStatus.unAuthenticated||provider.authState==authStatus.Authenticated)
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            MaterialButton(
                child: Text(
                  "Forgot Password",
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(color: Colors.white),
                ),
                onPressed: ()=> Navigator.of(context).pushReplacementNamed('resetPassword')
            ),
          ],
        ),
      ],
    );

    final fields = Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          emailField,
          passwordField,
        ],
      ),
    );

    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.white,
      child: MaterialButton(
        minWidth: mq.size.width / 1.2,
        padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
        child: Text(
          "Login",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () async {
          try {
            setState(() {
              provider.authState = authStatus.Authenticating;
            });
            var auth = (await FirebaseAuth.instance.signInWithEmailAndPassword(
              email:_emailController.text.trim(),
              password: _passwordController.text,
            )).user;
            if (auth != null) {
              setState(() {
                provider.authState = authStatus.Authenticated;
              });
              provider.fetch();
              Navigator.of(context).pushReplacementNamed('MyHomepage');
            }
          } on FirebaseAuthException catch (e) {
            e.message=='Given String is empty or null'?LogoutFun('Empty field!'):
            LogoutFun(e.message);
            setState(() {
              provider.authState = authStatus.unAuthenticated;
            });
            _passwordController.clear();
          } catch(e){
            print(e);
            setState(() {
              provider.authState = authStatus.unAuthenticated;
            });
          }
        },
      ),
    );

    final bottom = Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      // crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        if (provider.authState==authStatus.Authenticating)
          CircularProgressIndicator(color: Colors.white),
        if (provider.authState==authStatus.unAuthenticated||provider.authState==authStatus.Authenticated)
        loginButton,
        Padding(
          padding: EdgeInsets.all(8.0),
        ),
        if (provider.authState==authStatus.unAuthenticated||provider.authState==authStatus.Authenticated)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Not a member?",
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: Colors.white,
                  ),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('Signup');
              },
              child: Text(
                "Sign Up",
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

    return SafeArea(
      child: Scaffold(
        // backgroundColor: Color.fromRGBO(0, 0, 100, 1).withOpacity(0.65),
        backgroundColor: Colors.blue,
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(36),
            child: Container(
              height: mq.size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  SizedBox(height: 40),
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
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 60),
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
                    padding: EdgeInsets.only(bottom: 150),
                    child: bottom,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
