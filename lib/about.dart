import 'package:app/Drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'LanguageProvider.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {

  double? width;
  double? height;

  getWidth() => width = MediaQuery.of(context).size.width;
  getHeight() => height = MediaQuery.of(context).size.height;

  @override
  Widget build(BuildContext context) {
    Future<bool> _onWillPop() async {
      await Navigator.of(context).pushReplacementNamed('MyHomepage');
      throw "";
    }
    return Directionality(
      textDirection:  Provider.of<LanProvider>(context).isEn ? TextDirection.ltr : TextDirection.rtl,
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          drawer: MyDrawer(),
          appBar: AppBar(
            title: Text( Provider.of<LanProvider>(context,listen: false).texts('about')),
            centerTitle: true,
            backgroundColor: Colors.blue,
          ),
          body: Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(height: getHeight()*0.1),
              Text(
                Provider.of<LanProvider>(context,listen: false).texts('hello'),
                style: TextStyle(
                    fontSize: getWidth()*0.044, wordSpacing: 2, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: getHeight()*0.015),
              Text( Provider.of<LanProvider>(context,listen: false).texts('If you face'),style: TextStyle(
                fontSize: getWidth()*0.033)),
              SizedBox(height: getHeight()*0.08),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Material(
                child: Center(
                  child: Ink(
                    decoration: const ShapeDecoration(
                      color: Colors.blueAccent,
                      shape: const CircleBorder(),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.facebook),
                      color: Colors.white,
                      onPressed: ()=>
                        launch("https://www.facebook.com/osama.omarii02"),
                    ),
                  ),
                ),
              ),
                  SizedBox(width: getWidth()*0.15),
                  Material(
                    child: Center(
                      child: Ink(
                        decoration: const ShapeDecoration(
                          color: Colors.red,
                          shape: const CircleBorder(),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.email),
                          color: Colors.white,
                          onPressed: ()=>
                              launch('mailto:osama.omarii02@gmail.com?subject=&body='),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
