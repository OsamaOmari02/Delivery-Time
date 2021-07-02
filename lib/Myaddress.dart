

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Drawer.dart';

class MyAddress extends StatefulWidget {
  const MyAddress({Key? key}) : super(key: key);

  @override
  _MyAddressState createState() => _MyAddressState();
}

class _MyAddressState extends State<MyAddress> {

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(title: Text("My Address"),centerTitle: true,),
      body: ListView(
        children: [
          SizedBox(height:height*0.03),
          TextField(),
          SizedBox(height:height*0.03),
          TextField(),
          SizedBox(height:height*0.03),
          TextField(),
          SizedBox(height:height*0.03),
          TextField(),
          SizedBox(height:height*0.03),
        ],
      ),
    );
  }
}