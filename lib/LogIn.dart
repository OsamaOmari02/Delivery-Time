import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  void initState() {
    Provider.of<MyProvider>(context, listen: false).getAdmin();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
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
                  child:
                  const Text("ok", style: const TextStyle(fontSize: 21)),
                  onPressed: () => Navigator.of(context).pop()),
            ],
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    final emailField = TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      style: const TextStyle(
        color: Colors.white,
      ),
      cursorColor: Colors.white,
      decoration: InputDecoration(
        icon: const Icon(Icons.alternate_email_outlined, color: Colors.white),
        focusedBorder: UnderlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
        hintText: "something@example.com",
        labelText: "Email",
        labelStyle: const TextStyle(
          color: Colors.white,
        ),
        hintStyle: const TextStyle(
          color: Colors.white,
        ),
      ),
    );

    final passwordField = Column(
      children: <Widget>[
        TextFormField(
          obscureText: true,
          controller: _passwordController,
          style: const TextStyle(
            color: Colors.white,
          ),
          cursorColor: Colors.white,
          decoration: const InputDecoration(
            icon: const Icon(Icons.lock, color: Colors.white),
            focusedBorder: const UnderlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.white,
              ),
            ),
            hintText: "password",
            labelText: "Password",
            labelStyle: const TextStyle(
              color: Colors.white,
            ),
            hintStyle: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        if (Provider.of<MyProvider>(context,listen: false).authState == authStatus.unAuthenticated ||
            Provider.of<MyProvider>(context,listen: false).authState == authStatus.Authenticated)
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
                  onPressed: () => Navigator.of(context)
                      .pushReplacementNamed('resetPassword')),
            ],
          ),
      ],
    );

    final fields = Padding(
      padding: const EdgeInsets.only(top: 5.0),
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
        padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
        child: const Text(
          "Login",
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () async {
          try {
            setState(() {
              Provider.of<MyProvider>(context,listen: false).authState = authStatus.Authenticating;
            });
            var auth = (await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text,
            ))
                .user;
            if (auth != null) {
              if (!mounted) return;
              setState(() {
                Provider.of<MyProvider>(context,listen: false).fetch();
                Provider.of<MyProvider>(context,listen: false).authState = authStatus.Authenticated;
              });
              if (_emailController.text.trim() != "admin@gmail.com" &&
                  _passwordController.text != "delivery.time123") {
                Provider.of<MyProvider>(context,listen: false).setAdmin(false);
                Navigator.of(context).pushReplacementNamed('MyHomepage');
              } else {
                Provider.of<MyProvider>(context,listen: false).setAdmin(true);
                Navigator.of(context).pushReplacementNamed('callCenter');
              }
            }
          } on FirebaseAuthException catch (e) {
            e.message == 'Given String is empty or null'
                ? dialog('Empty field!')
                : dialog(e.message);
            setState(() {
              Provider.of<MyProvider>(context,listen: false).authState = authStatus.unAuthenticated;
            });
            _passwordController.clear();
          } catch (e) {
            print(e);
            setState(() {
              Provider.of<MyProvider>(context,listen: false).authState = authStatus.unAuthenticated;
            });
          }
        },
      ),
    );

    final bottom = Column(
      children: <Widget>[
        if (Provider.of<MyProvider>(context,listen: false).authState == authStatus.Authenticating)
          const CircularProgressIndicator(color: Colors.white),
        if (Provider.of<MyProvider>(context,listen: false).authState == authStatus.unAuthenticated ||
            Provider.of<MyProvider>(context,listen: false).authState == authStatus.Authenticated)
          loginButton,
        const Padding(
          padding: EdgeInsets.all(8.0),
        ),
        if (Provider.of<MyProvider>(context,listen: false).authState == authStatus.unAuthenticated ||
            Provider.of<MyProvider>(context,listen: false).authState == authStatus.Authenticated)
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
        backgroundColor: Colors.orangeAccent,
        body: Form(
          key: _formKey,
          child: Container(
            height: mq.size.height,
            child: ListView(
              padding: const EdgeInsets.all(30),
              children: <Widget>[
                SizedBox(height: mq.size.height*0.14),
                Container(
                  margin: EdgeInsets.only(bottom: mq.size.height*0.06),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.deepOrange,
                    boxShadow: [
                      const BoxShadow(
                          blurRadius: 8,
                          color: Colors.black,
                          offset: const Offset(0, 2)),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(
                      vertical: mq.size.height*0.014, horizontal: mq.size.height*0.08),
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
                SizedBox(height: mq.size.height*0.06),
                bottom,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
