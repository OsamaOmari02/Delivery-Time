import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Myprovider.dart';

class Locations extends StatefulWidget {
  @override
  _LocationsState createState() => _LocationsState();
}

class _LocationsState extends State<Locations> {
  ListTile listTile(String title, icon, route, BuildContext ctx) {
    return ListTile(
      onTap: () => Navigator.of(ctx).pushReplacementNamed(route),
      title: Text(
        title,
        style: const TextStyle(fontSize: 25),
      ),
      leading: Icon(
        icon,
        color: Colors.blueAccent,
      ),
    );
  }
  dialog(title) {
    return showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text(
              title,
              textAlign: TextAlign.end,
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
              const SizedBox(width: 11),
              InkWell(
                  child: Text("حسناً", style: const TextStyle(fontSize: 19)),
                  onTap: () => Navigator.of(context).pop()),
            ],
          );
        });
  }
  logOutFun() {
    return showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text(
              'هل تريد تسجيل الخروج؟',
              textAlign: TextAlign.end,
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
                    "نعم",
                    style: const TextStyle(fontSize: 19, color: Colors.red),
                  ),
                  onTap: () async {
                    try {
                      await FirebaseAuth.instance.signOut();
                      setState(() {
                        Provider.of<MyProvider>(context,listen: false).authState = authStatus.Authenticated;
                        Navigator.of(context).pushReplacementNamed('login');
                        Provider.of<MyProvider>(context, listen: false)
                            .details
                            .clear();
                      });
                    } on FirebaseException catch (e) {
                      dialog("حدث خطأ !");
                      setState(() {
                        Provider.of<MyProvider>(context,listen: false).authState = authStatus.unAuthenticated;
                      });
                      print(e.message);
                    } catch (e) {
                      dialog("حدث خطأ !");
                      print(e);
                      setState(() {
                        Provider.of<MyProvider>(context,listen: false).authState = authStatus.unAuthenticated;
                      });
                    }
                  }),
              const SizedBox(width: 11),
              InkWell(
                  child: Text("إلغاء", style: const TextStyle(fontSize: 19)),
                  onTap: () => Navigator.of(context).pop()),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('الموقع'),
          centerTitle: true,
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              const SizedBox(height: 20),
              listTile('صفحة الطلبات', Icons.home, 'callCenter', context),
              listTile('الموقع', Icons.location_on, 'location', context),
              ListTile(
                onTap: logOutFun,
                title: Text(
                  "تسجيل الخروج",
                  style: const TextStyle(fontSize: 25, color: Colors.red),
                ),
                leading: const Icon(
                  Icons.logout,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
        body: const Center(
            child: const Text(
          'قيد الإنشاء...',
          style: const TextStyle(fontSize: 22),
        )),
      ),
    );
  }
}
