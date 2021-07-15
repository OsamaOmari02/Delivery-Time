import 'package:app/Myprovider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AddAddress extends StatefulWidget {
  @override
  _AddAddressState createState() => _AddAddressState();
}
class _AddAddressState extends State<AddAddress> {
  var _area = TextEditingController();
  var _street = TextEditingController();
  var _phone = TextEditingController();

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  // validator() {
  //
  // }

  String? validPass(val) {
    if (val.toString().isEmpty)
      return "Required";
    else {
      return null;
    }
  }

  // address(title, keyboard, cont) {
  //   return TextFormField(
  //     controller: cont,
  //     // initialValue: userAddress,
  //     decoration: InputDecoration(
  //       labelText: title,
  //       contentPadding: EdgeInsets.symmetric(horizontal: 9),
  //     ),
  //     keyboardType: keyboard,
  //   );
  // }
  required(title, keyboard, cont) {
    return TextFormField(
      controller: cont,
      validator: validPass,
      // initialValue: userAddress,
      decoration: InputDecoration(
        labelText: title,
        contentPadding: EdgeInsets.symmetric(horizontal: 9),
      ),
      keyboardType: keyboard,
    );
  }

  requiredPhone(title, keyboard, value) {
    return TextFormField(
      // initialValue: value,
      controller: value,
      validator: (val) {
        if (val.toString().isEmpty || !val.toString().startsWith("07") || val!.length!=10)
          return "Invalid";
        else {
          return null;
        }
      },
      // initialValue: userAddress,
      decoration: InputDecoration(
        labelText: title,
        contentPadding: EdgeInsets.symmetric(horizontal: 9),
      ),
      keyboardType: keyboard,
    );
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("New Address"),
      ),
      body: Form(
        key: _formkey,
        child: ListView(
          children: [
            SizedBox(height: 20),
            required("Area (required)", TextInputType.text, _area),
            SizedBox(height: 20),
            required("Street (required)", TextInputType.text, _street),
            SizedBox(height: 20),
            requiredPhone(
                "Phone Number (required)", TextInputType.number, _phone),
            SizedBox(height: 40),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.33,
              ),
              child: ElevatedButton(
                onPressed: () async {
                  var user = FirebaseAuth.instance.currentUser;
                  await FirebaseFirestore.instance.collection('/address/${user!.uid}/addresses')
                      .add({
                        'area' :_area.text,
                        'street':_street.text,
                        'phoneNum':_phone.text,
                        'uid':user.uid,
                      });
                },
                child: Text(
                  "Add",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
