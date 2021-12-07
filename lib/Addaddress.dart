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
  var _street = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _phone.dispose();
    _street.dispose();
    super.dispose();
  }
  @override
  void initState() {
    Provider.of<MyProvider>(context,listen: false).area='---اختر المنطقة---';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    requiredPhone(title, keyboard, value) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          controller: value,
          validator: (val) {
            if (val.toString().isEmpty ||
                !val.toString().startsWith("07") ||
                val!.length != 10)
              return  Provider.of<LanProvider>(context,listen: false).texts('invalid');
            else {
              return null;
            }
          },
          decoration: InputDecoration(
            labelText: title,
            contentPadding: const EdgeInsets.symmetric(horizontal: 9),
            border: OutlineInputBorder(
                gapPadding: 5, borderRadius: BorderRadius.circular(10)),
          ),
          keyboardType: keyboard,
        ),
      );
    }

    Widget area() {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButton(
            iconSize: 30,
            underline: const SizedBox(),
            borderRadius: BorderRadius.circular(12),
            isExpanded: true,
            value: Provider.of<MyProvider>(context).area,
            items: Provider.of<MyProvider>(context).areas.map((value) {
              return DropdownMenuItem(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                Provider.of<MyProvider>(context,listen: false).area = newValue!;
              });
            },
          ),
        ),
      );
    }

    street(title, keyboard, value) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          controller: value,
          decoration: InputDecoration(
            labelText: title,
            contentPadding: const EdgeInsets.symmetric(horizontal: 9),
            border: OutlineInputBorder(
                gapPadding: 5, borderRadius: BorderRadius.circular(10)),
          ),
          keyboardType: keyboard,
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
                    Provider.of<LanProvider>(context).isEn ? TextAlign.start : TextAlign.end,
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
                      child: Text( Provider.of<LanProvider>(context,listen: false).texts('ok'),
                          style: const TextStyle(
                              fontSize: 19, color: Colors.blue)),
                    ),
                    onTap: () => Navigator.of(context).pop()),
              ],
            );
          });
    }

    return Directionality(
      textDirection:  Provider.of<LanProvider>(context).isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: Text( Provider.of<LanProvider>(context,listen: false).texts('new address')),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(height: height*0.03),
              Container(
                child: Text( Provider.of<LanProvider>(context,listen: false).texts('area'),style: TextStyle(fontSize: 16),),
                padding: EdgeInsets.fromLTRB(12,12,12,0),
              ),
              area(),
              street( Provider.of<LanProvider>(context,listen: false).texts('street'),
                  TextInputType.text, _street),
              requiredPhone( Provider.of<LanProvider>(context,listen: false).texts('phone number'),
                  TextInputType.number, _phone),
              SizedBox(height: height*0.06),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.33,
                ),
                child: Provider.of<MyProvider>(context,listen: false).isLoading
                    ? Align(
                        child: const CircularProgressIndicator(),
                        alignment: Alignment.center)
                    : ElevatedButton(
                        onPressed: () async {
                          try {
                            if (Provider.of<MyProvider>(context,listen: false).area=="---اختر المنطقة---")
                               return dialog( Provider.of<LanProvider>(context,listen: false).texts('Choose your area'));
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                Provider.of<MyProvider>(context,listen: false).isLoading = true;
                              });
                              await Provider.of<MyProvider>(context,listen: false)
                                  .add(Provider.of<MyProvider>(context,listen: false).area, _street.text, _phone.text)
                                  .then((_) => Navigator.of(context).pop());
                              Fluttertoast.showToast(
                                  msg:  Provider.of<LanProvider>(context,listen: false).texts('Address Added'),
                                  toastLength: Toast.LENGTH_SHORT,
                                  backgroundColor: Colors.grey,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              setState(() {
                                Provider.of<MyProvider>(context,listen: false).isLoading = false;
                              });
                            }
                          } on FirebaseAuthException catch (e) {
                            dialog(e.message);
                            setState(() {
                              Provider.of<MyProvider>(context,listen: false).isLoading = false;
                            });
                          } catch (e) {
                            dialog( Provider.of<LanProvider>(context,listen: false).texts('Error occurred !'));
                            setState(() {
                              Provider.of<MyProvider>(context,listen: false).isLoading = false;
                            });
                            print(e);
                          }
                        },
                        child: Text(
                          Provider.of<LanProvider>(context,listen: false).texts('add'),
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
