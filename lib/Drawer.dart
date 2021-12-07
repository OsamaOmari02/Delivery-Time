
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
    double width = MediaQuery.of(context).size.width;
    dialog(title) {
      return showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return AlertDialog(
              title: Text(
                title,
                textAlign:  Provider.of<LanProvider>(context).isEn ? TextAlign.start : TextAlign.end,
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
                    child: Text( Provider.of<LanProvider>(context,listen: false).texts('ok'),
                        style: const TextStyle(fontSize: 19)),
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
                Provider.of<LanProvider>(context,listen: false).texts('log out?'),
                textAlign:  Provider.of<LanProvider>(context).isEn ? TextAlign.start : TextAlign.end,
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
                    Provider.of<LanProvider>(context,listen: false).texts('yes?'),
                    style: const TextStyle(fontSize: 19, color: Colors.red),
                  ),
                  onTap: () async{
                    try {
                      await FirebaseAuth.instance.signOut();
                      setState(() {
                        Provider.of<MyProvider>(context,listen: false).authState = authStatus.Authenticated;
                        Navigator.of(context).pushReplacementNamed('login');
                        Provider.of<MyProvider>(context,listen: false).authData.clear();
                        Provider.of<MyProvider>(context,listen: false).myFavorites.clear();
                        Provider.of<MyProvider>(context,listen: false).loc.clear();
                        Provider.of<MyProvider>(context,listen: false).mealIDs.clear();
                        Provider.of<MyProvider>(context,listen: false).myCart.clear();
                        Provider.of<MyProvider>(context,listen: false).details.clear();
                      });
                    } on FirebaseException catch (e){
                      dialog(e.message);
                      setState(() {
                        Provider.of<MyProvider>(context,listen: false).authState = authStatus.unAuthenticated;
                      });
                    } catch (e){
                      dialog( Provider.of<LanProvider>(context,listen: false).texts('Error occurred !'));
                      print(e);
                      setState(() {
                        Provider.of<MyProvider>(context,listen: false).authState = authStatus.unAuthenticated;
                      });
                    }
                  }
                ),
                const SizedBox(width: 11),
                InkWell(
                    child: Text( Provider.of<LanProvider>(context,listen: false).texts('cancel?'),
                        style: const TextStyle(fontSize: 19)),
                    onTap: () => Navigator.of(context).pop()),
              ],
            );
          });
    }

    return SafeArea(
      child: Directionality(
        textDirection:  Provider.of<LanProvider>(context).isEn ? TextDirection.ltr : TextDirection.rtl,
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
                padding: const EdgeInsets.all(0),
              ),
              Row(
                children: [
                  SizedBox(width: width * 0.03),
                  Expanded(
                      child: Text(
                        Provider.of<LanProvider>(context,listen: false).texts('welcome') +
                        ' ${Provider.of<MyProvider>(context,listen: false).authData['name']} !',
                    style: const TextStyle(fontSize: 21),
                  )),
                ],
              ),
              listTile( Provider.of<LanProvider>(context,listen: false).texts('Drawer1'), Icons.home, 'MyHomepage',
                  context),
              const Divider(thickness: 0.1,),
              listTile( Provider.of<LanProvider>(context,listen: false).texts('Drawer2'), Icons.account_circle,
                  'MyAccount', context),
              const Divider(thickness: 0.1,),
              ListTile(
                onTap: (){
                  Navigator.of(context).pushReplacementNamed('MyFavourites');
                },
                title: Text(
                  Provider.of<LanProvider>(context,listen: false).texts('Drawer3'),
                  style: const TextStyle(fontSize: 25),
                ),
                leading: const Icon(
                  Icons.favorite,
                  color: Colors.blueAccent,
                ),
              ),
              const Divider(thickness: 0.1,),
              listTile( Provider.of<LanProvider>(context,listen: false).texts('Drawer4'), Icons.location_on_outlined,
                  'MyLocation', context),
              const Divider(thickness: 0.1),
              listTile( Provider.of<LanProvider>(context,listen: false).texts('Drawer5'), Icons.access_time_outlined,
                  'myHistory', context),
              const Divider(thickness: 1.5),
              listTile( Provider.of<LanProvider>(context,listen: false).texts('Drawer6'), Icons.settings, 'settings',
                  context),
              const Divider(thickness: 0.1),
              listTile( Provider.of<LanProvider>(context,listen: false).texts('Drawer7'), Icons.error_outline, 'about',
                  context),
              const Divider(thickness: 0.1),
              ListTile(
                onTap: logOutFun,
                title: Text(
                  Provider.of<LanProvider>(context,listen: false).texts('Drawer8'),
                  style: const TextStyle(fontSize: 25, color: Colors.red),
                ),
                leading: const Icon(
                  Icons.logout,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
