// @dart=2.9
import 'package:app/Myaccount_screen.dart';
import 'package:app/Myfavourites_screen.dart';
import 'package:app/Myprovider.dart';
import 'package:app/Settings.dart';
import 'package:app/admin.dart';
import 'package:app/res_screen.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'Addaddress.dart';
import 'Drawer.dart';
import 'LanguageProvider.dart';
import 'LogIn.dart';
import 'Myaddress.dart';
import 'PassWord.dart';
import 'Shopping_cart.dart';
import 'MyHistory.dart';
import 'package:provider/provider.dart';

import 'SignUp.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MultiProvider(
      providers:[
        ChangeNotifierProvider<MyProvider>(create: (ctx)=>MyProvider()),
        ChangeNotifierProvider<LanProvider>(create: (ctx)=>LanProvider()),
      ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
      themeMode: Provider.of<MyProvider>(context).isDark?ThemeMode.dark:ThemeMode.light,
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.orangeAccent),
        brightness: Brightness.light,
        canvasColor: Colors.white,
        accentColor: Colors.orangeAccent,
        floatingActionButtonTheme:
            FloatingActionButtonThemeData(backgroundColor: Colors.blue),
      ),
      darkTheme: ThemeData(brightness: Brightness.dark),
      routes: {
        'MyHomepage': (context) => MyHomepage(),
        'Signup':(context)=>Register(),
        'login':(context)=>Login(),
        'MyAccount': (context) => MyAccount(),
        'MyFavourites': (context) => MyFavourites(),
        'MyLocation': (context) => MyAddress(),
        'settings': (context) => SettingsScreen(),
        'password': (context) => MyPassword(),
        'Shopping': (context) => Shopping(),
        'myHistory': (context) => History(),
        'addAddress': (context) => AddAddress(),
        'resScreen':(context)=>Store(),
        'Email':(context)=>Email(),
        'Name':(context)=>Name(),
        'admin':(context)=>Admin(),
        'edit':(context)=>Edit(),
        'addMeal':(context)=>AddMeal(),
        // 'Phone':(context)=>Phone(),
      },
    );
  }
}

class MyHomepage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var _provider = Provider.of<MyProvider>(context);
    var lanProvider = Provider.of<LanProvider>(context);
    content(image, title, Color color) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        child: ElevatedButton(
          onPressed: ()=> Navigator.of(context).pushNamed('resScreen'),
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white70)),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Image.asset(image,fit: BoxFit.fill),
              Text(
                title,
                style: TextStyle(
                    fontSize: 16, fontStyle: FontStyle.italic, color: color),
              ),
            ],
          ),
        ),
      );
    }
    Container funImage(route, String title) {
      return Container(
        width: width * 0.41,
        child: ListTile(
          title: Image.asset(
            route,
            height: height * 0.12,
            fit: BoxFit.fill,
          ),
          subtitle: Container(
            padding: EdgeInsets.symmetric(vertical: height * 0.015),
            child: Text(title,
                style: TextStyle(color: Colors.black, fontSize: 15),
                textAlign: TextAlign.center),
          ),
        ),
      );
    }

    return Directionality(
      textDirection: lanProvider.isEn?TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.search),
              ),
            )
          ],
          centerTitle: true,
          title: Text(lanProvider.texts('Drawer1')),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.of(context).pushNamed('Shopping'),
          child: Icon(Icons.shopping_basket_outlined),
          backgroundColor: Theme.of(context).accentColor,
        ),
        body: Container(
          alignment: Alignment.center,
          child: ListView(
            children: [
              SizedBox(
                height: height * 0.3,
                width: double.infinity,
                child: Carousel(
                  images: <Widget>[
                    Image.asset(_provider.imageFun[0], fit: BoxFit.cover),
                    Image.asset(_provider.imageFun[1], fit: BoxFit.cover),
                    Image.asset(_provider.imageFun[2], fit: BoxFit.cover),
                  ],
                  dotColor: Colors.white,
                  dotSize: 5,
                  dotSpacing: 20,
                  dotIncreasedColor: Colors.black,
                  showIndicator: true,
                  autoplayDuration: const Duration(seconds: 1, milliseconds: 600),
                ),
              ),
              SizedBox(height: height * 0.03),
              Row(
                children: [
                  SizedBox(
                    width: width * 0.03,
                  ),
                  Expanded(
                    child: Text(
                      lanProvider.texts('order ur food..'),
                      maxLines: 3,
                      style: TextStyle(
                          fontSize: width * 0.06, fontWeight: FontWeight.bold),
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
                    funImage('file/shawarmah.jpg', "Shawarmah"),
                    funImage('file/fahita.jpg', "Fahita"),
                    funImage('file/burger.jpg', "Burgers"),
                    funImage('file/grill_house.jpg', "Extra"),
                    funImage('file/دلع_كرشك.jpg', "Extra"),
                    funImage('file/snap_burger.jpg', "Extra"),
                  ],
                ),
              ),
              Divider(thickness: 1),
              Row(
                children: [
                  SizedBox(
                    width: width * 0.03,
                  ),
                  Expanded(
                    child: Text(
                      lanProvider.texts('choose ur..'),
                      maxLines: 2,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: width * 0.06),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.02),
              Container(
                padding: EdgeInsets.all(10),
                height: height * 0.6,
                child: Scrollbar(
                  child: GridView(
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 220,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 18,
                      childAspectRatio: 3 / 2,
                    ),
                    children: [
                      content('file/grill_house.jpg', "", Colors.black),
                      content('file/grill_house.jpg', "", Colors.black),
                      content('file/grill_house.jpg', "", Colors.black),
                      content('file/snap_burger.jpg', "", Colors.white),
                      content('file/grill_house.jpg', "", Colors.black),
                      content('file/grill_house.jpg', "", Colors.black),
                      content('file/grill_house.jpg', "", Colors.black),
                      content('file/دلع_كرشك.jpg', "", Colors.black),
                      content('file/grill_house.jpg', "", Colors.black),
                      content('file/grill_house.jpg', "", Colors.black),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
