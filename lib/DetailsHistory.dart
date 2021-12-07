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
    double height = MediaQuery.of(context).size.height;
    return Directionality(
      textDirection:  Provider.of<LanProvider>(context).isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text( Provider.of<LanProvider>(context,listen: false).texts('details')),
          centerTitle: true,
        ),
        drawer: MyDrawer(),
        body: ListView(
          padding: const EdgeInsets.all(8.0),
          children: [
            SizedBox(height: height * 0.005),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                Provider.of<LanProvider>(context,listen: false).texts('deliver to'),
                style: const TextStyle(fontSize: 15),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 2.0,
              color: Provider.of<MyProvider>(context).isDark ? Colors.grey[170] : Colors.white70,
              child: ListTile(
                title: Text(Provider.of<MyProvider>(context,listen: false).details['area'] ?? ""),
                subtitle: Text( Provider.of<LanProvider>(context,listen: false).texts('street') +
                    Provider.of<MyProvider>(context,listen: false).details['street']! +
                    "\n" +
                    Provider.of<LanProvider>(context,listen: false).texts('phone:') +
                    Provider.of<MyProvider>(context,listen: false).details['phoneNum']!),
                isThreeLine: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                Provider.of<MyProvider>(context,listen: false).details['resName']!,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            for (int i = 0; i < Provider.of<MyProvider>(context,listen: false).detailedCart.length; i++)
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 3.0,
                  child: ListTile(
                    title: Text(Provider.of<MyProvider>(context,listen: false).detailedCart[i].mealName),
                    subtitle: Text(Provider.of<MyProvider>(context,listen: false).detailedCart[i].description +
                        "\n" +
                        Provider.of<LanProvider>(context,listen: false).texts('meal price : ') +
                        Provider.of<MyProvider>(context,listen: false).detailedCart[i].mealPrice.toString() +
                        " ${ Provider.of<LanProvider>(context,listen: false).texts('jd')}\n" +
                        Provider.of<LanProvider>(context,listen: false).texts('quantity : ') +
                        Provider.of<MyProvider>(context,listen: false).detailedCart[i].quantity.toString()),
                    isThreeLine: true,
                  ),
                ),
              ),
            SizedBox(height: height * 0.01),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Row(children: [
                Text(
                  Provider.of<LanProvider>(context,listen: false).texts('cart total :'),
                  style: const TextStyle(fontSize: 15),
                ),
                Text(
                  double.parse(Provider.of<MyProvider>(context).details['total']??'').toStringAsFixed(2) + " ",
                  style: const TextStyle(fontSize: 15),
                ),
                Text(
                  Provider.of<LanProvider>(context,listen: false).texts('jd'),
                  style: const TextStyle(fontSize: 15),
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Row(children: [
                Text(
                  Provider.of<LanProvider>(context,listen: false).texts('delivery price'),
                  style: const TextStyle(fontSize: 15),
                ),
                Text(
                  Provider.of<MyProvider>(context,listen: false).details['delivery'].toString() + " ",
                  style: const TextStyle(fontSize: 15),
                ),
                Text(
                  Provider.of<LanProvider>(context,listen: false).texts('jd'),
                  style: const TextStyle(fontSize: 15),
                ),
              ]),
            ),
            const Divider(thickness: 1),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Row(children: [
                Text(
                  Provider.of<LanProvider>(context,listen: false).texts('total'),
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  (double.parse(Provider.of<MyProvider>(context,listen: false).details['delivery']!) +
                          double.parse(Provider.of<MyProvider>(context,listen: false).details['total']!))
                      .toStringAsFixed(2),
                  style: const TextStyle(fontSize: 16),
                ),
                Text(" " +
                    Provider.of<LanProvider>(context,listen: false).texts('jd'),
                  style: const TextStyle(fontSize: 16),
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Card(
                color: Provider.of<MyProvider>(context).isDark ? Colors.grey[170] : Colors.greenAccent,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text( Provider.of<LanProvider>(context,listen: false).texts('note')),
                      Expanded(child: Text(Provider.of<MyProvider>(context,listen: false).details['note']!)),
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
