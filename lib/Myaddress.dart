import 'package:app/Addaddress.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Drawer.dart';
import 'Myprovider.dart';

class MyAddress extends StatefulWidget {
  const MyAddress({Key? key}) : super(key: key);

  @override
  _MyAddressState createState() => _MyAddressState();
}

class _MyAddressState extends State<MyAddress> {
  // listTile(areaName, stName, mobile) {
  //   ListTile(
  //     onTap: () {},
  //     title: Text(areaName),
  //     subtitle: Text("Street : $stName\nMobile : $mobile"),
  //     isThreeLine: true,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var provider = Provider.of<MyProvider>(context);
    var user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Navigator.of(context).pushNamed('addAddress'),
          ),
        ],
        title: Text("My Addresses"),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('/address/${user!.uid}/addresses').snapshots(),
        builder: (ctx, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator(color: Colors.blue,));
          else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                var userDate = snapshot.data!.docs;
                return ListTile(
                  onTap: () {},
                  title: Text(userDate[index]['area']),
                  subtitle: Text("Street : " +
                      userDate[index]['street'] +
                      "\nMobile : " +
                      userDate[index]['phoneNum']),
                  isThreeLine: true,
                );
              },
              // children: snapshot.data!.docs.map((doc) {
              // } ).toList(),
            );
          }
        },
      ),
    );
  }
}
