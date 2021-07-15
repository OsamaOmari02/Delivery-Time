import 'dart:io';
import 'package:app/Myprovider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  ListTile listTile(String title, icon, route, BuildContext ctx) {
    return ListTile(
      onTap: () => Navigator.of(ctx).pushReplacementNamed(route),
      title: Text(
        title,
        style: TextStyle(fontSize: 25),
      ),
      leading: Icon(
        icon,
        color: Colors.blueAccent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var provider = Provider.of<MyProvider>(context);
    LogoutFun() {
      return showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return AlertDialog(
              title: Text(
                "Are you sure you want to log out?",
                style: TextStyle(fontSize: 23),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 7),
              elevation: 24,
              content: Container(
                height: 30,
                child: Divider(),
                alignment: Alignment.topCenter,
              ),
              actions: [
                InkWell(
                  child: Text(
                    "Yes",
                    style: TextStyle(fontSize: 19, color: Colors.red),
                  ),
                  onTap: () => FirebaseAuth.instance.signOut().then((_){
                     provider.authState = authStatus.Authenticated;
                    Navigator.of(context).pushReplacementNamed('login');
                  }),
                ),
                SizedBox(width: 11),
                InkWell(
                    child: Text("Cancel", style: TextStyle(fontSize: 19)),
                    onTap: () => Navigator.of(context).pop()),
              ],
            );
          });
    }

    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Container(
              child: Image.asset(
                ('file/time_delivery.jpg'),
                fit: BoxFit.fill,
              ),
            ),
            padding: EdgeInsets.all(0),
          ),
          Row(
            children: [
              SizedBox(width: width * 0.03),
              Expanded(child: Text('welcome ${provider.authData['name']} !', style: TextStyle(fontSize: 21))),
            ],
          ),
          listTile("Home", Icons.home, 'MyHomepage', context),
          Divider(thickness: 1),
          listTile("Account", Icons.account_circle, 'MyAccount', context),
          Divider(thickness: 1),
          listTile("Favourites", Icons.favorite, 'MyFavourites', context),
          Divider(thickness: 1),
          listTile(
              "Addresses", Icons.location_on_outlined, 'MyLocation', context),
          Divider(thickness: 1),
          listTile("History", Icons.access_time_outlined, 'myHistory', context),
          Divider(thickness: 1),
          listTile("Settings", Icons.settings, 'settings', context),
          Divider(thickness: 1),
          ListTile(
            onTap: LogoutFun,
            title: Text(
              "Log out",
              style: TextStyle(fontSize: 25,color: Colors.red),
            ),
            leading: Icon(
              Icons.logout,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
