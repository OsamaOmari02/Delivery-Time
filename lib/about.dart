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
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var lanProvider = Provider.of<LanProvider>(context);
    void _launchURL(url) async =>
        !await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
    return Directionality(
      textDirection: lanProvider.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          title: Text(lanProvider.texts('about')),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(height: height*0.1),
            Text(
              lanProvider.texts('hello'),
              style: TextStyle(
                  fontSize: width*0.044, wordSpacing: 2, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: height*0.015),
            Text(lanProvider.texts('If you face'),style: TextStyle(
              fontSize: width*0.033)),
            SizedBox(height: height*0.08),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Material(
              color: Colors.white,
              child: Center(
                child: Ink(
                  decoration: const ShapeDecoration(
                    color: Colors.blueAccent,
                    shape: CircleBorder(),
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
                SizedBox(width: width*0.15),
                Material(
                  color: Colors.white,
                  child: Center(
                    child: Ink(
                      decoration: const ShapeDecoration(
                        color: Colors.red,
                        shape: CircleBorder(),
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
            SizedBox(height: height*0.4),
            Text("Developed by: Osama Bassam Omari",style: TextStyle(color: Colors.grey)),
          ]),
        ),
      ),
    );
  }
}
