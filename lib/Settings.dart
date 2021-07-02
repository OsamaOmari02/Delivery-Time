

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Drawer.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(title: Text("Settings"),centerTitle: true,),
      body: null,
    );
  }
}