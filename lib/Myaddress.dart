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
  var stream;
  var user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    Provider.of<MyProvider>(context, listen: false).fetchAddress();
      stream = FirebaseFirestore.instance
          .collection('/address/${user!.uid}/addresses')
          .snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                    child: Text( Provider.of<LanProvider>(context,listen: false).texts('ok'),
                        style: const TextStyle(fontSize: 21)),
                    onPressed: () => Navigator.of(context).pop()),
              ],
            );
          });
    }

    delete(title) {
      return showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return AlertDialog(
              title: Text(
                title,
                textAlign:  Provider.of<LanProvider>(context).isEn ? TextAlign.start : TextAlign.end,
                style: const TextStyle(fontSize: 23),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 7),
              elevation: 24,
              content: Container(
                height: 30,
                child: const Divider(),
                alignment: Alignment.topCenter,
              ),
              actions: [
                InkWell(
                    child: Text(
                      Provider.of<LanProvider>(context,listen: false).texts('yes?'),
                      style: const TextStyle(fontSize: 19, color: Colors.red),
                    ),
                    onTap: () async {
                      try {
                        setState(() {
                          Provider.of<MyProvider>(context,listen: false).isLoading = true;
                        });
                        Navigator.of(context).pop();
                        await Provider.of<MyProvider>(context,listen: false).delete();
                        Fluttertoast.showToast(
                            msg:  Provider.of<LanProvider>(context,listen: false).texts('Address Deleted'),
                            toastLength: Toast.LENGTH_SHORT,
                            backgroundColor: Colors.grey,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        setState(() {
                          Provider.of<MyProvider>(context,listen: false).isLoading = false;
                        });
                      } on FirebaseException catch (e) {
                        dialog(e.message);
                        setState(() {
                          Provider.of<MyProvider>(context,listen: false).isLoading = false;
                          final addressObj = Provider.of<MyProvider>(context,listen: false).loc.firstWhere((element) => element.id == Provider.of<MyProvider>(context).iD);
                          Provider.of<MyProvider>(context,listen: false).loc.add(addressObj);
                        });
                      } catch (e) {
                        dialog( Provider.of<LanProvider>(context,listen: false).texts('Error occurred !'));
                        print(e);
                        setState(() {
                          Provider.of<MyProvider>(context,listen: false).isLoading = false;
                          final addressObj = Provider.of<MyProvider>(context,listen: false).loc.firstWhere((element) => element.id == Provider.of<MyProvider>(context).iD);
                          Provider.of<MyProvider>(context,listen: false).loc.add(addressObj);
                        });
                      }
                    }),
                const SizedBox(width: 11),
                InkWell(
                    child: Text( Provider.of<LanProvider>(context,listen: false).texts('cancel?'),
                        style: const TextStyle(fontSize: 19)),
                    onTap: () => Navigator.of(context).pop()),
              ],
            );
          });
    }
    Future<bool> _onWillPop() async {
      await Navigator.of(context).pushReplacementNamed('MyHomepage');
      throw "";
    }

    return Directionality(
      textDirection:  Provider.of<LanProvider>(context).isEn ? TextDirection.ltr : TextDirection.rtl,
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          drawer: MyDrawer(),
          appBar: AppBar(
            backgroundColor: Colors.blue,
            actions: [
              IconButton(
                icon: Provider.of<MyProvider>(context,listen: false).isLoading
                    ? CircularProgressIndicator()
                    : Icon(Icons.add),
                onPressed: () => Navigator.of(context).pushNamed('addAddress'),
              ),
            ],
            title: Text( Provider.of<LanProvider>(context,listen: false).texts('my addresses')),
            centerTitle: true,
          ),
          body: StreamBuilder<QuerySnapshot>(
            stream: stream,
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return const Center(child: const CircularProgressIndicator());
              if (snapshot.hasError)
                return Center(
                    child: Text(
                      Provider.of<LanProvider>(context,listen: false).texts('Error occurred !'),
                  style: const TextStyle(color: Colors.red),
                ));
                return ListView.builder(
                  itemCount: Provider.of<MyProvider>(context).loc.length,
                  itemBuilder: (BuildContext context, int index) {
                    var userData = snapshot.data!.docs;
                    if (Provider.of<MyProvider>(context).loc.isEmpty || userData.isEmpty) {
                      return Center(
                          child: Text( Provider.of<LanProvider>(context,listen: false).texts('new address'),
                              style: const TextStyle(
                                  fontSize: 17, fontStyle: FontStyle.italic)));
                    }
                    return Card(
                      elevation: 1.5,
                      child: ListTile(
                        onLongPress: () async {
                          setState(() {
                            Provider.of<MyProvider>(context,listen: false).iD = userData[index].id;
                          });
                          await delete( Provider.of<LanProvider>(context,listen: false).texts('delete this address?'));
                        },
                        title: Text(userData[index]['area']??""),
                        subtitle: Text( Provider.of<LanProvider>(context,listen: false).texts('street:') +
                            userData[index]['street']+
                            "\n" +
                            Provider.of<LanProvider>(context,listen: false).texts('phone:') +
                            userData[index]['phoneNum']),
                        isThreeLine: true,
                      ),
                    );
                  },
                );
            },
          ),
        ),
      ),
    );
  }
}
