import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Myprovider.dart';

class DPEdit extends StatefulWidget {
  const DPEdit({Key? key}) : super(key: key);

  @override
  _DPEditState createState() => _DPEditState();
}

class _DPEditState extends State<DPEdit> {
  TextEditingController group1 = TextEditingController();
  TextEditingController group2 = TextEditingController();
  TextEditingController group3 = TextEditingController();
  TextEditingController group4 = TextEditingController();
  TextEditingController group5 = TextEditingController();
  TextEditingController group6 = TextEditingController();
  TextEditingController group7 = TextEditingController();
  TextEditingController group8 = TextEditingController();
  TextEditingController group9 = TextEditingController();
  TextEditingController group10 = TextEditingController();
  TextEditingController group11 = TextEditingController();
  TextEditingController group12 = TextEditingController();
  TextEditingController group13 = TextEditingController();
  TextEditingController group14 = TextEditingController();
  TextEditingController group15 = TextEditingController();

  Widget _textField(cnt,title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: TextFormField(
        controller: cnt,
        keyboardType: TextInputType.number,
        style: const TextStyle(
          color: Colors.white,
        ),
        cursorColor: Colors.blue,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              gapPadding: 5, borderRadius: BorderRadius.circular(10)),
          labelText: title,
          labelStyle: const TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('تعديل أسعار التوصيل'),
        ),
        body: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          children: [
            const SizedBox(height: 20),
            _textField(group1,"المجموعة الاولى"),
            _textField(group2,"المجموعة الثانية"),
            _textField(group3,"المجموعة الثالثة"),
            _textField(group4,"المجموعة الرابعة"),
            _textField(group5,"المجموعة الخامسة"),
            _textField(group6,"المجموعة السادسة"),
            _textField(group7,"المجموعة السابعة"),
            _textField(group8,"المجموعة الثامنة"),
            _textField(group9,"المجموعة التاسعة"),
            _textField(group10,"المجموعة العاشرة"),
            _textField(group11,"المجموعة الحادية عشر"),
            _textField(group12,"المجموعة الثانية عشر"),
            _textField(group13,"المجموعة الثالثة عشر"),
            _textField(group14,"المجموعة الرابعة عشر"),
            _textField(group15,"المجموعة الخامسة عشر"),
          ],
        ),
      ),
    ));
  }
}
