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
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    Widget funImage(image, title) {
      return ListTile(
        onTap: () {
          setState(() {
            Provider.of<MyProvider>(context,listen: false).restaurantName = title;
          });
          Navigator.of(context).pushNamed('homosScreen');
        },
        title: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image.asset(
            image,
            height: height * 0.14,
            fit: BoxFit.fill,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Text(title,
              style: TextStyle(
                  color: Provider.of<MyProvider>(context,listen: false).isDark? Colors.white:Colors.black,
                  fontSize: width*0.042,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center),
        ),
      );
    }

    return Directionality(
      textDirection:  Provider.of<LanProvider>(context,listen: false).isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text( Provider.of<LanProvider>(context,listen: false).texts('homos & falafel')),
          centerTitle: true,
        ),
        body: Container(
          height: height*1.1,
          padding: EdgeInsets.fromLTRB(2, 20, 2, 0),
          child: Scrollbar(
            child: GridView(
              shrinkWrap: true,
              // physics: const NeverScrollableScrollPhysics(),
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: shortestSide<650?2:3,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                childAspectRatio: shortestSide<700?1.2:1,
              ),
                  children: [
                    funImage('file/هون وبس.jpg', "هون وبس"),
                    // funImage('file/زورونا.jpg', "زورونا"),
                  ],
                ),
              ),
        ),
      ),
    );
  }
}
