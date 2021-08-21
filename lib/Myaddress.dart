

import 'package:app/Addaddress.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'Drawer.dart';
import 'LanguageProvider.dart';
import 'Myprovider.dart';

class MyAddress extends StatefulWidget {
  @override
  _MyAddressState createState() => _MyAddressState();
}

class _MyAddressState extends State<MyAddress> {


  @override
  void initState() {
    Provider.of<MyProvider>(context,listen: false).fetchAddress();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var provider = Provider.of<MyProvider>(context);
    var lanProvider = Provider.of<LanProvider>(context);
    var user = FirebaseAuth.instance.currentUser;
    dialog(title) {
      return showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return AlertDialog(
              title: Row(
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 30,
                    color: Colors.red,
                  ),
                  const SizedBox(width: 17),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(fontSize: 23, color: Colors.red),
                    ),
                  ),
                ],
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 8),
              elevation: 24,
              content: Container(
                height: MediaQuery.of(context).size.height * 0.05,
                child: const Divider(),
                alignment: Alignment.topCenter,
              ),
              actions: [
                TextButton(
                    child: Text(lanProvider.texts('ok'), style: const TextStyle(fontSize: 21)),
                    onPressed: () => Navigator.of(context).pop()),
              ],
            );
          });
    }

    return Directionality(
      textDirection: lanProvider.isEn?TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          actions: [
            IconButton(
              icon: provider.isLoading ? CircularProgressIndicator()
                  : Icon(Icons.add),
              onPressed: () => Navigator.of(context).pushNamed('addAddress'),
            ),
          ],
          title: Text(lanProvider.texts('my addresses')),
          centerTitle: true,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('/address/${user!.uid}/addresses')
              .snapshots(),
          builder: (ctx, snapshot) {
            if (!snapshot.hasData)
              return Center(child: Text(lanProvider.texts('new address'),
                  style: const TextStyle(fontSize: 17,fontStyle: FontStyle.italic)));
            if (snapshot.connectionState==ConnectionState.waiting)
              return Center(child: const CircularProgressIndicator());
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                var userData = snapshot.data!.docs;
                if (snapshot.data!.docs.length!=0)
                return ListTile(
                  onLongPress: () {
                    setState(() {
                     provider.iD = userData[index].id;
                    });
                    dialog(lanProvider.texts('delete this address?'));
                  },
                  title: Text(userData[index]['area']),
                  subtitle: Text(lanProvider.texts('street:') +
                      userData[index]['street'] +
                      "\n" + lanProvider.texts('phone:') +
                      userData[index]['phoneNum']),
                  isThreeLine: true,
                );
                  return Center(
                      child: Text(lanProvider.texts('new address'),
                          style: const TextStyle(fontSize: 17,fontStyle: FontStyle.italic)));
              },
            );
          },
        ),
      ),
    );
  }
}
