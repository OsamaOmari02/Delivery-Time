import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  ListTile listTile(String title, icon, route, BuildContext ctx) {
    return ListTile(
      onTap: () => Navigator.of(ctx).pushReplacementNamed(route),
      title: Text(
        title,
        style: TextStyle(fontSize: 25),
      ),
      leading: Icon(icon),
    );
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset('file/wallpaperflare.com_wallpaper.jpg'),
            padding: EdgeInsets.all(0),
          ),
          Row(
            children: [
              SizedBox(width: width*0.1),
              Text('welcome .... !', style: TextStyle(fontSize: 21)),
            ],
          ),
          listTile("Home page", Icons.home, 'MyHomepage', context),
          Divider(thickness: 1),
          listTile("My account", Icons.account_circle, 'MyAccount', context),
          Divider(thickness: 1),
          listTile("My favourites", Icons.favorite, 'MyFavourites', context),
          Divider(thickness: 1),
          listTile(
              "My Address", Icons.location_on_outlined, 'MyLocation', context),
          Divider(thickness: 1),
          listTile("Settings", Icons.settings, 'settings', context),
          Divider(thickness: 1),
          listTile("Log out", Icons.logout, 'logout', context),
        ],
      ),
    );
  }
}
