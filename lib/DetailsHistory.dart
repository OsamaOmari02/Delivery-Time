import 'package:app/LanguageProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Myprovider.dart';

class DetailsHistory extends StatefulWidget {

  @override
  _DetailsHistoryState createState() => _DetailsHistoryState();
}

class _DetailsHistoryState extends State<DetailsHistory> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    var lanProvider = Provider.of<LanProvider>(context);
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
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(lanProvider.texts('deliver to'),style: TextStyle(fontSize: 15),),
            ),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                provider.details['resName']!,
                style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            for (int i = 0; i < provider.detailedCart.length; i++)
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 3.0,
                  child: ListTile(
                    title: Text(
                        'اسم الوجبة : ' + provider.detailedCart[i].mealName),
                    subtitle: Text('سعر الوجبة : ' +
                        provider.detailedCart[i].mealPrice.toString() +
                        " د.أ\n" +
                        'الكمية : ' +
                        provider.detailedCart[i].quantity.toString()),
                    isThreeLine: true,
                  ),
                ),
              ),
            const SizedBox(height: 10),
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
              child: Row(children: [
                Text(
                  'سعر التوصيل : ',
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  provider.details['delivery'].toString() + " ",
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
                  onPressed: () async {
                    try {
                      setState(() {
                        provider.isLoading = true;
                      });
                      // TODO reorder
                      setState(() {
                        provider.isLoading = false;
                      });
                    } catch (e) {
                      setState(() {
                        provider.isLoading = false;
                      });
                    }
                  },
                  child: Text(
                    lanProvider.texts('reorder'),
                    style: const TextStyle(fontSize: 16),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
