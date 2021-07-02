import 'package:app/Logout.dart';
import 'package:app/Myaccount_screen.dart';
import 'package:app/Myfavourites_screen.dart';
import 'package:app/Settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'Drawer.dart';
import 'Myaddress.dart';
import 'PassWord.dart';

void main() => runApp(Myhome());

class Myhome extends StatefulWidget {
  @override
  _MyhomeState createState() => _MyhomeState();
}

class _MyhomeState extends State<Myhome> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.orangeAccent),
        canvasColor: Colors.white,
        accentColor: Colors.green,
        floatingActionButtonTheme:
            FloatingActionButtonThemeData(backgroundColor: Colors.blue),
      ),
      darkTheme: ThemeData(canvasColor: Colors.black),
      home: MyHomepage(),
      routes: {
        'MyHomepage': (context) => MyHomepage(),
        'MyAccount': (context) => MyAccount(),
        'MyFavourites': (context) => MyFavourites(),
        'MyLocation': (context) => MyAddress(),
        'settings': (context) => Settings(),
        'logout': (context) => Logout(),
        'password': (context) => MyPassword(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomepage extends StatefulWidget {
  @override
  _MyHomepageState createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomepage> {




  content(Color color, title) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: color,
      ),
      child: Center(
          child: Text(
        title,
        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    Container funImage(route,String title){
      return Container(
        width: width*0.4,
        child: ListTile(
          title: Image.asset(route,height: height*0.18,),
          subtitle: Container(
            // height: height*0.3,
            child: Text(title,style: TextStyle(color: Colors.lightBlue), textAlign: TextAlign.center),
          ),
        ),
      );
    }

    List imageFun=[
      'file/wallpaperflare.com_wallpaper.jpg',
      'file/wallpaperflare.com_wallpaper (1).jpg',
      'file/wallpaperflare.com_wallpaper (2).jpg'
    ];
    var _currentIndex;
    Container funDot(i){
      return  Container(
        width: 10,
        height: 10,
        margin: EdgeInsets.symmetric(horizontal: 3),
        decoration: BoxDecoration(
          color: _currentIndex==i? Colors.blueAccent : Colors.grey,
          shape: BoxShape.circle,
        ),
      );
    }
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.search),
          )
        ],
        centerTitle: true,
        title: Text('Home page'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: ListView(
          children: [
            SizedBox(
              height: height * 0.3,
              width: double.infinity,
              child: CarouselSlider(
                items: <Widget>[
                  Image.asset(imageFun[0], fit: BoxFit.cover),
                  Image.asset(imageFun[1], fit: BoxFit.cover),
                  Image.asset(imageFun[2], fit: BoxFit.cover),
                ],
                options: CarouselOptions(
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 1,milliseconds: 750),
                  enlargeCenterPage : true,
                  disableCenter : true,
                  onPageChanged:(index ,_){
                    setState(() {
                      _currentIndex = index;
                    });
                    },
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment:MainAxisAlignment.center,
              children: [
                funDot(0),
                funDot(1),
                funDot(2),
              ],
            ),
            Container(
              height: height*0.25,
              width: double.infinity,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  funImage('file/wallpaperflare.com_wallpaper.jpg',"osama"),
                  funImage('file/wallpaperflare.com_wallpaper.jpg',"osama"),
                  funImage('file/wallpaperflare.com_wallpaper.jpg',"osama"),
                  funImage('file/wallpaperflare.com_wallpaper.jpg',"osama"),
                  funImage('file/wallpaperflare.com_wallpaper.jpg',"osama"),
                  funImage('file/wallpaperflare.com_wallpaper.jpg',"osama"),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              height: height * 0.6,
              child: GridView(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 220,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 3 / 2,
                ),
                children: [
                  content(Colors.red, "res1"),
                  content(Colors.blue, "res2"),
                  content(Colors.yellow, "res3"),
                  content(Colors.amber, "res4"),
                  content(Colors.deepPurple, "res5"),
                  content(Colors.blueGrey, "res6"),
                  content(Colors.green, "res7"),
                  content(Colors.red, "res8"),
                  content(Colors.pink, "res9"),
                  content(Colors.purple, "res10"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
