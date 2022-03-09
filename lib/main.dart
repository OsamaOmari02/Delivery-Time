// @dart=2.9

import 'dart:developer';

import 'package:app/Myaccount_screen.dart';
import 'package:app/Myfavourites_screen.dart';
import 'package:app/Myprovider.dart';
import 'package:app/Settings.dart';
import 'package:app/mo3ajanat.dart';
import 'package:app/pizzaScreen.dart';
import 'package:app/rice.dart';
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

import 'AddOrRemoveRes.dart';
import 'Addaddress.dart';
import 'CheckOut.dart';
import 'DPEdit.dart';
import 'Details.dart';
import 'DetailsHistory.dart';
import 'Discount.dart';
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
import 'cukurScreen.dart';
import 'drinks.dart';
import 'drinks_screen.dart';
import 'editRes.dart';
import 'homos.dart';

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
    Provider.of<LanProvider>(context, listen: false).getLanguage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UserState(),
      themeMode: Provider.of<MyProvider>(context).isDark
          ? ThemeMode.dark
          : ThemeMode.light,
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.orangeAccent),
        brightness: Brightness.light,
        canvasColor: Colors.white,
        floatingActionButtonTheme:
            FloatingActionButtonThemeData(backgroundColor: Colors.blue), accentColor: Colors.orangeAccent,
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
        // 'homosScreen': (context) => HomosScreen(),
        'sweets': (context) => Sweets(),
        'sweetScreen': (context) => SweetScreen(),
        'shawarma': (context) => Shawarma(),
        'shawarmaScreen': (context) => ShawarmaScreen(),
        'drinks': (context) => Drinks(),
        'drinksScreen': (context) => DrinksScreen(),
        'resScreen': (context) => MainResScreen(),
        'pizzaScreen': (context) => PizzaScreen(),
        'riceScreen': (context) => RiceScreen(),
        'mo3ajanatScreen': (context) => Mo3ajanatScreen(),
        'milkScreen': (context) => MilkScreen(),
        'callCenter': (context) => CallCenter(),
        'details': (context) => Details(),
        'location': (context) => Locations(),
        'detailsHistory': (context) => DetailsHistory(),
        'editRes': (context) => EditRes(),
        'editDP': (context) => DPEdit(),
        'addOrRemoveRes': (context) => AddOrRemoveRes(),
        'discount': (context) => Discount(),
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
    if (Provider.of<MyProvider>(context, listen: false).authData['name'] !=
            null ||
        Provider.of<MyProvider>(context, listen: false).authData['name'] != '')
      Provider.of<MyProvider>(context, listen: false).fetch();
    Provider.of<MyProvider>(context, listen: false).fetchAddress();
    super.initState();
  }

  double width;
  double height;

  getWidth() => width = MediaQuery.of(context).size.width;
  getHeight() => height = MediaQuery.of(context).size.height;

  Widget funImage(image, title) {
    return ListTile(
      onTap: () {
        setState(() {
          Provider.of<MyProvider>(context, listen: false).restaurantName =
              title;
        });
        if (Provider.of<MyProvider>(context, listen: false).restaurantName ==
                'بيتزا المفرق' ||
            Provider.of<MyProvider>(context, listen: false).restaurantName ==
                'بيتزا اونلاين')
          Navigator.of(context).pushNamed('pizzaScreen');
        else if (Provider.of<MyProvider>(context, listen: false)
                .restaurantName ==
            'ارزه لبنان' || Provider.of<MyProvider>(context, listen: false)
            .restaurantName ==
            'معجنات ورد')
          Navigator.of(context).pushNamed('mo3ajanatScreen');
        else if (Provider.of<MyProvider>(context, listen: false)
                    .restaurantName ==
                'قايد حضر موت' ||
            Provider.of<MyProvider>(context, listen: false).restaurantName ==
                'بوابة حضر موت')
          Navigator.of(context).pushNamed('riceScreen');
        else if (Provider.of<MyProvider>(context, listen: false)
                    .restaurantName ==
                'الدويري' )
          Navigator.of(context).pushNamed('shawarmaScreen');
        else
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
            fontSize: width * 0.042,
            fontWeight: FontWeight.bold,
            color: Provider.of<MyProvider>(context).isDark
                ? Colors.white
                : Colors.black,
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
              child: Text(
                  Provider.of<LanProvider>(context, listen: false).texts(title),
                  style: TextStyle(
                      color: Provider.of<MyProvider>(context).isDark
                          ? Colors.white
                          : Colors.black,
                      fontSize: width * 0.042),
                  textAlign: TextAlign.center),
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    Future<bool> _onWillPop() async {
      return (await showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              title: new Text(
                  Provider.of<LanProvider>(context, listen: false)
                      .texts('Do you want to exit an App'),
                  textDirection: Provider.of<LanProvider>(context).isEn
                      ? TextDirection.ltr
                      : TextDirection.rtl,
                  style: const TextStyle(fontSize: 21)),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: new Text(
                    Provider.of<LanProvider>(context, listen: false)
                        .texts('yes?'),
                    textDirection: Provider.of<LanProvider>(context).isEn
                        ? TextDirection.ltr
                        : TextDirection.rtl,
                    style: const TextStyle(fontSize: 17, color: Colors.red),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: new Text(
                    Provider.of<LanProvider>(context, listen: false)
                        .texts('cancel?'),
                    textDirection: Provider.of<LanProvider>(context).isEn
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
      textDirection: Provider.of<LanProvider>(context).isEn
          ? TextDirection.ltr
          : TextDirection.rtl,
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
                  if (Provider.of<MyProvider>(context).myCart.length != 0)
                    CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.red,
                        child: Text(
                          Provider.of<MyProvider>(context)
                              .myCart
                              .length
                              .toString(),
                          style: const TextStyle(color: Colors.white),
                        )),
                ]),
              ),
            ],
            centerTitle: true,
            title: Text(Provider.of<LanProvider>(context, listen: false)
                .texts('Drawer1')),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              try {
                setState(() {
                  Provider.of<MyProvider>(context, listen: false).isLoading =
                      true;
                });
                await Provider.of<MyProvider>(context, listen: false)
                    .sendLocationToDB(context);
                setState(() {
                  Provider.of<MyProvider>(context, listen: false).isLoading =
                      false;
                });
              } catch (e) {
                setState(() {
                  Provider.of<MyProvider>(context, listen: false).isLoading =
                      false;
                });
                Fluttertoast.showToast(
                    msg: Provider.of<LanProvider>(context, listen: false)
                        .texts('Error occurred !'),
                    toastLength: Toast.LENGTH_SHORT,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
                print(e);
              }
            },
            child: !Provider.of<MyProvider>(context, listen: false).isLoading
                ? Icon(Icons.my_location)
                : CircularProgressIndicator(),
            backgroundColor: Theme.of(context).colorScheme.secondary,
          ),
          body: Container(
            // height: height,
            alignment: Alignment.center,
            child: ListView(
              shrinkWrap: true,
              children: [
                SizedBox(
                  height: getHeight() * 0.3,
                  width: double.infinity,
                  child: Carousel(
                    images: <Widget>[
                      Image.asset(
                          Provider.of<MyProvider>(context, listen: false)
                              .imageFun[0],
                          fit: BoxFit.cover),
                      Image.asset(
                          Provider.of<MyProvider>(context, listen: false)
                              .imageFun[1],
                          fit: BoxFit.cover),
                      Image.asset(
                          Provider.of<MyProvider>(context, listen: false)
                              .imageFun[2],
                          fit: BoxFit.fill),
                      Image.asset(
                          Provider.of<MyProvider>(context, listen: false)
                              .imageFun[3],
                          fit: BoxFit.fill),
                    ],
                    dotColor: Colors.white,
                    dotSize: 5,
                    dotSpacing: 20,
                    dotIncreasedColor: Colors.black,
                    showIndicator: true,
                    autoplayDuration: const Duration(seconds: 2),
                  ),
                ),
                SizedBox(height: getHeight() * 0.03),
                Row(
                  children: [
                    SizedBox(width: getWidth() * 0.03),
                    Expanded(
                      child: Text(
                        Provider.of<LanProvider>(context, listen: false)
                            .texts('order ur food..'),
                        maxLines: 3,
                        style: TextStyle(
                            fontSize: getWidth() * 0.06,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: getHeight() * 0.02),
                Container(
                  height: getHeight() * 0.24,
                  width: double.infinity,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      content('file/shawarmah.jpg', "Shawarma & snacks",
                          'shawarma'),
                      content('file/3f48b82e3140f7c0.jpg', "hummus & falafel",
                          'homos'),
                      // content('file/pizza.jpg', "pizza", 'pizza'),
                      content('file/unknoswn.png', "Sweets", 'sweets'),
                      content('file/مشروب.jpg', "drinks", 'drinks'),
                    ],
                  ),
                ),
                const Divider(thickness: 1),
                Row(
                  children: [
                    SizedBox(width: getWidth() * 0.03),
                    Expanded(
                      child: Text(
                        Provider.of<LanProvider>(context, listen: false)
                            .texts('choose ur..'),
                        maxLines: 2,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: getWidth() * 0.06),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: getHeight() * 0.02),
                Container(
                  height: shortestSide < 650
                      ? getHeight() * 1.17
                      : getHeight() * 0.82,
                  child: GridView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: shortestSide < 700 ? 220 : 300,
                      mainAxisSpacing: shortestSide < 700 ? 25 : 50,
                      crossAxisSpacing: 1,
                      childAspectRatio: shortestSide < 700 ? 1.5 : 1,
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
