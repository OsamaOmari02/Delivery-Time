import 'package:app/LanguageProvider.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Myprovider.dart';

class Homos extends StatefulWidget {
  @override
  _HomosState createState() => _HomosState();
}

class _HomosState extends State<Homos> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var provider = Provider.of<MyProvider>(context);
    var lanProvider = Provider.of<LanProvider>(context);

    Widget funImage(image, title) {
      return ListTile(
        onTap: () {
          setState(() {
            provider.restaurantName = title;
          });
          Navigator.of(context).pushNamed('homosScreen');
        },
        title: Image.asset(
          image,
          height: height * 0.14,
          fit: BoxFit.fill,
        ),
        subtitle: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Text(title,
              style: TextStyle(
                  color: provider.isDark? Colors.white:Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center),
        ),
      );
    }

    return Directionality(
      textDirection: lanProvider.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(lanProvider.texts('homos & falafel')),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            SizedBox(
              height: height * 0.28,
              width: double.infinity,
              child: Container(
                child: Image.asset(provider.imageFun[1], fit: BoxFit.cover),
              ),
            ),
            SizedBox(height: height * 0.03),
            Row(
              children: [
                SizedBox(width: width * 0.03),
                Expanded(
                  child: Text(
                    lanProvider.texts('choose ur..'),
                    maxLines: 2,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: width * 0.055),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(10),
              height: height * 0.5,
              child: Scrollbar(
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 220,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 3,
                    childAspectRatio: 3 / 2,
                  ),
                  children: [
                    funImage('file/هون وبس.jpg', "هون وبس"),
                    // funImage('file/زورونا.jpg', "زورونا"),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
