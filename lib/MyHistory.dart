import 'package:app/Myprovider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

    delete(title) {
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
                InkWell(
                    child: Text(
                      lanProvider.texts('yes?'),
                      style: const TextStyle(fontSize: 19, color: Colors.red),
                    ),
                    onTap: () async {
                      try {
                        setState(() {
                          provider.isLoading = true;
                        });
                        await FirebaseFirestore.instance
                            .collection('orders/${user!.uid}/myOrders')
                            .doc(provider.mealID)
                            .delete();
                        Fluttertoast.showToast(
                            msg: lanProvider.texts('order deleted'),
                            toastLength: Toast.LENGTH_SHORT,
                            backgroundColor: Colors.grey,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        Navigator.of(context).pop();
                        setState(() {
                          provider.isLoading = false;
                        });
                      } on FirebaseException catch (e) {
                        dialog(lanProvider.texts('Error occurred !'));
                        setState(() {
                          provider.isLoading = false;
                        });
                        print(e.message);
                      } catch (e) {
                        dialog(lanProvider.texts('Error occurred !'));
                        setState(() {
                          provider.isLoading = false;
                        });
                        print(e);
                      }
                    }),
                const SizedBox(width: 11),
                InkWell(
                    child: Text(lanProvider.texts('cancel?'),
                        style: const TextStyle(fontSize: 19)),
                    onTap: () => Navigator.of(context).pop()),
              ],
            );
          });
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
              .collection('/orders/${user!.uid}/myOrders')
              .orderBy('date', descending: true)
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
                            onLongPress: () async {
                              setState(() {
                                provider.mealID = resData[index].id;
                              });
                              await delete(lanProvider.texts('delete order?'));
                            },
                            onTap: () {
                              provider.details['area'] =
                                  resData[index]['details']['area'];
                              provider.details['street'] =
                                  resData[index]['details']['street'];
                              provider.details['phoneNum'] =
                                  resData[index]['details']['phoneNum'];
                              provider.details['total'] =
                                  resData[index]['total'].toString();
                              provider.details['note'] = resData[index]['note'];
                              provider.details['delivery'] = resData[index]['delivery'].toString();
                              provider.details['resName'] = resData[index]['resName'];
                              for (int i = 0; i < resData[index]['length']; i++)
                                provider.detailedCart.add(FoodCart(
                                    resName: resData[index]['resName'],
                                    mealName: resData[index]['meals'][i]
                                        ['meal name'],
                                    mealPrice: resData[index]['meals'][i]
                                        ['meal price'],
                                    quantity: resData[index]['meals'][i]
                                        ['quantity'],
                                    foodID: resData[index].id));
                              Navigator.of(context).pushNamed('detailsHistory');
                            },
                            trailing: const Icon(Icons.arrow_forward),
                            title: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(resData[index]['resName']),
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
