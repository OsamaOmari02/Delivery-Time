import 'package:app/Drawer.dart';
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
      textDirection: lanProvider.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(lanProvider.texts('details')),
          centerTitle: true,
        ),
        drawer: MyDrawer(),
        body: ListView(
          padding: const EdgeInsets.all(8.0),
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                lanProvider.texts('deliver to'),
                style: TextStyle(fontSize: 15),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 2.0,
              color: provider.isDark ? Colors.grey[170] : Colors.white70,
              child: ListTile(
                title: Text(provider.details['area'] ?? ""),
                subtitle: Text(lanProvider.texts('street') +
                    provider.details['street']! +
                    "\n" +
                    lanProvider.texts('phone:') +
                    provider.details['phoneNum']!),
                isThreeLine: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                provider.details['resName']!,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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
                    title: Text(provider.detailedCart[i].mealName),
                    subtitle: Text(provider.detailedCart[i].description +"\n"+
                        lanProvider.texts('meal price : ') +
                        provider.detailedCart[i].mealPrice.toString() +
                        " ${lanProvider.texts('jd')}\n" +
                        lanProvider.texts('quantity : ') +
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
                  lanProvider.texts('cart total :'),
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  provider.details['total'].toString() + " ",
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
                  lanProvider.texts('delivery price'),
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  provider.details['delivery'].toString() + " ",
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
              child: Card(
                color: provider.isDark ? Colors.grey[170] : Colors.greenAccent,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(lanProvider.texts('note')),
                      Expanded(child: Text(provider.details['note']!)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
