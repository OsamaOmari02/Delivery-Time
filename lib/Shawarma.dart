
import 'package:app/LanguageProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Myprovider.dart';

class Shawarma extends StatefulWidget {

  @override
  _ShawarmaState createState() => _ShawarmaState();
}

class _ShawarmaState extends State<Shawarma> {

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
        Navigator.of(context).pushNamed('shawarmaScreen');
      },
      title: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Image.asset(
          image,
          height: getHeight() * 0.135,
          fit: BoxFit.fill,
        ),
      ),
      subtitle: Text(title,
          style: TextStyle(
              color: Provider.of<MyProvider>(context).isDark? Colors.white:Colors.black,
              fontSize: getWidth()*0.042,
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center),
    );
  }
  @override
  Widget build(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;

    AppBar appBar =  AppBar(
      title: Text(Provider.of<LanProvider>(context,listen: false).texts('Shawarma & snacks')),
      centerTitle: true,
    );

    return Directionality(
      textDirection: Provider.of<LanProvider>(context).isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: appBar,
        body: Scrollbar(
          child: Container(
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
                    funImage(
                        'file/grill_house.jpg', "Grill House"),
                    funImage('file/snap_burger.jpg', "Snap Burger"),
                    funImage('file/بيان سناك.jpg', "بيان سناك"),
                    funImage('file/سيتشن ون.jpg', "station one"),
                    funImage('file/هم هم.jpg', "هم هم بشاير"),
                    funImage('file/جيت بوئتك.jpg', "جيت بوئتك"),
                    funImage('file/شاورما هنية.jpg', "شاورما هنية"),
                    funImage('file/الإشارة.jpg', "شاورما الإشارة"),
                    // funImage('file/اسطنبولي.jpg', "اسطنبولي"),
                    funImage('file/الماكولات الشاميه.jpg', "المأكولات الشامية"),
                    funImage('file/يزن الشامي.jpg', "يزن الشامي"),
                    // funImage('file/مطاعم رؤى.jpg', "مطاعم رؤى"),
                    // funImage('file/زين صاج.jpg', "زين صاج"),
                    funImage('file/بغداد.jpg', "بغداد"),
                    // funImage('file/شامخ.jpg', "شامخ"),
                    // funImage('file/فوانيس يزن.jpg', "فوانيس يزن"),
                    funImage('file/الوقفي.jpg', "الوقفي"),
                    funImage('file/بوابة دمشق.jpg', "بوابة دمشق"),
                    funImage('file/شاورما عون.jpg', "مطعم عون"),
                    funImage('file/لوزان.jpg', "لوزان"),

                    // funImage('file/غير شكل.jpg', "غير شكل"),
                  ],
                ),
              )
        ),
        // bottomSheet: Container(height: height*0.01,),
      ),
    );
  }
}
