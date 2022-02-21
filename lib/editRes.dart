import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'LanguageProvider.dart';
import 'Myprovider.dart';

class EditRes extends StatefulWidget {
  const EditRes({Key? key}) : super(key: key);

  @override
  _EditResState createState() => _EditResState();
}

class _EditResState extends State<EditRes> {
  ListTile fun(String title, icon, route) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(fontSize: 18),
      ),
      leading: Icon(icon),
      trailing: const Icon(Icons.arrow_forward),
      onTap: () => Navigator.of(context).pushNamed(route),
    );
  }
  ListTile listTile(String title, icon, route, BuildContext ctx) {
    return ListTile(
      onTap: () => Navigator.of(ctx).pushReplacementNamed(route),
      title: Text(
        title,
        style: const TextStyle(fontSize: 23),
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
    return SafeArea(
        child: Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('الإدارة'),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              const SizedBox(height: 20),
              listTile('صفحة الطلبات', Icons.home, 'callCenter', context),
              listTile('الإدارة', Icons.edit_off, 'editRes', context),
              ListTile(
                onTap: logOutFun,
                title: const Text(
                  "تسجيل الخروج",
                  style: const TextStyle(fontSize: 23, color: Colors.red),
                ),
                leading: const Icon(
                  Icons.logout,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
        body: ListView(
          children: [
            const SizedBox(height: 20),
            fun('تعديل أسعار التوصيل', Icons.delivery_dining, 'editDP'),
            const Divider(thickness: 0.8),
            fun('حذف وإضافة مطاعم', Icons.restaurant_menu, 'addOrRemoveRes'),
          ],
        ),
      ),
    ));
  }
}
