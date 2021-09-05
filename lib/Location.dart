import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(),
        drawer: Drawer(
          child: ListView(
            children: [
              listTile('صفحة الطلبات', Icons.home, 'callCenter', context),
              listTile('الموقع', Icons.location_on, 'location', context),
            ],
          ),
        ),
        body: null,
      ),
    );
  }
}
