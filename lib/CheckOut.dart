import 'package:app/LanguageProvider.dart';
import 'package:app/Myprovider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    dialog(title) {
      return showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return Directionality(
              textDirection:
              Provider.of<LanProvider>(context).isEn ? TextDirection.ltr : TextDirection.rtl,
              child: AlertDialog(
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
                      child: Text(Provider.of<LanProvider>(context,listen: false).texts('ok'),
                          style: const TextStyle(fontSize: 21)),
                      onPressed: () => Navigator.of(context).pop()),
                ],
              ),
            );
          });
    }

    final snackBar = SnackBar(
      content: Container(
        height: height * 0.081,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  Provider.of<LanProvider>(context,listen: false).texts('order confirmed'),
                  style: TextStyle(fontSize: width * 0.034),
                ),
                Text(
                  Provider.of<LanProvider>(context,listen: false).texts('will reach out to u'),
                  style: TextStyle(fontSize: width * 0.034),
                ),
              ],
            ),
            SizedBox(width: width * 0.1),
            Icon(
              Icons.check_circle_outline,
              color: Colors.white,
              size: 30,
            ),
          ],
        ),
      ),
      duration: Duration(seconds: 4),
      backgroundColor: Colors.green,
      elevation: 5,
    );
    showSnackBar() => ScaffoldMessenger.of(context).showSnackBar(snackBar);

    return Directionality(
      textDirection:  Provider.of<LanProvider>(context).isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          centerTitle: true,
          title: Text( Provider.of<LanProvider>(context,listen: false).texts('CheckOut')),
        ),
        body: ListView(
          padding: const EdgeInsets.all(6.0),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                Provider.of<LanProvider>(context,listen: false).texts('deliver to'),
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 2.0,
              color: Provider.of<MyProvider>(context).isDark?Colors.black12:Colors.white70,
              child: ListTile(
                title: Text(Provider.of<MyProvider>(context,listen: false).checkOut['area'] ?? ""),
                subtitle: Text( Provider.of<LanProvider>(context,listen: false).texts('street:') +
                    Provider.of<MyProvider>(context,listen: false).checkOut['street'] +
                    "\n" +
                    Provider.of<LanProvider>(context,listen: false).texts('phone:') +
                    Provider.of<MyProvider>(context,listen: false).checkOut['phoneNum']),
                isThreeLine: true,
              ),
            ),
            SizedBox(height: height*0.01),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Row(children: [
                Text(
                  Provider.of<LanProvider>(context,listen: false).texts('cart total :'),
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  Provider.of<MyProvider>(context,listen: false).total.toStringAsFixed(2) + " ",
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  Provider.of<LanProvider>(context,listen: false).texts('jd'),
                  style: const TextStyle(fontSize: 16),
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Row(children: [
                Text(
                  Provider.of<LanProvider>(context,listen: false).texts('delivery price') + " ",
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  Provider.of<MyProvider>(context,listen: false).deliveryPrice.toStringAsFixed(2) + " ",
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  Provider.of<LanProvider>(context,listen: false).texts('jd'),
                  style: const TextStyle(fontSize: 16),
                ),
                SizedBox(width: width*0.05),
                const Icon(Icons.motorcycle)
              ]),
            ),
            const Divider(thickness: 1),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Row(children: [
                Text(
                  Provider.of<LanProvider>(context,listen: false).texts('total') + " ",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  (Provider.of<MyProvider>(context,listen: false).total + Provider.of<MyProvider>(context,listen: false).deliveryPrice).toStringAsFixed(2) + " ",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  Provider.of<LanProvider>(context,listen: false).texts('jd'),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
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
                  labelText:  Provider.of<LanProvider>(context,listen: false).texts('note'),
                ),
              ),
            ),
            SizedBox(height: height*0.03),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width*0.2),
              child: Provider.of<MyProvider>(context,listen: false).isLoading
                  ? const Center(
                      child: const CircularProgressIndicator(),
                    )
                  : ElevatedButton(
                      onPressed: () async {
                        try {
                          setState(() {
                            Provider.of<MyProvider>(context,listen: false).isLoading = true;
                          });
                          await Provider.of<MyProvider>(context,listen: false).addToDB(_note.text);
                          Navigator.of(context)
                              .pushReplacementNamed('MyHomepage');
                          setState(() {
                            Provider.of<MyProvider>(context,listen: false).isLoading = false;
                            Provider.of<MyProvider>(context,listen: false).total = 0.0;
                            Provider.of<MyProvider>(context,listen: false).checkOut['area'] = "";
                            Provider.of<MyProvider>(context,listen: false).checkOut['street'] = "";
                            Provider.of<MyProvider>(context,listen: false).checkOut['phoneNum'] = "";
                            Provider.of<MyProvider>(context,listen: false).myCart.clear();
                          });
                          showSnackBar();
                        } on FirebaseException catch (e) {
                          dialog( Provider.of<LanProvider>(context,listen: false).texts('Error occurred !'));
                          setState(() {
                            Provider.of<MyProvider>(context,listen: false).isLoading = false;
                          });
                          print(e.message);
                        } catch (e) {
                          dialog( Provider.of<LanProvider>(context,listen: false).texts('Error occurred !'));
                          setState(() {
                            Provider.of<MyProvider>(context,listen: false).isLoading = false;
                          });
                          print(e);
                        }
                      },
                      child: Text( Provider.of<LanProvider>(context,listen: false).texts('CheckOut'),
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green)),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(child: Text( Provider.of<LanProvider>(context,listen: false).texts('last note'))),
            ),
          ],
        ),
      ),
    );
  }
}
