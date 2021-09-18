
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
    double height = MediaQuery.of(context).size.height;
    var provider = Provider.of<MyProvider>(context);
    var lanProvider = Provider.of<LanProvider>(context);
    dialog(title) {
      return showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return AlertDialog(
              title: Text(
                title,
                textAlign: lanProvider.isEn ? TextAlign.start : TextAlign.end,
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
                    child: Text(lanProvider.texts('ok'),
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
                lanProvider.texts('log out?'),
                textAlign: lanProvider.isEn ? TextAlign.start : TextAlign.end,
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
                    lanProvider.texts('yes?'),
                    style: const TextStyle(fontSize: 19, color: Colors.red),
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
                        Provider.of<MyProvider>(context,listen: false).myCart.clear();
                        Provider.of<MyProvider>(context,listen: false).details.clear();
                      });
                    } on FirebaseException catch (e){
                      dialog(e.message);
                      setState(() {
                        provider.authState = authStatus.unAuthenticated;
                      });
                    } catch (e){
                      dialog(lanProvider.texts('Error occurred !'));
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
                        style: const TextStyle(fontSize: 19)),
                    onTap: () => Navigator.of(context).pop()),
              ],
            );
          });
    }

    return SafeArea(
      child: Directionality(
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
                padding: const EdgeInsets.all(0),
              ),
              Row(
                children: [
                  SizedBox(width: width * 0.03),
                  Expanded(
                      child: Text(
                    lanProvider.texts('welcome') +
                        ' ${provider.authData['name']} !',
                    style: const TextStyle(fontSize: 21),
                  )),
                ],
              ),
              listTile(lanProvider.texts('Drawer1'), Icons.home, 'MyHomepage',
                  context),
              const Divider(thickness: 0.1,),
              listTile(lanProvider.texts('Drawer2'), Icons.account_circle,
                  'MyAccount', context),
              const Divider(thickness: 0.1,),
              ListTile(
                onTap: (){
                  Navigator.of(context).pushReplacementNamed('MyFavourites');
                },
                title: Text(
                  lanProvider.texts('Drawer3'),
                  style: const TextStyle(fontSize: 25),
                ),
                leading: const Icon(
                  Icons.favorite,
                  color: Colors.blueAccent,
                ),
              ),
              const Divider(thickness: 0.1,),
              listTile(lanProvider.texts('Drawer4'), Icons.location_on_outlined,
                  'MyLocation', context),
              const Divider(thickness: 0.1),
              listTile(lanProvider.texts('Drawer5'), Icons.access_time_outlined,
                  'myHistory', context),
              const Divider(thickness: 1.5),
              listTile(lanProvider.texts('Drawer6'), Icons.settings, 'settings',
                  context),
              const Divider(thickness: 0.1),
              listTile(lanProvider.texts('Drawer7'), Icons.error_outline, 'about',
                  context),
              const Divider(thickness: 0.1),
              ListTile(
                onTap: logOutFun,
                title: Text(
                  lanProvider.texts('Drawer8'),
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
