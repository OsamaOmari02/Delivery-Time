import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'LanguageProvider.dart';
import 'Myprovider.dart';

class Shopping extends StatefulWidget {
  @override
  _ShoppingState createState() => _ShoppingState();
}


class _ShoppingState extends State<Shopping> {
  int _itemCount = 0;
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    var lanProvider = Provider.of<LanProvider>(context);
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

    return Directionality(
      textDirection: lanProvider.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            lanProvider.texts('food cart'),
            style: const TextStyle(fontSize: 20),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: lanProvider.texts('delete'),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext ctx) {
                return AlertDialog(
                  title: Text(lanProvider.texts('clear everything?'),
                      style: const TextStyle(fontSize: 23),
                      textAlign:
                          lanProvider.isEn ? TextAlign.start : TextAlign.end),
                  contentPadding: const EdgeInsets.symmetric(vertical: 7),
                  elevation: 24,
                  content: Container(
                    height: 46,
                    child: const Divider(),
                    alignment: Alignment.topCenter,
                  ),
                  actions: [
                    InkWell(
                      child: Text(
                        lanProvider.texts('yes?'),
                        style: const TextStyle(fontSize: 19, color: Colors.red),
                      ),
                      onTap: () {
                      //  delete the food cart
                      },
                    ),
                    const SizedBox(width: 11),
                    InkWell(
                        child: Text(lanProvider.texts('cancel?'),
                            style: const TextStyle(fontSize: 19)),
                        onTap: () => Navigator.of(context).pop()),
                  ],
                );
              },
            );
          },
          child: const Icon(Icons.delete),
          backgroundColor: Theme.of(context).accentColor,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('orders/${user!.uid}/myOrders')
              .snapshots(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState==ConnectionState.waiting)
               Center(child: const CircularProgressIndicator());
            if (!snapshot.hasData)
              return Center(child: Text("Food cart is empty!"));
            return Scrollbar(
              child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, int index) {
                  var resData = snapshot.data!.docs;
                  return Card(
                    child: Row(
                      children: <Widget>[
                        const SizedBox(width: 15),
                        Expanded(
                          flex: 2,
                          child: Container(
                            child:
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const SizedBox(height: 20),
                                    Container(
                                      padding: const EdgeInsets.only(left: 10),
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        resData[index]['meal name'],
                                        style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w800),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(left: 10),
                                      alignment: Alignment.bottomLeft,
                                      margin: const EdgeInsets.only(top: 17),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 7),
                                        child: Text(
                                          lanProvider.texts('price') +
                                              " " +
                                              resData[index]['meal price'] +
                                              " " +
                                              lanProvider.texts('jd'),
                                          style: const TextStyle(
                                              fontSize: 16, color: Colors.pink),
                                        ),
                                      ),
                                    ),
                                  ],
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            _itemCount != 0
                                ? IconButton(
                                    icon: const Icon(
                                      Icons.remove,
                                      color: Colors.red,
                                    ),
                                    onPressed: () async{
                                      try{
                                        setState(() {
                                          provider.mealID = resData[index].id;
                                          _itemCount--;
                                        });
                                        provider.subtractPrice(int.parse(
                                            resData[index]['meal price']));
                                        provider.addFoodCart(resData[index]['meal name'],
                                            resData[index]['meal price']);
                                      } on FirebaseException catch (e){
                                        dialog(e.message);
                                        setState(() {
                                          provider.isLoading=false;
                                          _itemCount++;
                                        });
                                        print(e);
                                      } catch (e){
                                        dialog(lanProvider.texts('Error occurred !'));
                                        setState(() {
                                          provider.isLoading=false;
                                          _itemCount++;
                                        });
                                        print(e);
                                      }
                                    },
                                  )
                                : Container(),
                            Text(_itemCount.toString()),
                            IconButton(
                                icon: const Icon(
                                  Icons.add,
                                  color: Colors.green,
                                ),
                                onPressed: () async{
                                  try{
                                    setState(() {
                                      provider.mealID = resData[index].id;
                                      _itemCount++;
                                    });
                                    provider.addPrice(int.parse(
                                        resData[index]['meal price']));
                                    provider.addFoodCart(resData[index]['meal name'],
                                        resData[index]['meal price']);
                                  } on FirebaseException catch (e){
                                    dialog(e.message);
                                    setState(() {
                                      provider.isLoading=false;
                                      _itemCount--;
                                    });
                                    print(e);
                                  } catch (e){
                                    dialog(lanProvider.texts('Error occurred !'));
                                    setState(() {
                                      provider.isLoading=false;
                                      _itemCount--;
                                    });
                                    print(e);
                                  }
                                },
                            ),
                          ],
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
