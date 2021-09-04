import 'package:app/Myprovider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Drawer.dart';
import 'LanguageProvider.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var lanProvider = Provider.of<LanProvider>(context);
    var provider = Provider.of<MyProvider>(context);
    var user = FirebaseAuth.instance.currentUser;

    dialog(title) {
      return showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return AlertDialog(
              title: Text(
                title,
                textAlign: lanProvider.isEn ? TextAlign.start : TextAlign.end,
                style: const TextStyle(fontSize: 23),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 7),
              elevation: 24,
              content: Container(
                height: 30,
                child: const Divider(),
                alignment: Alignment.topCenter,
              ),
              actions: [
                const SizedBox(width: 11),
                InkWell(
                    child: Text(lanProvider.texts('ok'),
                        style: const TextStyle(fontSize: 19)),
                    onTap: () => Navigator.of(context).pop()),
              ],
            );
          });
    }

    bottomSheet() {
      return Directionality(
        textDirection: lanProvider.isEn ? TextDirection.ltr : TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              lanProvider.texts('choose address'),
              style: TextStyle(
                  color: CupertinoColors.black, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Theme.of(context).canvasColor,
            elevation: 1,
            actions: [
              IconButton(
                icon: Icon(
                  Icons.add,
                  color: Colors.blue,
                ),
                onPressed: () => Navigator.of(context).pushNamed('addAddress'),
              ),
            ],
          ),
          body: ListView.builder(
            itemCount: provider.loc.length,
            itemBuilder: (BuildContext context, int index) {
              if (provider.loc.isEmpty)
                return Center(
                  child: TextButton(
                      onPressed: () =>
                          Navigator.of(context).pushNamed('addAddress'),
                      child: Text(lanProvider.texts('new address'),
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ))),
                );
              return Card(
                elevation: 0.5,
                child: ListTile(
                  onTap: () {
                    setState(() {
                      provider.checkOut['area'] = provider.loc[index].area;
                      provider.checkOut['street'] = provider.loc[index].street;
                      provider.checkOut['phoneNum'] =
                          provider.loc[index].phoneNum;
                    });
                    Navigator.of(context).pushNamed('checkOut');
                  },
                  title: Text(provider.loc[index].area),
                  subtitle: Text(lanProvider.texts('street:') +
                      provider.loc[index].street +
                      "\n" +
                      lanProvider.texts('phone:') +
                      provider.loc[index].phoneNum),
                  isThreeLine: true,
                ),
              );
            },
          ),
        ),
      );
    }

    return Directionality(
      textDirection: lanProvider.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          title: Text(lanProvider.texts('orders history')),
          centerTitle: true,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('/orders/${user!.uid}/myOrders').orderBy('date',descending: true)
              .snapshots(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(child: const CircularProgressIndicator());
            if (snapshot.hasError)
              return Center(
                  child: Text(lanProvider.texts('something went wrong !')));
            return Scrollbar(
              child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, int index) {
                  var resData = snapshot.data!.docs;
                  return Card(
                    elevation: 2.5,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: ListTile(
                            onTap: () => showModalBottomSheet(
                              context: context,
                              builder: (_) => Directionality(
                                textDirection: lanProvider.isEn
                                    ? TextDirection.ltr
                                    : TextDirection.rtl,
                                child: Scaffold(
                                  appBar: AppBar(
                                    backgroundColor:
                                        Theme.of(context).canvasColor,
                                    elevation: 1,
                                    actions: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 7.0),
                                            child: Text(
                                              lanProvider.texts('reorder'),
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          IconButton(
                                            icon: const Icon(
                                              Icons.restore_sharp,
                                              color: Colors.blue,
                                            ),
                                            onPressed: () {
                                              // ToDo reorder
                                            },
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  body: ListView(
                                    padding: const EdgeInsets.all(6.0),
                                    children: [
                                      Text(resData[index]['details']['name'])
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            trailing: InkWell(
                              onTap: () {
                                // ToDo reorder
                              },
                              child: Column(
                                children: [
                                  const Icon(Icons.restore_sharp),
                                  Text(
                                    lanProvider.texts('reorder'),
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 14.5),
                                  ),
                                ],
                              ),
                            ),
                            title: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(resData[index]['details']['area'] +
                                  " - " +
                                  resData[index]['details']['street']),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  provider.dateTime(resData[index]['date'])),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
