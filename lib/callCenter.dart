import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Myprovider.dart';

class CallCenter extends StatefulWidget {
  @override
  _CallCenterState createState() => _CallCenterState();
}

class _CallCenterState extends State<CallCenter> {
  bool checked = false;

  getCheckBox() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      checked = pref.getBool('checkBox')!;
    });
  }

  @override
  void initState() {
    getCheckBox();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);

    ListTile listTile(String title, icon, route, BuildContext ctx) {
      return ListTile(
        onTap: () => Navigator.of(ctx).pushReplacementNamed(route),
        title: Text(
          title,
          style: const TextStyle(fontSize: 25),
        ),
        leading: Icon(
          icon,
          color: Colors.blueAccent,
        ),
      );
    }
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            children: [
              listTile('صفحة الطلبات', Icons.home, 'callCenter', context),
              listTile('الموقع', Icons.location_on, 'location', context),
            ],
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: const Text('الطلبات'),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('allOrders')
              .orderBy('date', descending: true)
              .snapshots(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(child: const CircularProgressIndicator());
            if (snapshot.hasError) return Center(child: Text('حدث خطأ !'));
            return Scrollbar(
                child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, int index) {
                      var resData = snapshot.data!.docs;
                      return Card(
                        elevation: 3.5,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: ListTile(
                                onTap: () {
                                  setState(() {
                                    provider.details['area'] =
                                        resData[index]['details']['area'];
                                    provider.details['street'] =
                                        resData[index]['details']['street'];
                                    provider.details['phoneNum'] =
                                        resData[index]['details']['phoneNum'];
                                    provider.details['name'] =
                                        resData[index]['details']['name'];
                                    provider.details['total'] =
                                        resData[index]['total'].toString();
                                    provider.details['note'] =
                                        resData[index]['note'];
                                    provider.details['longitude'] =
                                        resData[index]['details']['longitude']
                                            .toString();
                                    provider.details['latitude'] =
                                        resData[index]['details']['latitude']
                                            .toString();
                                  });
                                  Navigator.of(context).pushNamed('details');
                                },
                                trailing: Checkbox(
                                  value: checked,
                                  onChanged: (bool? value) async {
                                    SharedPreferences pref =
                                        await SharedPreferences.getInstance();
                                    setState(() {
                                      pref.setBool(resData[index].id, value!);
                                      checked = value;
                                    });
                                  },
                                  checkColor: Colors.white,
                                  activeColor: Colors.green,
                                ),
                                title: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(resData[index]['details']['name']),
                                      Text(resData[index]['details']['area'] +
                                          " - " +
                                          resData[index]['details']['street']),
                                    ],
                                  ),
                                ),
                                subtitle: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(provider
                                        .dateTime(resData[index]['date']))),
                              ),
                            ),
                          ],
                        ),
                      );
                    }));
          },
        ),
      ),
    );
  }
}
