import 'package:app/LanguageProvider.dart';
import 'package:app/Myprovider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckOut extends StatefulWidget {
  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  TextEditingController _note = TextEditingController();

  @override
  void dispose() {
    _note.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var lanProvider = Provider.of<LanProvider>(context);
    var provider = Provider.of<MyProvider>(context);
    return Directionality(
      textDirection: lanProvider.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          centerTitle: true,
          title: Text(lanProvider.texts('CheckOut')),
        ),
        body: ListView(
          children: [
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                lanProvider.texts('deliver to'),
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 2.0,
              color: Colors.white70,
              child: ListTile(
                title: Text(provider.checkOut['area'] ?? ""),
                subtitle: Text(lanProvider.texts('street:') +
                    provider.checkOut['street'] +
                    "\n" +
                    lanProvider.texts('phone:') +
                    provider.checkOut['phoneNum']),
                isThreeLine: true,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Row(children: [
                Text(
                  lanProvider.texts('cart total :'),
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  provider.total.toString() + " ",
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  lanProvider.texts('jd'),
                  style: const TextStyle(fontSize: 16),
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Row(children: [
                Text(
                  lanProvider.texts('delivery price') + " ",
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  provider.deliveryPrice.toString() + " ",
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  lanProvider.texts('jd'),
                  style: const TextStyle(fontSize: 16),
                ),
              ]),
            ),
            const Divider(thickness: 1),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Row(children: [
                Text(
                  lanProvider.texts('total') + " ",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  (provider.total + provider.deliveryPrice).toString() + " ",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  lanProvider.texts('jd'),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ]),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(7.0),
              child: TextField(
                controller: _note,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      gapPadding: 5, borderRadius: BorderRadius.circular(10)),
                  icon: const Icon(
                    Icons.event_note,
                    color: Colors.blue,
                  ),
                  labelText: lanProvider.texts('note'),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70),
              child: ElevatedButton(
                onPressed: () {},
                child: Text(lanProvider.texts('CheckOut'),
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
