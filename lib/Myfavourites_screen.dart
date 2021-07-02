

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Drawer.dart';

class MyFavourites extends StatefulWidget {
  const MyFavourites({Key? key}) : super(key: key);

  @override
  _MyFavouritesState createState() => _MyFavouritesState();
}

class _MyFavouritesState extends State<MyFavourites> {
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(title: Text("My favourite"),centerTitle: true,),
      body: ListView(
        children: [

        ],
      ),
    );
  }
}
