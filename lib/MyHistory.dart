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
var user = FirebaseAuth.instance.currentUser;
class _HistoryState extends State<History> {
   var stream;
  @override
  void initState() {
    Provider.of<MyProvider>(context, listen: false).detailedCart.clear();
      stream = FirebaseFirestore.instance
          .collection('/orders/${user!.uid}/myOrders')
          .orderBy('date', descending: true)
          .snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    dialog(title) {
      return showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return AlertDialog(
              title: Text(
                title,
                textAlign:  Provider.of<LanProvider>(context).isEn ? TextAlign.start : TextAlign.end,
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
                    child: Text( Provider.of<LanProvider>(context,listen: false).texts('ok'),
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
                textAlign:  Provider.of<LanProvider>(context).isEn ? TextAlign.start : TextAlign.end,
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
                      Provider.of<LanProvider>(context,listen: false).texts('yes?'),
                      style: const TextStyle(fontSize: 19, color: Colors.red),
                    ),
                    onTap: () async {
                      try {
                        setState(() {
                          Provider.of<MyProvider>(context,listen: false).isLoading = true;
                        });
                        await FirebaseFirestore.instance
                            .collection('orders/${user!.uid}/myOrders')
                            .doc(Provider.of<MyProvider>(context,listen: false).mealID)
                            .delete();
                        Fluttertoast.showToast(
                            msg:  Provider.of<LanProvider>(context,listen: false).texts('order deleted'),
                            toastLength: Toast.LENGTH_SHORT,
                            backgroundColor: Colors.grey,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        Navigator.of(context).pop();
                        setState(() {
                          Provider.of<MyProvider>(context,listen: false).isLoading = false;
                        });
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
                    }),
                const SizedBox(width: 11),
                InkWell(
                    child: Text(Provider.of<LanProvider>(context,listen: false).texts('cancel?'),
                        style: const TextStyle(fontSize: 19)),
                    onTap: () => Navigator.of(context).pop()),
              ],
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
                  style: TextStyle(fontSize: width * 0.032),
                ),
                Text(
                  Provider.of<LanProvider>(context,listen: false).texts('will reach out to u'),
                  style: TextStyle(fontSize: width * 0.03),
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

    Future<bool> _onWillPop() async {
      await Navigator.of(context).pushReplacementNamed('MyHomepage');
      throw "";
    }
    return Directionality(
      textDirection:  Provider.of<LanProvider>(context).isEn ? TextDirection.ltr : TextDirection.rtl,
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          drawer: MyDrawer(),
          appBar: AppBar(
            title: Text( Provider.of<LanProvider>(context,listen: false).texts('orders history')),
            centerTitle: true,
            backgroundColor: Colors.blue,
          ),
          body: StreamBuilder<QuerySnapshot>(
            stream: stream,
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return Center(child: const CircularProgressIndicator());
              if (snapshot.hasError)
                return Center(
                    child: Text( Provider.of<LanProvider>(context,listen: false).texts('something went wrong !')));
              return Scrollbar(
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, int index) {
                    var resData = snapshot.data!.docs;
                    if (resData.isEmpty)
                      return Center(
                        child: Text(
                          Provider.of<LanProvider>(context,listen: false).texts('no orders'),
                          style: const TextStyle(
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
                                  Provider.of<MyProvider>(context,listen: false).mealID = resData[index].id;
                                });
                                await delete( Provider.of<LanProvider>(context,listen: false).texts('delete order?'));
                              },
                              onTap: () {
                                Provider.of<MyProvider>(context,listen: false).details['area'] =
                                    resData[index]['details']['area'];
                                Provider.of<MyProvider>(context,listen: false).details['street'] =
                                    resData[index]['details']['street'];
                                Provider.of<MyProvider>(context,listen: false).details['phoneNum'] =
                                    resData[index]['details']['phoneNum'];
                                Provider.of<MyProvider>(context,listen: false).details['total'] =
                                    resData[index]['total'].toString();
                                Provider.of<MyProvider>(context,listen: false).details['note'] = resData[index]['note'];
                                Provider.of<MyProvider>(context,listen: false).details['delivery'] =
                                    resData[index]['delivery'].toString();
                                Provider.of<MyProvider>(context,listen: false).details['resName'] =
                                    resData[index]['resName'];
                                Provider.of<MyProvider>(context,listen: false).details['length'] =
                                resData[index]['length'].toString();
                                for (int i = 0; i < resData[index]['length']; i++)
                                  Provider.of<MyProvider>(context,listen: false).detailedCart.add(FoodCart(
                                      resName: resData[index]['resName'],
                                      mealName: resData[index]['meals'][i]
                                          ['meal name'],
                                      mealPrice: resData[index]['meals'][i]
                                          ['meal price'],
                                      quantity: resData[index]['meals'][i]
                                          ['quantity'],
                                      foodID: resData[index].id,
                                      description: resData[index]['meals'][i]
                                      ['description'],));
                                Navigator.of(context)
                                    .pushReplacementNamed('detailsHistory');
                              },
                              trailing: TextButton(
                                onPressed: () => showDialog(
                                    context: ctx,
                                    builder: (BuildContext ctx) {
                                      return AlertDialog(
                                        title: Text(
                                          Provider.of<LanProvider>(context,listen: false).texts('reorder?'),
                                          textAlign:  Provider.of<LanProvider>(context).isEn
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
                                                Provider.of<LanProvider>(context,listen: false).texts('yes?'),
                                                style: const TextStyle(
                                                    fontSize: 19,
                                                    color: Colors.blue),
                                              ),
                                              onTap: () async {
                                                try {
                                                  setState(() {
                                                    Provider.of<MyProvider>(context,listen: false).isLoading = true;
                                                  });
                                                  for (int i = 0;
                                                      i <
                                                          resData[index]
                                                              ['length'];
                                                      i++)
                                                    Provider.of<MyProvider>(context,listen: false).myCart.add(FoodCart(
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
                                                        foodID: resData[index].id,
                                                        description: resData[index]
                                                        ['meals'][i]
                                                        ['description']));
                                                  Navigator.of(context).pop();
                                                  await Provider.of<MyProvider>(context,listen: false).reorder(
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
                                                    Provider.of<MyProvider>(context,listen: false).isLoading = false;
                                                    Provider.of<MyProvider>(context,listen: false).myCart.clear();
                                                  });
                                                } on FirebaseException catch (e) {
                                                  dialog( Provider.of<LanProvider>(context,listen: false)
                                                      .texts('Error occurred !'));
                                                  setState(() {
                                                    Provider.of<MyProvider>(context,listen: false).isLoading = false;
                                                    Provider.of<MyProvider>(context,listen: false).myCart.clear();
                                                  });
                                                  print(e.message);
                                                } catch (e) {
                                                  dialog( Provider.of<LanProvider>(context,listen: false)
                                                      .texts('Error occurred !'));
                                                  print(e);
                                                  setState(() {
                                                    Provider.of<MyProvider>(context,listen: false).isLoading = false;
                                                    Provider.of<MyProvider>(context,listen: false).myCart.clear();
                                                  });
                                                }
                                              }),
                                          const SizedBox(width: 11),
                                          InkWell(
                                              child: Text(
                                                  Provider.of<LanProvider>(context,listen: false).texts('cancel?'),
                                                  style: const TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 19)),
                                              onTap: () =>
                                                  Navigator.of(context).pop()),
                                        ],
                                      );
                                    }),
                                child: Text(
                                  Provider.of<LanProvider>(context,listen: false).texts('reorder'),
                                  style: const TextStyle(
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
                                    Text( Provider.of<LanProvider>(context,listen: false).texts('price') +
                                        resData[index]['total'].toString() +
                                        " " +
                                        Provider.of<LanProvider>(context,listen: false).texts('jd')),
                                    const SizedBox(height: 5),
                                    Text(Provider.of<MyProvider>(context,listen: false)
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
      ),
    );
  }
}
