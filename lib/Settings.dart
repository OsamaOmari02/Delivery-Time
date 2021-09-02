import 'package:app/LanguageProvider.dart';
import 'package:app/Myprovider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:provider/provider.dart';
import 'Drawer.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var user = FirebaseAuth.instance.currentUser;
    var res =  FirebaseFirestore.instance.collection('users');
    var lanProvider = Provider.of<LanProvider>(context);
    var provider = Provider.of<MyProvider>(context);
    double _long = 0;
    double _lat = 0;
    dialog() {
      return showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return AlertDialog(
              title: Row(
                children: [
                  const SizedBox(width: 10),
                  const Text("عربي", style: const TextStyle(fontSize: 20)),
                  Switch(
                      activeColor: Colors.blueAccent,
                      activeTrackColor: Colors.blue[200],
                      value: lanProvider.isEn,
                      onChanged: (val) async{
                        await res.doc(user!.uid).update({
                          'Language':val,
                        });
                        Provider.of<LanProvider>(context,listen: false).setLanguage(val);
                        Navigator.of(context).pop();
                  }),
                  const Text("English", style: const TextStyle(fontSize: 20)),
                ],
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 8),
              elevation: 24,
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
          title: Text(lanProvider.texts('Drawer6')),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: ListView(
          children: [
            SizedBox(height: height * 0.05),
            ListTile(
              leading: Icon(Icons.language),
              title: InkWell(
                  child: Text(lanProvider.texts('language'),
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: width * 0.055)),
                  onTap: ()=> dialog(),
              ),
            ),
            SizedBox(height: height * 0.013),
            ListTile(
              leading: Icon(Icons.dark_mode),
              title: Text(lanProvider.texts('dark mode'),
                  style: TextStyle(
                      fontWeight: FontWeight.w600, fontSize: width * 0.055)),
              trailing: Switch(
                activeColor: Colors.blueAccent,
                activeTrackColor: Colors.blue[200],
                value: Provider.of<MyProvider>(context).isDark,
                onChanged: (bool val) async{
                  await res.doc(user!.uid).update({
                    'darkMode':val,
                  });
                    Provider.of<MyProvider>(context,listen: false).setDarkMode(val);
                }
              ),
            ),
            SizedBox(height: height * 0.013),
            ListTile(
              leading: const Icon(Icons.phone),
              title: InkWell(
                child: Text(lanProvider.texts('call us'),
                    style: TextStyle(
                        fontWeight: FontWeight.w600, fontSize: width * 0.055)),
                onTap: () =>
                    FlutterPhoneDirectCaller.callNumber(0789259915.toString()),
              ),
            ),
            Divider(thickness: 0.6),
            ListTile(
              leading: const Icon(Icons.star_rate_outlined),
              title: InkWell(
                child: Text(lanProvider.texts('rate app'),
                    style: TextStyle(
                        fontWeight: FontWeight.w600, fontSize: width * 0.055)),
                onTap: () async{
                  await FirebaseFirestore.instance.collection('users').doc(user!.uid).get().then((value) {
                    _lat = value.data()!['latitude']??=0;
                    _long = value.data()!['longitude']??=0;
                  });
                  await provider.goToMaps(_long, _lat);
                },
              ),
            ),
            OutlinedButton(
                onPressed: () => Navigator.of(context).pushNamed('adminSweets'),
                child: Text("sweets")),
            ElevatedButton(
                onPressed: () => Navigator.of(context).pushNamed('adminHomos'),
                child: Text("homos"))
          ],
        ),
      ),
    );
  }
}
