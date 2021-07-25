import 'dart:developer';

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
  @override
  _MyAddressState createState() => _MyAddressState();
}

class _MyAddressState extends State<MyAddress> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var provider = Provider.of<MyProvider>(context);
    var user = FirebaseAuth.instance.currentUser;
    LogoutFun(title) {
      return showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return AlertDialog(
              title: Row(
                children: [
                  Icon(
                    Icons.delete,
                    size: 30,
                    color: Colors.red,
                  ),
                  SizedBox(width: 17),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(fontSize: 23, color: Colors.red),
                    ),
                  ),
                ],
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 8),
              elevation: 24,
              content: Container(
                height: MediaQuery.of(context).size.height * 0.05,
                child: Divider(),
                alignment: Alignment.topCenter,
              ),
              actions: [
                TextButton(
                    child: Text("Yes", style: TextStyle(fontSize: 19)),
                    onPressed: () async {
                      try {
                        setState(() {
                          provider.isLoading = true;
                        });
                        Navigator.of(context).pop();
                        await provider.delete();
                        setState(() {
                          provider.isLoading = false;
                        });
                      } on FirebaseAuthException catch (e) {
                        setState(() {
                          provider.isLoading = false;
                        });
                        print(e.message);
                      } catch (e) {
                        setState(() {
                          provider.isLoading = false;
                        });
                        print(e);
                      }
                    }),
                TextButton(
                    child: Text("Cancel", style: TextStyle(fontSize: 19)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
              ],
            );
          });
    }

    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        actions: [
          IconButton(
            icon: provider.isLoading ? CircularProgressIndicator()
                : Icon(Icons.add),
            onPressed: () => Navigator.of(context).pushNamed('addAddress'),
          ),
        ],
        title: Text("My Addresses"),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('/address/${user!.uid}/addresses')
            .snapshots(),
        builder: (ctx, snapshot) {
          if (!snapshot.hasData)
            return Center(
                child: Text("Add an address",
                    style: TextStyle(color: Colors.grey)));
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              var userData = snapshot.data!.docs;
              return ListTile(
                onLongPress: () {
                  setState(() {
                   provider.iD = userData[index].id;
                  });
                  LogoutFun("Are you sure you want to delete this address?");
                },
                title: Text(userData[index]['area']),
                subtitle: Text("Street : " +
                    userData[index]['street'] +
                    "\nMobile : " +
                    userData[index]['phoneNum']),
                isThreeLine: true,
              );
            },
          );
        },
      ),
    );
  }
}
