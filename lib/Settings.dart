import 'package:app/LanguageProvider.dart';
import 'package:app/Myprovider.dart';
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
    var lanProvider = Provider.of<LanProvider>(context);
    dialog() {
      return showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return AlertDialog(
              title: Row(
                children: [
                  SizedBox(width: 10),
                  Text("Arabic", style: TextStyle(fontSize: 20)),
                  Switch(
                      activeColor: Colors.blueAccent,
                      activeTrackColor: Colors.blue[200],
                      value: lanProvider.isEn,
                      onChanged: (val){
                        Provider.of<LanProvider>(context,listen: false).changeLan(val);
                        Navigator.of(context).pop();
                  }),
                  Text("English", style: TextStyle(fontSize: 20)),
                ],
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 8),
              elevation: 24,
              actions: [
                TextButton(
                    child: Text("OK", style: TextStyle(fontSize: 21)),
                    onPressed: () => Navigator.of(context).pop()),
              ],
            );
          });
    }

    return Scaffold(
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
              onChanged: (bool val) =>
                  Provider.of<MyProvider>(context, listen: false).darkMode(val),
            ),
          ),
          SizedBox(height: height * 0.013),
          // ListTile(
          //   leading: Icon(Icons.delete),
          //   title: InkWell(
          //       child: Text("Delete History",
          //           style: TextStyle(
          //               fontWeight: FontWeight.w600, fontSize: width * 0.055)),
          //       onTap: () {
          //         showDialog(
          //             context: context,
          //             builder: (BuildContext ctx) {
          //               return AlertDialog(
          //                 title: Text(
          //                   "Are you sure?",
          //                   style: TextStyle(fontSize: 23),
          //                 ),
          //                 contentPadding: EdgeInsets.symmetric(vertical: 7),
          //                 elevation: 24,
          //                 content: Container(
          //                   height: 46,
          //                   child: Divider(),
          //                   alignment: Alignment.topCenter,
          //                 ),
          //                 actions: [
          //                   InkWell(
          //                     child: Text(
          //                       "Yes",
          //                       style:
          //                           TextStyle(fontSize: 19, color: Colors.red),
          //                     ),
          //                     onTap: () {},
          //                   ),
          //                   SizedBox(width: 11),
          //                   InkWell(
          //                       child: Text("Cancel",
          //                           style: TextStyle(fontSize: 19)),
          //                       onTap: () => Navigator.of(context).pop()),
          //                 ],
          //               );
          //             });
          //       }),
          // ),
          ListTile(
            leading: Icon(Icons.phone),
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
            leading: Icon(Icons.star_rate_outlined),
            title: InkWell(
              child: Text(lanProvider.texts('rate app'),
                  style: TextStyle(
                      fontWeight: FontWeight.w600, fontSize: width * 0.055)),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}
