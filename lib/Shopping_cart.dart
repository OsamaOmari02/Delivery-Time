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
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    var lanProvider = Provider.of<LanProvider>(context);
    return Directionality(
      textDirection: lanProvider.isEn?TextDirection.ltr : TextDirection.rtl,
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
                    textAlign: lanProvider.isEn?TextAlign.start:TextAlign.end),
                  contentPadding: EdgeInsets.symmetric(vertical: 7),
                  elevation: 24,
                  content: Container(height: 46,child: Divider(),alignment: Alignment.topCenter,),
                  actions: [
                    InkWell(
                      child: Text(lanProvider.texts('yes?'), style: TextStyle(fontSize: 19,color: Colors.red),
                      ),
                      onTap: () {},
                    ),
                    SizedBox(width: 11),
                    InkWell(
                        child: Text(lanProvider.texts('cancel?'), style: TextStyle(fontSize: 19)),
                        onTap: () => Navigator.of(context).pop()),
                  ],
                );
              },
            );
          },
          child: Icon(Icons.delete),
          backgroundColor: Theme.of(context).accentColor,
        ),
        body: ListView(
          children: [
            ElevatedButton(onPressed: ()=> Fluttertoast.showToast(
                msg: "This is Center Short Toast",
                toastLength: Toast.LENGTH_SHORT,
                backgroundColor: Colors.grey,
                textColor: Colors.white,
                fontSize: 16.0
            ), child: Text("tests")
            ),
          ],
        ),
      ),
    );
  }
}
