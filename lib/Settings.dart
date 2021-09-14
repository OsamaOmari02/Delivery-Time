import 'package:app/LanguageProvider.dart';
import 'package:app/Myprovider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Drawer.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    Provider.of<MyProvider>(context, listen: false).getDarkMode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var lanProvider = Provider.of<LanProvider>(context);
    var provider = Provider.of<MyProvider>(context);

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
                      onChanged: (val) async {
                        SharedPreferences pref =
                            await SharedPreferences.getInstance();
                        pref.setBool('language', val);
                        setState(() {
                          lanProvider.isEn = val;
                        });
                        Navigator.of(context).pop();
                      }),
                  const Text("English", style: const TextStyle(fontSize: 20)),
                ],
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 8),
              elevation: 24,
              actions: [
                TextButton(
                    child: Text(lanProvider.texts('ok'),
                        style: const TextStyle(fontSize: 21)),
                    onPressed: () => Navigator.of(context).pop()),
              ],
            );
          });
    }
    dialog2() {
      return showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return AlertDialog(
              title: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Column(
                  children: [
                    TextButton(
                        onPressed: () async =>
                            await launch('tel://${0789259915}'),
                        child: const Text(
                          "0789259915",
                          style: const TextStyle(fontSize: 18),
                        )),
                    TextButton(
                        onPressed: () async =>
                            await launch('tel://${0789259915}'),
                        child: const Text(
                          "0789259915",
                          style: const TextStyle(fontSize: 18),
                        )),
                  ],
                ),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 8),
              elevation: 24,
              actions: [
                TextButton(
                    child: Text(lanProvider.texts('cancel?'),
                        style: const TextStyle(fontSize: 21)),
                    onPressed: () => Navigator.of(context).pop()),
              ],
            );
          });
    }

    return Directionality(
      textDirection: lanProvider.isEn ? TextDirection.ltr : TextDirection.rtl,
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
                onTap: () => dialog(),
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
                  value: provider.isDark,
                  onChanged: (bool val) async {
                    await provider.setDarkMode(val);
                  }),
            ),
            SizedBox(height: height * 0.013),
            ListTile(
              leading: const Icon(Icons.phone),
              title: InkWell(
                child: Text(lanProvider.texts('call us'),
                    style: TextStyle(
                        fontWeight: FontWeight.w600, fontSize: width * 0.055)),
                onTap: () => dialog2(),
              ),
            ),
            Divider(thickness: 0.6),
            // ListTile(
            //   leading: const Icon(Icons.star_rate_outlined),
            //   title: InkWell(
            //     child: Text(lanProvider.texts('rate app'),
            //         style: TextStyle(
            //             fontWeight: FontWeight.w600, fontSize: width * 0.055)),
            //     onTap: () {
            //       //  TODO add the link of the application
            //     },
            //   ),
            // ),
            // ListTile(
            //   leading: const Icon(Icons.share),
            //   title: InkWell(
            //     child: Text(lanProvider.texts('share app'),
            //         style: TextStyle(
            //             fontWeight: FontWeight.w600, fontSize: width * 0.055)),
            //     onTap: () {
            //       //  TODO share app
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
