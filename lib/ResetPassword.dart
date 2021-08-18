import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          SizedBox(height: 40),
          Align(
            alignment: Alignment.center,
            child: Text("Reset Password", style: TextStyle(fontSize: 20)),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                icon: Icon(Icons.alternate_email_outlined),
                hintText: "Type your email",
                labelText: "Email",
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 60),
            child: ElevatedButton(
                onPressed: () async {
                  try{
                    if (_emailController.text.isEmpty)
                      return dialog("Empty Field !");
                    await FirebaseAuth.instance.
                    sendPasswordResetEmail(email: _emailController.text);
                    Fluttertoast.showToast(
                        msg: "A password reset link has been sent to your E-mail",
                        toastLength: Toast.LENGTH_SHORT,
                        backgroundColor: Colors.grey,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );

                    print("done");
                  } on FirebaseException catch (e){
                    dialog(e.message);
                  } catch (e){
                    dialog("Error !");
                    print(e);
                  }
                }, child: Text("Send Request")),
          ),
          TextButton( onPressed: ()=>Navigator.of(context).pushReplacementNamed('login'),
              child: Text("Go back")),
        ],
      ),
    );
  }
}
