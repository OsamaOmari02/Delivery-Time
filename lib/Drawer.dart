import 'dart:developer';
import 'dart:io';
import 'package:app/Myprovider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'LanguageProvider.dart';

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
    var lanProvider = Provider.of<LanProvider>(context);
    LogoutFun() {
      return showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return AlertDialog(
              title: Text(
                lanProvider.texts('log out?'),
                textAlign: lanProvider.isEn ? TextAlign.start : TextAlign.end,
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
                    lanProvider.texts('yes?'),
                    style: TextStyle(fontSize: 19, color: Colors.red),
                  ),
                  onTap: () async{
                    try {
                      await FirebaseAuth.instance.signOut();
                      setState(() {
                        provider.authState = authStatus.Authenticated;
                        Navigator.of(context).pushReplacementNamed('login');
                        Provider.of<MyProvider>(context,listen: false).authData.clear();
                        Provider.of<MyProvider>(context,listen: false).myFavorites.clear();
                        Provider.of<MyProvider>(context,listen: false).loc.clear();
                        Provider.of<MyProvider>(context,listen: false).mealIDs.clear();
                      });
                    }on FirebaseException catch (e){
                       print(e.message);
                      setState(() {
                        provider.authState = authStatus.unAuthenticated;
                      });
                    } catch (e){
                      print(e);
                      setState(() {
                        provider.authState = authStatus.unAuthenticated;
                      });
                    }
                  }
                ),
                const SizedBox(width: 11),
                InkWell(
                    child: Text(lanProvider.texts('cancel?'),
                        style: TextStyle(fontSize: 19)),
                    onTap: () => Navigator.of(context).pop()),
              ],
            );
          });
    }

    return Directionality(
      textDirection: lanProvider.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Drawer(
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
                Expanded(
                    child: Text(
                  lanProvider.texts('welcome') +
                      ' ${provider.authData['name']} !',
                  style: TextStyle(fontSize: 21),
                )),
              ],
            ),
            listTile(lanProvider.texts('Drawer1'), Icons.home, 'MyHomepage',
                context),
            Divider(thickness: 0.1,),
            listTile(lanProvider.texts('Drawer2'), Icons.account_circle,
                'MyAccount', context),
            Divider(thickness: 0.1,),
            ListTile(
              onTap: (){
                // await provider.fetchFav();
                Navigator.of(context).pushReplacementNamed('MyFavourites');
              },
              title: Text(
                lanProvider.texts('Drawer3'),
                style: TextStyle(fontSize: 25),
              ),
              leading: Icon(
                Icons.favorite,
                color: Colors.blueAccent,
              ),
            ),
            Divider(thickness: 0.1,),
            listTile(lanProvider.texts('Drawer4'), Icons.location_on_outlined,
                'MyLocation', context),
            Divider(thickness: 0.1),
            listTile(lanProvider.texts('Drawer5'), Icons.access_time_outlined,
                'myHistory', context),
            Divider(thickness: 1.5),
            listTile(lanProvider.texts('Drawer6'), Icons.settings, 'settings',
                context),
            Divider(thickness: 0.1),
            listTile(lanProvider.texts('Drawer7'), Icons.error_outline, 'about',
                context),
            Divider(thickness: 0.1),
            ListTile(
              onTap: LogoutFun,
              title: Text(
                lanProvider.texts('Drawer8'),
                style: TextStyle(fontSize: 25, color: Colors.red),
              ),
              leading: Icon(
                Icons.logout,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
