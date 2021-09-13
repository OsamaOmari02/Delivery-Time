import 'package:app/Myprovider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import 'Drawer.dart';
import 'LanguageProvider.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  void initState() {
    Provider.of<MyProvider>(context, listen: false).detailedCart.clear();
    super.initState();
  }

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

    final snackBar = SnackBar(
      content: Container(
        height: height * 0.08,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  lanProvider.texts('order confirmed'),
                  style: TextStyle(fontSize: width * 0.04),
                ),
                Text(
                  lanProvider.texts('will reach out to u'),
                  style: TextStyle(fontSize: width * 0.04),
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
      duration: Duration(seconds: 5),
      backgroundColor: Colors.green,
      elevation: 5,
    );
    showSnackBar() => ScaffoldMessenger.of(context).showSnackBar(snackBar);

    return Directionality(
      textDirection: lanProvider.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          title: Text(lanProvider.texts('orders history')),
          centerTitle: true,
          backgroundColor: Colors.blue,
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
                  if (resData.isEmpty)
                    return Center(
                      child: Text(
                        lanProvider.texts('no orders'),
                        style: TextStyle(
                            fontSize: 17, fontStyle: FontStyle.italic),
                      ),
                    );
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
                              provider.details['delivery'] =
                                  resData[index]['delivery'].toString();
                              provider.details['resName'] =
                                  resData[index]['resName'];
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
                              Navigator.of(context)
                                  .pushReplacementNamed('detailsHistory');
                            },
                            trailing: TextButton(
                              onPressed: () => showDialog(
                                  context: ctx,
                                  builder: (BuildContext ctx) {
                                    return AlertDialog(
                                      title: Text(
                                        lanProvider.texts('reorder?'),
                                        textAlign: lanProvider.isEn
                                            ? TextAlign.start
                                            : TextAlign.end,
                                        style: const TextStyle(fontSize: 23),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 7),
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
                                              style: const TextStyle(
                                                  fontSize: 19,
                                                  color: Colors.blue),
                                            ),
                                            onTap: () async {
                                              try {
                                                setState(() {
                                                  provider.isLoading = true;
                                                });
                                                for (int i = 0;
                                                    i <
                                                        resData[index]
                                                            ['length'];
                                                    i++)
                                                  provider.myCart.add(FoodCart(
                                                      resName: resData[index]
                                                          ['resName'],
                                                      mealName: resData[index]
                                                              ['meals'][i]
                                                          ['meal name'],
                                                      mealPrice: resData[index]
                                                              ['meals'][i]
                                                          ['meal price'],
                                                      quantity: resData[index]
                                                              ['meals'][i]
                                                          ['quantity'],
                                                      foodID: resData[index].id));
                                                Navigator.of(context).pop();
                                                await provider.reorder(
                                                  resData[index]['total'],
                                                  resData[index]['delivery'],
                                                  resData[index]['note'],
                                                  resData[index]['length'],
                                                  resData[index]['resName'],
                                                  resData[index]['details']
                                                      ['area'],
                                                  resData[index]['details']
                                                      ['street'],
                                                  resData[index]['details']
                                                      ['phoneNum'],
                                                );
                                                showSnackBar();
                                                setState(() {
                                                  provider.isLoading = false;
                                                  provider.myCart.clear();
                                                });
                                              } on FirebaseException catch (e) {
                                                dialog(lanProvider
                                                    .texts('Error occurred !'));
                                                setState(() {
                                                  provider.isLoading = false;
                                                  provider.myCart.clear();
                                                });
                                                print(e.message);
                                              } catch (e) {
                                                dialog(lanProvider
                                                    .texts('Error occurred !'));
                                                print(e);
                                                setState(() {
                                                  provider.isLoading = false;
                                                  provider.myCart.clear();
                                                });
                                              }
                                            }),
                                        const SizedBox(width: 11),
                                        InkWell(
                                            child: Text(
                                                lanProvider.texts('cancel?'),
                                                style: const TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 19)),
                                            onTap: () =>
                                                Navigator.of(context).pop()),
                                      ],
                                    );
                                  }),
                              child: Text(
                                lanProvider.texts('reorder'),
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                            title: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(resData[index]['resName']),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(lanProvider.texts('price') +
                                      resData[index]['total'].toString() +
                                      " " +
                                      lanProvider.texts('jd')),
                                  const SizedBox(height: 5),
                                  Text(provider
                                      .dateTime(resData[index]['date'])),
                                ],
                              ),
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
