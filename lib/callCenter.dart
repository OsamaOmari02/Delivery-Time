import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Myprovider.dart';

class CallCenter extends StatefulWidget {
  @override
  _CallCenterState createState() => _CallCenterState();
}

class _CallCenterState extends State<CallCenter> {

  var stream;
  @override
  void initState() {
    Provider.of<MyProvider>(context, listen: false).detailedCart.clear();
      stream = FirebaseFirestore.instance
          .collection('allOrders')
          .orderBy('date', descending: true)
          .snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    dialog(title) {
      return showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return AlertDialog(
              title: Text(
                title,
                textAlign: TextAlign.end,
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
                    child: Text("حسناً", style: const TextStyle(fontSize: 19)),
                    onTap: () => Navigator.of(context).pop()),
              ],
            );
          });
    }

    logOutFun() {
      return showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return AlertDialog(
              title: Text(
                'هل تريد تسجيل الخروج؟',
                textAlign: TextAlign.end,
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
                InkWell(
                    child: Text(
                      "نعم",
                      style: const TextStyle(fontSize: 19, color: Colors.red),
                    ),
                    onTap: () async {
                      try {
                        await FirebaseAuth.instance.signOut();
                        setState(() {
                          Provider.of<MyProvider>(context,listen: false).authState = authStatus.Authenticated;
                          Navigator.of(context).pushReplacementNamed('login');
                          Provider.of<MyProvider>(context, listen: false)
                              .details
                              .clear();
                        });
                      } on FirebaseException catch (e) {
                        dialog("حدث خطأ !");
                        setState(() {
                          Provider.of<MyProvider>(context,listen: false).authState = authStatus.unAuthenticated;
                        });
                        print(e.message);
                      } catch (e) {
                        dialog("حدث خطأ !");
                        print(e);
                        setState(() {
                          Provider.of<MyProvider>(context,listen: false).authState = authStatus.unAuthenticated;
                        });
                      }
                    }),
                const SizedBox(width: 11),
                InkWell(
                    child: Text("إلغاء", style: const TextStyle(fontSize: 19)),
                    onTap: () => Navigator.of(context).pop()),
              ],
            );
          });
    }

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
              const SizedBox(height: 20),
              listTile('صفحة الطلبات', Icons.home, 'callCenter', context),
              listTile('الموقع', Icons.location_on, 'location', context),
              ListTile(
                onTap: logOutFun,
                title: const Text(
                  "تسجيل الخروج",
                  style: const TextStyle(fontSize: 25, color: Colors.red),
                ),
                leading: const Icon(
                  Icons.logout,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: const Text('الطلبات'),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: stream,
          builder: (ctx, snapshot) {
            if (snapshot.hasError) return Center(child: const Text('حدث خطأ !'));
            if (snapshot.connectionState==ConnectionState.waiting)
              return const Center(child: const CircularProgressIndicator());
            return Scrollbar(
                child: ListView.builder(
                    itemCount: snapshot.data?.docs.length??0,
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
                                    Provider.of<MyProvider>(context,listen: false).details['area'] =
                                        resData[index]['details']['area'];
                                    Provider.of<MyProvider>(context,listen: false).details['street'] =
                                        resData[index]['details']['street'];
                                    Provider.of<MyProvider>(context,listen: false).details['phoneNum'] =
                                        resData[index]['details']['phoneNum'];
                                    Provider.of<MyProvider>(context,listen: false).details['name'] =
                                        resData[index]['details']['name'];
                                    Provider.of<MyProvider>(context,listen: false).details['total'] =
                                        resData[index]['total'].toString();
                                    Provider.of<MyProvider>(context,listen: false).details['note'] =
                                        resData[index]['note'];
                                    Provider.of<MyProvider>(context,listen: false).details['length'] =
                                        resData[index]['length'].toString();
                                    Provider.of<MyProvider>(context,listen: false).details['longitude'] =
                                        resData[index]['details']['longitude']
                                            .toString();
                                    Provider.of<MyProvider>(context,listen: false).details['latitude'] =
                                        resData[index]['details']['latitude']
                                            .toString();
                                    for (int i = 0;
                                        i < resData[index]['length'];
                                        i++)
                                      Provider.of<MyProvider>(context,listen: false).detailedCart.add(FoodCart(
                                          resName: resData[index]['resName'],
                                          mealName: resData[index]['meals'][i]
                                              ['meal name'],
                                          mealPrice: resData[index]['meals'][i]
                                              ['meal price'],
                                          quantity: resData[index]['meals'][i]
                                              ['quantity'],
                                          foodID: resData[index].id,
                                          description: resData[index]['meals']
                                              [i]['description']));
                                  });
                                  Navigator.of(context)
                                      .pushReplacementNamed('details');
                                },
                                trailing: Checkbox(
                                  value: resData[index]['isChecked'],
                                  onChanged: (bool? value) async {
                                    await FirebaseFirestore.instance
                                        .collection('allOrders')
                                        .doc(resData[index].id).update({
                                      'isChecked':value,
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
                                      Text(resData[index]['details']['area']),
                                    ],
                                  ),
                                ),
                                subtitle: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(Provider.of<MyProvider>(context,listen: false)
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
