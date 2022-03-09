import 'package:app/Myprovider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  void getPriceController() async {
    await FirebaseFirestore.instance
        .collection('DP')
        .doc('2')
        .get()
        .then((value) {
      setState(() {
        _price = TextEditingController(
            text: double.parse(value['discount']).toString());
      });
    });
  }

  @override
  void initState() {
    getPriceController();
    super.initState();
  }

  @override
  void dispose() {
    _price.dispose();
    super.dispose();
  }

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
                    padding: const EdgeInsets.all(8.0),
                    child: Text("تحديد سعر التوصيل لجميع المناطق",
                        style: const TextStyle(fontSize: 18)),
                  ),
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
                  ListTile(
                    trailing: Switch(
                        activeColor: Colors.blueAccent,
                        activeTrackColor: Colors.blue[200],
                        value: Provider.of<MyProvider>(context).discount,
                        onChanged: (val) async {
                            await FirebaseFirestore.instance.collection('DP').doc('2').update({
                              'discount' : _price.text,
                              'discountBool' : val
                            });
                          SharedPreferences pref =
                              await SharedPreferences.getInstance();
                          pref.setBool('discount', val);
                          setState(() {
                            Provider.of<MyProvider>(context, listen: false)
                                .discount = val;
                          });
                        }),
                    title: const Text("تفعيل/إلغاء",
                        style: const TextStyle(fontSize: 19)),
                  ),
                ],
              ),
            )));
  }
}
