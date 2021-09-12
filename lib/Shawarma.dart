
import 'package:app/LanguageProvider.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Myprovider.dart';

class Shawarma extends StatefulWidget {

  @override
  _ShawarmaState createState() => _ShawarmaState();
}

class _ShawarmaState extends State<Shawarma> {
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
          Navigator.of(context).pushNamed('resScreen');
        },
        title: Image.asset(
          image,
          height: height * 0.14,
          fit: BoxFit.fill,
        ),
        subtitle: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Text(title,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center),
        ),
      );
    }


    return Directionality(
      textDirection: lanProvider.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(lanProvider.texts('Shawarma & snacks')),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            SizedBox(
              height: height * 0.3,
              width: double.infinity,
              child: Container(
                child: Image.asset('file/shawarmah.jpg', fit: BoxFit.fill),
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
              height: height * 0.6,
              child: Scrollbar(
                child: GridView(
                  gridDelegate:
                  const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 220,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 2,
                    childAspectRatio: 3 / 2,
                  ),
                  children: [
                    funImage(
                        'file/grill_house.jpg', "Grill House"),
                    funImage(
                        'file/snap_burger.jpg', "Snap Burger"),
                    funImage('file/بيان سناك.jpg', "بيان سناك"),
                    funImage('file/شاورما الاشاره.jpg', "شاورما الإشارة"),
                    funImage('file/grill_house.jpg', "هم هم بشاير"),
                    funImage('file/grill_house.jpg', "جيت بوئتك"),
                    funImage('file/شاورما هنية.jpg', "شاورما هنية"),
                    funImage('file/اسطنبولي.jpg', "اسطنبولي"),
                    funImage('file/grill_house.jpg', "المأكولات الشامية"),
                    funImage('file/يزن الشامي.jpg', "يزن الشامي"),
                    funImage('file/مطاعم رؤى.jpg', "مطاعم رؤى"),
                    funImage('file/زين صاج.jpg', "زين صاج"),
                    funImage('file/grill_house.jpg', "بغداد"),
                    funImage('file/grill_house.jpg', "شامخ"),
                    funImage('file/فوانيس يزن.jpg', "فوانيس يزن"),
                    funImage('file/grill_house.jpg', "الوقفي"),
                    funImage('file/grill_house.jpg', "بوابة دمشق"),
                    funImage('file/شاورما عون.jpg', "مطعم عون"),
                    funImage('file/grill_house.jpg', "لوزان"),
                    funImage('file/سيتشن ون.jpg', "station one"),
                    funImage('file/غير شكل.jpg', "غير شكل"),
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
