import 'package:app/Myprovider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Discount extends StatefulWidget {
  const Discount({Key? key}) : super(key: key);

  @override
  _DiscountState createState() => _DiscountState();
}

class _DiscountState extends State<Discount> {
  TextEditingController _price = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text('خصم لجميع المناطق'),
              ),
              body: Column(
                children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
                      controller: _price,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      cursorColor: Colors.blue,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            gapPadding: 5,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                  Switch(
                      activeColor: Colors.blueAccent,
                      activeTrackColor: Colors.blue[200],
                      value: Provider.of<MyProvider>(context).discount,
                      onChanged: (val) async {
                        SharedPreferences pref =
                            await SharedPreferences.getInstance();
                        pref.setBool('discount', val);
                        setState(() {
                          Provider.of<MyProvider>(context, listen: false)
                              .discount = val;
                        });
                      }),
                ],
              ),
            )));
  }
}
