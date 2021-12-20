import 'package:app/LanguageProvider.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Myprovider.dart';

class Drinks extends StatefulWidget {
  @override
  _DrinksState createState() => _DrinksState();
}

class _DrinksState extends State<Drinks> {

  double? width;
  double? height;

  getWidth() => width = MediaQuery.of(context).size.width;
  getHeight() => height = MediaQuery.of(context).size.height;
  Widget funImage(image, title) {
    return ListTile(
      onTap: () {
        setState(() {
          Provider.of<MyProvider>(context,listen: false).restaurantName = title;
        });
        Provider.of<MyProvider>(context,listen: false).restaurantName=='الحفرة' ||Provider.of<MyProvider>(context,listen: false).restaurantName=='لبناني الشمال' ?
        Navigator.of(context).pushNamed('milkScreen'):
        Navigator.of(context).pushNamed('drinksScreen');
      },
      title: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Image.asset(
          image,
          height: getHeight() * 0.14,
          fit: BoxFit.fill,
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Text(title,
            style: TextStyle(
                color: Provider.of<MyProvider>(context).isDark? Colors.white:Colors.black,
                fontSize: getWidth()*0.042,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    return Directionality(
      textDirection:  Provider.of<LanProvider>(context).isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text( Provider.of<LanProvider>(context,listen: false).texts('drinks')),
          centerTitle: true,
        ),
        body: Container(
          height: getHeight()*1.1,
          padding: EdgeInsets.fromLTRB(2, 20, 2, 0),
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
                    funImage('file/لبناني الشمال.jpg', "لبناني الشمال"),
                    funImage('file/الحفره.jpg', "الحفرة"),
                    // funImage('file/شريان.jpg', "شريان"),
                    funImage('file/تريند.jpg', "ترند"),
                  ],
                ),
              ),
      ),
    );
  }
}
