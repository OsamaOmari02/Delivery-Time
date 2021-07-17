import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Myprovider.dart';

class Shopping extends StatefulWidget {
  @override
  _ShoppingState createState() => _ShoppingState();
}

class _ShoppingState extends State<Shopping> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Food Cart",
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
                title: Text("Clear everything?",style: TextStyle(fontSize: 23),),
                contentPadding: EdgeInsets.symmetric(vertical: 7),
                elevation: 24,
                content: Container(height: 46,child: Divider(),alignment: Alignment.topCenter,),
                actions: [
                  InkWell(
                    child: Text("Yes", style: TextStyle(fontSize: 19,color: Colors.red),
                    ),
                    onTap: () {},
                  ),
                  SizedBox(width: 11),
                  InkWell(
                      child: Text("Cancel", style: TextStyle(fontSize: 19)),
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
          // Card(child: Text(provider.email),)
        ],
      ),
    );
  }
}
