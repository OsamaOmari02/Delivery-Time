import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

  Widget _textField(cnt, title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: TextFormField(
        controller: cnt,
        keyboardType: TextInputType.number,
        style: const TextStyle(
          color: Colors.black,
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

  void getDP() async {
    await FirebaseFirestore.instance
        .collection('DP')
        .doc('1')
        .get()
        .then((value) {
      setState(() {
        group1 = TextEditingController(
            text: double.parse(value['price1']).toString());
        group2 = TextEditingController(
            text: double.parse(value['price2']).toString());
        group3 = TextEditingController(
            text: double.parse(value['price3']).toString());
        group4 = TextEditingController(
            text: double.parse(value['price4']).toString());
        group5 = TextEditingController(
            text: double.parse(value['price5']).toString());
        group6 = TextEditingController(
            text: double.parse(value['price6']).toString());
        group7 = TextEditingController(
            text: double.parse(value['price7']).toString());
        group8 = TextEditingController(
            text: double.parse(value['price8']).toString());
        group9 = TextEditingController(
            text: double.parse(value['price9']).toString());
        group10 = TextEditingController(
            text: double.parse(value['price10']).toString());
        group11 = TextEditingController(
            text: double.parse(value['price11']).toString());
        group12 = TextEditingController(
            text: double.parse(value['price12']).toString());
        group13 = TextEditingController(
            text: double.parse(value['price13']).toString());
        group14 = TextEditingController(
            text: double.parse(value['price14']).toString());
        group15 = TextEditingController(
            text: double.parse(value['price15']).toString());
      });
    });
  }

  @override
  void initState() {
    getDP();
    super.initState();
  }

  @override
  void dispose() {
    group1.dispose();
    group2.dispose();
    group3.dispose();
    group4.dispose();
    group5.dispose();
    group6.dispose();
    group7.dispose();
    group8.dispose();
    group9.dispose();
    group10.dispose();
    group11.dispose();
    group12.dispose();
    group13.dispose();
    group14.dispose();
    group15.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: InkWell(
                  child: const Text(
                    "حفظ",
                    style: TextStyle(fontSize: 20),
                  ),
                  onTap: () async{
                    try{
                      await FirebaseFirestore.instance.collection('DP').doc('1').update({
                        'price1': group1.text,
                        'price2': group2.text,
                        'price3': group3.text,
                        'price4': group4.text,
                        'price5': group5.text,
                        'price6': group6.text,
                        'price7': group7.text,
                        'price8': group8.text,
                        'price9': group9.text,
                        'price10': group10.text,
                        'price11': group11.text,
                        'price12': group12.text,
                        'price13': group13.text,
                        'price14': group14.text,
                        'price15': group15.text,
                      }).whenComplete(() => Fluttertoast.showToast(
                          msg: "تم الحفظ بنجاح",
                          toastLength: Toast.LENGTH_SHORT,
                          backgroundColor: Colors.grey,
                          textColor: Colors.white,
                          fontSize: 16.0));
                    } on FirebaseException catch (e) {
                      print(e);
                      Fluttertoast.showToast(
                          msg: "حدث خطأ !",
                          toastLength: Toast.LENGTH_SHORT,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } catch (e) {
                     print(e);
                    }
                  }),
            ),
          ],
          centerTitle: true,
          title: const Text('تعديل أسعار التوصيل'),
        ),
        body: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          children: [
            const SizedBox(height: 20),
            _textField(group1, "المجموعة الاولى"),
            _textField(group2, "المجموعة الثانية"),
            _textField(group3, "المجموعة الثالثة"),
            _textField(group4, "المجموعة الرابعة"),
            _textField(group5, "المجموعة الخامسة"),
            _textField(group6, "المجموعة السادسة"),
            _textField(group7, "المجموعة السابعة"),
            _textField(group8, "المجموعة الثامنة"),
            _textField(group9, "المجموعة التاسعة"),
            _textField(group10, "المجموعة العاشرة"),
            _textField(group11, "المجموعة الحادية عشر"),
            _textField(group12, "المجموعة الثانية عشر"),
            _textField(group13, "المجموعة الثالثة عشر"),
            _textField(group14, "المجموعة الرابعة عشر"),
            _textField(group15, "المجموعة الخامسة عشر"),
          ],
        ),
      ),
    ));
  }
}
