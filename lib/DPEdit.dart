import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DPEdit extends StatefulWidget {
  const DPEdit({Key? key}) : super(key: key);

  @override
  _DPEditState createState() => _DPEditState();
}

class _DPEditState extends State<DPEdit> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('تعديل أسعار التوصيل'),
        ),
        body: ListView(
          children: [

          ],
        ),
      ),
    ));
  }
}
