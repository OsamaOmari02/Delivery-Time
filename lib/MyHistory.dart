

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
    return Directionality(
      textDirection: lanProvider.isEn?TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(title: Text(lanProvider.texts('orders history')),centerTitle: true,),
        body: ListView(
          children: [

          ],
        ),
        // floatingActionButton: FloatingActionButton(
        //   tooltip: "delete",
        //   onPressed: () {
        //     showDialog(
        //       context: context,
        //       builder: (BuildContext ctx) {
        //         return AlertDialog(
        //           title: Text("Clear History?",style: TextStyle(fontSize: 23),),
        //           contentPadding: EdgeInsets.symmetric(vertical: 7),
        //           elevation: 24,
        //           content: Container(height: 46,child: Divider(),alignment: Alignment.topCenter,),
        //           actions: [
        //             InkWell(
        //               child: Text("Yes", style: TextStyle(fontSize: 19,color: Colors.red),
        //               ),
        //               onTap: () {},
        //             ),
        //             SizedBox(width: 11),
        //             InkWell(
        //                 child: Text("Cancel", style: TextStyle(fontSize: 19)),
        //                 onTap: () => Navigator.of(context).pop()),
        //           ],
        //         );
        //       },
        //     );
        //     final AlertDialog alert = AlertDialog(
        //       title: Text("hey"),
        //       content: Text("hey"),
        //     );
        //   },
        //   child: Icon(Icons.delete),
        //   backgroundColor: Theme.of(context).accentColor,
        // ),
      ),
    );
  }
}
