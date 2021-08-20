import 'package:app/LanguageProvider.dart';
import 'package:app/Myprovider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
        contentPadding: const EdgeInsets.symmetric(horizontal: 9),
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
        contentPadding: const EdgeInsets.symmetric(horizontal: 9),
      ),
      keyboardType: keyboard,
    );
  }
@override
  void dispose() {
  _area.dispose();
  _street.dispose();
  _phone.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var lanProvider = Provider.of<LanProvider>(context);
    var provider = Provider.of<MyProvider>(context);

    dialog(title) {
      return showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return AlertDialog(
              title: Row(
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    title,
                    textAlign:
                    lanProvider.isEn ? TextAlign.start : TextAlign.end,
                    style: const TextStyle(fontSize: 23),
                  ),
                ],
              ),
              contentPadding:const EdgeInsets.symmetric(vertical: 7),
              elevation: 24,
              content: Container(
                height: 30,
                child: const Divider(),
                alignment: Alignment.topCenter,
              ),
              actions: [
                InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(lanProvider.texts('ok'),
                          style: const TextStyle(fontSize: 19, color: Colors.blue)),
                    ),
                    onTap: () => Navigator.of(context).pop()),
              ],
            );
          });
    }
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
              const SizedBox(height: 20),
              required(lanProvider.texts('area'), TextInputType.text, _area),
              const SizedBox(height: 20),
              required(lanProvider.texts('street'), TextInputType.text, _street),
              const SizedBox(height: 20),
              requiredPhone(
                  lanProvider.texts('phone number'), TextInputType.number, _phone),
              const SizedBox(height: 40),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.33,
                ),
                child: provider.isLoading
                    ? Align(
                        child: const CircularProgressIndicator(),
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
                              Fluttertoast.showToast(
                                  msg: lanProvider.texts('Address Added'),
                                  toastLength: Toast.LENGTH_SHORT,
                                  backgroundColor: Colors.grey,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                              setState(() {
                                provider.isLoading = false;
                              });
                            }
                          } on FirebaseAuthException catch (e) {
                            dialog(e.message);
                            setState(() {
                              provider.isLoading = false;
                            });
                          } catch (e) {
                            dialog(lanProvider.texts('Error occurred !'));
                            setState(() {
                              provider.isLoading = false;
                            });
                            print(e);
                          }
                        },
                        child: Text(
                          lanProvider.texts('add'),
                          style: const TextStyle(
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
