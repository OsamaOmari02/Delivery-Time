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

  var _phone = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _phone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var lanProvider = Provider.of<LanProvider>(context);
    var provider = Provider.of<MyProvider>(context);

    requiredPhone(title, keyboard, value) {
      return TextFormField(
        controller: value,
        validator: (val) {
          if (val.toString().isEmpty ||
              !val.toString().startsWith("07") ||
              val!.length != 10)
            return lanProvider.texts('invalid');
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

    Widget area() {
      return Container(
        padding: const EdgeInsets.all(12),
        child: DropdownButton(
          isExpanded: true,
          value: provider.area,
          items: provider.areas.map((value) {
            return DropdownMenuItem(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              provider.area = newValue!;
            });
          },
        ),
      );
    }

    Widget street() {
      return Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: DropdownButton(
          isExpanded: true,
          value: provider.street,
          items: provider.streets.map((value) {
            return DropdownMenuItem(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              provider.street = newValue!;
            });
          },
        ),
      );
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
              contentPadding: const EdgeInsets.symmetric(vertical: 7),
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
                          style: const TextStyle(
                              fontSize: 19, color: Colors.blue)),
                    ),
                    onTap: () => Navigator.of(context).pop()),
              ],
            );
          });
    }

    return Directionality(
      textDirection: lanProvider.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(lanProvider.texts('new address')),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 20),
              Container(
                child: Text(lanProvider.texts('area'),style: TextStyle(fontSize: 16),),
                padding: EdgeInsets.fromLTRB(12,12,12,0),
              ),
              area(),
              Container(
                child: Text(lanProvider.texts('street'),style: TextStyle(fontSize: 16),),
                padding: EdgeInsets.fromLTRB(12,12,12,0),
              ),
              street(),
              const SizedBox(height: 10),
              requiredPhone(lanProvider.texts('phone number'),
                  TextInputType.number, _phone),
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
                        onPressed: () async {
                          try {
                            if (provider.area=="اختر المنطقة")
                               return dialog(lanProvider.texts('Choose your area'));
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                provider.isLoading = true;
                              });
                              await provider
                                  .add(provider.area, provider.street, _phone.text)
                                  .then((_) => Navigator.of(context).pop());
                              Fluttertoast.showToast(
                                  msg: lanProvider.texts('Address Added'),
                                  toastLength: Toast.LENGTH_SHORT,
                                  backgroundColor: Colors.grey,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
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
