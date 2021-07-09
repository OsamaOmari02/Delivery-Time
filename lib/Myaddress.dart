
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Drawer.dart';

class MyAddress extends StatefulWidget {
  const MyAddress({Key? key}) : super(key: key);

  @override
  _MyAddressState createState() => _MyAddressState();
}

class _MyAddressState extends State<MyAddress> {


  listTile(areaName, stName, int mobile) {
    return Column(
      children: [
        ListTile(
          onTap: () {},
          title: Text(areaName),
          subtitle: Text("Street : $stName\nMobile : $mobile"),
          isThreeLine: true,
        ),
        Divider(thickness: 1),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: ()=>Navigator.of(context).pushNamed('addAddress'),
          ),
        ],
        title: Text("My Addresses"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          SizedBox(height: 3),
          listTile("area name...", "ahmad street", 078925388999),
          listTile("area 1name...", "ali street", 078925435643),
        ],
      ),
    );
  }
}

