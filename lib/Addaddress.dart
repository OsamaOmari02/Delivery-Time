import 'package:app/LanguageProvider.dart';
import 'package:app/Myprovider.dart';
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

  String? validPass(val) {
    if (val.toString().isEmpty)
      return "Required";
    else {
      return null;
    }
  }

  required(title, keyboard, cont) {
    return TextFormField(
      controller: cont,
      validator: validPass,
      decoration: InputDecoration(
        labelText: title,
        contentPadding: EdgeInsets.symmetric(horizontal: 9),
      ),
      keyboardType: keyboard,
    );
  }

  requiredPhone(title, keyboard, value) {
    return TextFormField(
      controller: value,
      validator: (val) {
        if (val.toString().isEmpty ||
            !val.toString().startsWith("07") ||
            val!.length != 10)
          return "Invalid";
        else {
          return null;
        }
      },
      decoration: InputDecoration(
        labelText: title,
        contentPadding: EdgeInsets.symmetric(horizontal: 9),
      ),
      keyboardType: keyboard,
    );
  }

  @override
  Widget build(BuildContext context) {
    var lanProvider = Provider.of<LanProvider>(context);
    var provider = Provider.of<MyProvider>(context);

    return Directionality(
      textDirection: lanProvider.isEn?TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(lanProvider.texts('new address')),
        ),
        body: Form(
          key: _formkey,
          child: ListView(
            children: [
              SizedBox(height: 20),
              required(lanProvider.texts('area'), TextInputType.text, _area),
              SizedBox(height: 20),
              required(lanProvider.texts('street'), TextInputType.text, _street),
              SizedBox(height: 20),
              requiredPhone(
                  lanProvider.texts('phone number'), TextInputType.number, _phone),
              SizedBox(height: 40),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.33,
                ),
                child: provider.isLoading
                    ? Align(
                        child: CircularProgressIndicator(),
                        alignment: Alignment.center)
                    : ElevatedButton(
                        onPressed: () async{
                          try {
                            if (_formkey.currentState!.validate()) {
                              setState(() {
                                provider.isLoading = true;
                              });
                              await provider
                                  .add(_area.text, _street.text, _phone.text)
                                  .then((_) => Navigator.of(context).pop());
                              setState(() {
                                provider.isLoading = false;
                              });
                            }
                          } on FirebaseAuthException catch (e) {
                            setState(() {
                              provider.isLoading = false;
                            });
                            print(e.message);
                          } catch (e) {
                            setState(() {
                              provider.isLoading = false;
                            });
                            print(e);
                          }
                        },
                        child: Text(
                          lanProvider.texts('add'),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
