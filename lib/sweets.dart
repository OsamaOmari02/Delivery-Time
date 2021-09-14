import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'LanguageProvider.dart';
import 'Myprovider.dart';

class Sweets extends StatefulWidget {

  @override
  _SweetsState createState() => _SweetsState();
}

class _SweetsState extends State<Sweets> {
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
          Navigator.of(context).pushNamed('sweetScreen');
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
          title: Text(lanProvider.texts('Sweets')),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            SizedBox(
              height: height * 0.3,
              width: double.infinity,
              child: Container(
                child: Image.asset(provider.imageFun[2], fit: BoxFit.cover),
              ),
            ),
            SizedBox(height: height * 0.03),
            Row(
              children: [
                SizedBox(width: width * 0.03),
                Expanded(
                  child: Text(
                    lanProvider.texts('choose ur sweet'),
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
                        'file/نفيسة.jpg', "نفيسة"),
                    funImage(
                        'file/الصالون الاخضر سوق.jpg', "الصالون الأخضر-السوق"),
                    funImage(
                        'file/الصالون الاخضر.jpg', "الصالون الأخضر-شويكة"),
                    funImage('file/مارشميلو كيك.jpg', "مارشميلو كيك"),
                    funImage('file/angel.jpg', "آنجل"),
                    funImage('file/كارمن كيك.jpg', "كارمن كيك"),
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
