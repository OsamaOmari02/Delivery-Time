// @dart=2.9

import 'dart:developer';

import 'package:app/Myaccount_screen.dart';
import 'package:app/Myfavourites_screen.dart';
import 'package:app/Myprovider.dart';
import 'package:app/Settings.dart';
import 'package:app/shawarma_screen.dart';
import 'package:app/sweets.dart';
import 'package:app/sweets_screen.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'Addaddress.dart';
import 'CheckOut.dart';
import 'Details.dart';
import 'DetailsHistory.dart';
import 'Drawer.dart';
import 'LanguageProvider.dart';
import 'Location.dart';
import 'LogIn.dart';
import 'MyHistory.dart';
import 'Myaddress.dart';
import 'PassWord.dart';
import 'ResScreen.dart';
import 'ResetPassword.dart';
import 'Shawarma.dart';
import 'Shopping_cart.dart';
import 'SignUp.dart';
import 'UserState.dart';
import 'about.dart';
import 'callCenter.dart';
import 'drinks.dart';
import 'drinks_screen.dart';
import 'homos.dart';
import 'homos_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<MyProvider>(create: (_) => MyProvider()),
      ChangeNotifierProvider<LanProvider>(create: (_) => LanProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    Provider.of<MyProvider>(context, listen: false).getDarkMode();
    Provider.of<MyProvider>(context, listen: false).getAdmin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UserState(),
      themeMode: provider.isDark ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.orangeAccent),
        brightness: Brightness.light,
        accentColor: Colors.orangeAccent,
        canvasColor: Colors.white,
        floatingActionButtonTheme:
            FloatingActionButtonThemeData(backgroundColor: Colors.blue),
      ),
      darkTheme:
          ThemeData(brightness: Brightness.dark, accentColor: Colors.white),
      routes: {
        'MyHomepage': (context) => MyHomepage(),
        'Signup': (context) => Register(),
        'login': (context) => Login(),
        'MyAccount': (context) => MyAccount(),
        'MyFavourites': (context) => MyFavourites(),
        'MyLocation': (context) => MyAddress(),
        'settings': (context) => SettingsScreen(),
        'password': (context) => MyPassword(),
        'resetPassword': (context) => ResetPassword(),
        'Shopping': (context) => Shopping(),
        'myHistory': (context) => History(),
        'addAddress': (context) => AddAddress(),
        'Email': (context) => Email(),
        'Name': (context) => Name(),
        'about': (context) => About(),
        'userState': (context) => UserState(),
        'checkOut': (context) => CheckOut(),
        'homos': (context) => Homos(),
        'homosScreen': (context) => HomosScreen(),
        'sweets': (context) => Sweets(),
        'sweetScreen': (context) => SweetScreen(),
        'shawarma': (context) => Shawarma(),
        'shawarmaScreen': (context) => ShawarmaScreen(),
        'drinks': (context) => Drinks(),
        'drinksScreen': (context) => DrinksScreen(),
        'resScreen': (context) => MainResScreen(),
        'callCenter': (context) => CallCenter(),
        'details': (context) => Details(),
        'location': (context) => Locations(),
        'detailsHistory': (context) => DetailsHistory(),
      },
    );
  }
}

class MyHomepage extends StatefulWidget {
  @override
  _MyHomepageState createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomepage> {
  @override
  void initState() {
    Provider.of<LanProvider>(context, listen: false).getLanguage();
    if (Provider.of<MyProvider>(context, listen: false).authData['name']!=null
    || Provider.of<MyProvider>(context, listen: false).authData['name']!='')
        Provider.of<MyProvider>(context, listen: false).fetch();
    Provider.of<MyProvider>(context, listen: false).fetchAddress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    var provider = Provider.of<MyProvider>(context);
    var lanProvider = Provider.of<LanProvider>(context);

    Widget funImage(image, title) {
      return ListTile(
        onTap: () {
          setState(() {
            provider.restaurantName = title;
          });
          Navigator.of(context).pushNamed('resScreen');
        },
        title: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image.asset(
            image,
            height: height * 0.13,
            fit: BoxFit.fill,
          ),
        ),
        subtitle: Text(title,
            style: TextStyle(
              fontSize: width*0.042,
              fontWeight: FontWeight.bold,
              color: provider.isDark ? Colors.white : Colors.black,
            ),
            textAlign: TextAlign.center),
      );
    }

    Widget content(image, String title, route) {
      return Container(
          width: width * 0.44,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 1.5,
            child: ListTile(
              onTap: () => Navigator.of(context).pushNamed(route),
              title: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.asset(
                  image,
                  height: height * 0.13,
                  fit: BoxFit.fill,
                ),
              ),
              subtitle: Container(
                padding: EdgeInsets.symmetric(vertical: height * 0.015),
                child: Text(lanProvider.texts(title),
                    style: TextStyle(
                        color: provider.isDark ? Colors.white : Colors.black,
                        fontSize: width * 0.042),
                    textAlign: TextAlign.center),
              ),
            ),
          ));
    }

    Future<bool> _onWillPop() async {
      return (await showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              title: new Text(
                lanProvider.texts('Do you want to exit an App'),
                textDirection:
                    lanProvider.isEn ? TextDirection.ltr : TextDirection.rtl,
                style: const TextStyle(fontSize: 21)
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: new Text(
                    lanProvider.texts('yes?'),
                    textDirection: lanProvider.isEn
                        ? TextDirection.ltr
                        : TextDirection.rtl,
                    style: const TextStyle(fontSize: 17,color: Colors.red),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: new Text(
                    lanProvider.texts('cancel?'),
                    textDirection: lanProvider.isEn
                        ? TextDirection.ltr
                        : TextDirection.rtl,
                    style: const TextStyle(fontSize: 17),
                  ),
                ),
              ],
            ),
          )) ??
          false;
    }

    return Directionality(
      textDirection: lanProvider.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          drawer: MyDrawer(),
          appBar: AppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.all(7.0),
                child: Stack(children: [
                  IconButton(
                      onPressed: () =>
                          Navigator.of(context).pushNamed('Shopping'),
                      icon: const Icon(Icons.shopping_cart)),
                  if (provider.myCart.length != 0)
                    CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.red,
                        child: Text(
                          provider.myCart.length.toString(),
                          style: const TextStyle(color: Colors.white),
                        )),
                ]),
              ),
            ],
            centerTitle: true,
            title: Text(lanProvider.texts('Drawer1')),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              try {
                setState(() {
                  provider.isLoading = true;
                });
                await provider.sendLocationToDB(context);
                setState(() {
                  provider.isLoading = false;
                });
              } catch (e) {
                setState(() {
                  provider.isLoading = false;
                });
                Fluttertoast.showToast(
                    msg: lanProvider.texts('Error occurred !'),
                    toastLength: Toast.LENGTH_SHORT,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
                print(e);
              }
            },
            child: !provider.isLoading
                ? Icon(Icons.my_location)
                : CircularProgressIndicator(),
            backgroundColor: Theme.of(context).accentColor,
          ),
          body: Container(
            // height: height,
            alignment: Alignment.center,
            child: ListView(
              shrinkWrap: true,
              children: [
                SizedBox(
                  height: height * 0.3,
                  width: double.infinity,
                  child: Carousel(
                    images: <Widget>[
                      Image.asset(provider.imageFun[0], fit: BoxFit.cover),
                      Image.asset(provider.imageFun[1], fit: BoxFit.cover),
                      Image.asset(provider.imageFun[2], fit: BoxFit.fill),
                      Image.asset(provider.imageFun[3], fit: BoxFit.fill),
                    ],
                    dotColor: Colors.white,
                    dotSize: 5,
                    dotSpacing: 20,
                    dotIncreasedColor: Colors.black,
                    showIndicator: true,
                    autoplayDuration: const Duration(seconds: 2),
                  ),
                ),
                SizedBox(height: height * 0.03),
                Row(
                  children: [
                    SizedBox(width: width * 0.03),
                    Expanded(
                      child: Text(
                        lanProvider.texts('order ur food..'),
                        maxLines: 3,
                        style: TextStyle(
                            fontSize: width * 0.06,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.02),
                Container(
                  height: height * 0.24,
                  width: double.infinity,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      content('file/shawarmah.jpg', "Shawarma & snacks",
                          'shawarma'),
                      content('file/3f48b82e3140f7c0.jpg', "homos & falafel",
                          'homos'),
                      content('file/unknoswn.png', "Sweets", 'sweets'),
                      content('file/مشروب.jpg', "drinks", 'drinks'),
                    ],
                  ),
                ),
                const Divider(thickness: 1),
                Row(
                  children: [
                    SizedBox(width: width * 0.03),
                    Expanded(
                      child: Text(
                        lanProvider.texts('choose ur..'),
                        maxLines: 2,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: width * 0.06),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.02),
                Container(
                  height: shortestSide<650?height * 1.17:height*0.82,
                  child: GridView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: shortestSide<700?220:300,
                      mainAxisSpacing: shortestSide<700?25:50,
                      crossAxisSpacing: 1,
                      childAspectRatio: shortestSide<700?1.5:1,
                    ),
                    children: [
                      funImage('file/معجنات ورد.png', "معجنات ورد"),
                      // funImage('file/بيتزا هوم.jpg', "بيتزا هوم"),
                      funImage('file/قايد حضر موت.jpg', "قايد حضر موت"),
                      funImage('file/ارزه لبنان.jpg', "ارزه لبنان"),
                      // funImage('file/الغزاوي.jpg', "الرائد الغزاوي"),
                      funImage('file/دلع_كرشك.jpg', "دلع كرشك"),
                      funImage('file/بيتزا المفرق.jpg', "بيتزا المفرق"),
                      funImage('file/بوابة حضر موت.jpg', "بوابة حضر موت"),
                      funImage('file/بيتزا اونلاين.jpg', "بيتزا اونلاين"),
                      funImage('file/ابو جمال.jpg', "مطعم ابو جمال"),
                      funImage('file/ابو هشهش.jpg', "ابو هشهش"),
                      funImage('file/الدويري.jpg', "الدويري"),
                      // funImage('file/ابو قاسم.jpg', "ابو قاسم"),
                      // funImage('file/السلطان إبراهيم.jpg', "السلطان إبراهيم"),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
