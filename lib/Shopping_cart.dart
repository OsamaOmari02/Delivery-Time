import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Shopping extends StatefulWidget {
  @override
  _ShoppingState createState() => _ShoppingState();
}

class _ShoppingState extends State<Shopping> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Shopping Cart",
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
          final AlertDialog alert = AlertDialog(
            title: Text("hey"),
            content: Text("hey"),
          );
        },
        child: Icon(Icons.delete),
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: ListView(
        children: [
          Card(),
        ],
      ),
    );
  }
}
