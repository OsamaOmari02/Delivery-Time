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
                style: TextStyle(fontSize: 23),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 7),
              elevation: 24,
              content: Container(
                height: 30,
                child: const Divider(),
                alignment: Alignment.topCenter,
              ),
              actions: [
                SizedBox(width: 11),
                InkWell(
                    child: Text(lanProvider.texts('ok'),
                        style: TextStyle(fontSize: 19)),
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
            style: TextStyle(fontSize: 20),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: "delete",
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext ctx) {
                return AlertDialog(
                  title: Text(lanProvider.texts('clear everything?'),
                      style: TextStyle(fontSize: 23),
                      textAlign:
                          lanProvider.isEn ? TextAlign.start : TextAlign.end),
                  contentPadding: EdgeInsets.symmetric(vertical: 7),
                  elevation: 24,
                  content: Container(
                    height: 46,
                    child: Divider(),
                    alignment: Alignment.topCenter,
                  ),
                  actions: [
                    InkWell(
                      child: Text(
                        lanProvider.texts('yes?'),
                        style: TextStyle(fontSize: 19, color: Colors.red),
                      ),
                      onTap: () {},
                    ),
                    SizedBox(width: 11),
                    InkWell(
                        child: Text(lanProvider.texts('cancel?'),
                            style: TextStyle(fontSize: 19)),
                        onTap: () => Navigator.of(context).pop()),
                  ],
                );
              },
            );
          },
          child: Icon(Icons.delete),
          backgroundColor: Theme.of(context).accentColor,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('/users/${user!.uid}/food cart')
              .snapshots(),
          builder: (ctx, snapshot) {
            if (!snapshot.hasData)
              return Center(child: CircularProgressIndicator());
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
                                    SizedBox(height: 20),
                                    Container(
                                      padding: EdgeInsets.only(left: 10),
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        resData[index]['meal name'],
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w800),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 10),
                                      alignment: Alignment.bottomLeft,
                                      margin: EdgeInsets.only(top: 17),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 7),
                                        child: Text(
                                          lanProvider.texts('price') +
                                              " " +
                                              resData[index]['meal price'] +
                                              " " +
                                              lanProvider.texts('jd'),
                                          style: TextStyle(
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
                                    icon: Icon(
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
                                        provider.foodCart(resData[index]['meal name'],
                                            resData[index]['meal price'],_itemCount);
                                      } on FirebaseException catch (e){
                                        dialog(e.message);
                                        setState(() {
                                          provider.isLoading=false;
                                          _itemCount++;
                                        });
                                        print(e);
                                      } catch (e){
                                        dialog('error !');
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
                                icon: Icon(
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
                                    provider.foodCart(resData[index]['meal name'],
                                        resData[index]['meal price'],_itemCount);
                                  } on FirebaseException catch (e){
                                    dialog(e.message);
                                    setState(() {
                                      provider.isLoading=false;
                                      _itemCount--;
                                    });
                                    print(e);
                                  } catch (e){
                                    dialog('error !');
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
