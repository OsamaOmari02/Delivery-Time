
import 'package:app/Myprovider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:provider/provider.dart';
import 'Drawer.dart';
import 'main.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text("Settings"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        children: [
          SizedBox(height: height * 0.05),
          ListTile(
            leading: Icon(Icons.language),
            title: InkWell(
              child: Text("Language",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, fontSize: width * 0.055)),
              onTap: () {},
            ),
          ),
          SizedBox(height: height * 0.013),
          ListTile(
            leading: Icon(Icons.dark_mode),
            title: Text("Dark Mode",
                style: TextStyle(
                    fontWeight: FontWeight.w600, fontSize: width * 0.055)),
            trailing: Switch(
              activeColor: Colors.blueAccent,
              activeTrackColor: Colors.blue[200],
              value: Provider.of<MyProvider>(context).isDark,
              onChanged:(bool val)=>Provider.of<MyProvider>(context,listen: false).darkMode(val),
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
                child: Text("Call Us",
                    style: TextStyle(
                        fontWeight: FontWeight.w600, fontSize: width * 0.055)),
                onTap: ()=> FlutterPhoneDirectCaller.callNumber(0789259915.toString()),
                ),
          ),
          Divider(thickness: 0.6),
          ListTile(
            leading: Icon(Icons.star_rate_outlined),
            title: InkWell(
              child: Text("Rate This Application",
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
