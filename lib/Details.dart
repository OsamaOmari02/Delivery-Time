import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Myprovider.dart';

class Details extends StatefulWidget {
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('التفاصيل'),
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(8.0),
          children: [
            Text(
              provider.details['name']!,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 2.0,
              color: Colors.white70,
              child: ListTile(
                title: Text(provider.details['area'] ?? ""),
                subtitle: Text('الشارع : ' +
                    provider.details['street']! +
                    "\n" +
                    'رقم الهاتف : ' +
                    provider.details['phoneNum']!),
                isThreeLine: true,
              ),
            ),
            // TODO show meals here
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Row(children: [
                Text(
                  'سعر الوجبات : ',
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  provider.details['total'].toString() + " ",
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  'د.أ',
                  style: const TextStyle(fontSize: 16),
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Card(
                color: Colors.greenAccent,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Text('الملاحظات : '),
                      Expanded(child: Text(provider.details['note']!)),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.3, vertical: height * 0.04),
              child: provider.isLoading
                  ? const Center(child: const CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: () async{
                        try{
                          setState(() {
                            provider.isLoading = true;
                          });
                          await provider.goToMaps(
                              double.parse(provider.details['longitude']!),
                              double.parse(provider.details['latitude']!));
                          setState(() {
                            provider.isLoading = false;
                          });
                        } catch (e){
                          setState(() {
                            provider.isLoading = false;
                          });
                        }
                      },
                      child: Text(
                        'الموقع',
                        style: const TextStyle(fontSize: 16),
                      )),
            ),
          ],
        ),
      ),
    );
  }
}
