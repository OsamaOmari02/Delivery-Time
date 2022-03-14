import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddOrRemoveRes extends StatefulWidget {
  const AddOrRemoveRes({Key? key}) : super(key: key);

  @override
  _AddOrRemoveResState createState() => _AddOrRemoveResState();
}

class _AddOrRemoveResState extends State<AddOrRemoveRes> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
    appBar: AppBar(
      centerTitle: true,
      title: Text('حذف وإضافة المطاعم'),
    ),
    body: ListView(
      children: [],
    ),
      ),
    );
  }
}
