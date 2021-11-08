import 'package:app/Myprovider.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'LanguageProvider.dart';

class MainResScreen extends StatefulWidget {
  @override
  _MainResScreenState createState() => _MainResScreenState();
}

class _MainResScreenState extends State<MainResScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      Provider.of<MyProvider>(context, listen: false).fetchMealsMain(
          Provider.of<MyProvider>(context, listen: false).restaurantName);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var provider = Provider.of<MyProvider>(context);
    var lanProvider = Provider.of<LanProvider>(context);
    dialog(title) {
      return showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return Directionality(
              textDirection:
              lanProvider.isEn ? TextDirection.ltr : TextDirection.rtl,
              child: AlertDialog(
                title: Text(
                  title,
                  style: const TextStyle(fontSize: 23),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 7),
                elevation: 24,
                content: Container(
                  height: 30,
                  child: const Divider(),
                  alignment: Alignment.topCenter,
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                        child: Text(lanProvider.texts('cancel?'),
                            style: const TextStyle(
                                fontSize: 19, color: Colors.red)),
                        onTap: () => Navigator.of(context).pop()),
                  ),
                  const SizedBox(width: 11),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                        child: Text(lanProvider.texts('yes?'),
                            style: const TextStyle(fontSize: 19)),
                        onPressed: () {
                          provider.myCartClear();
                          Navigator.of(context).pop();
                        }),
                  ),
                ],
              ),
            );
          });
    }

    return Directionality(
      textDirection: lanProvider.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(centerTitle: true, title: Text(provider.restaurantName)),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('/mainRes/${provider.restaurantName}/meals')
              .snapshots(),
          builder: (ctx, snapshot) {
            // if (snapshot.connectionState == ConnectionState.waiting)
            //   return Center(child: const CircularProgressIndicator());
            if (snapshot.hasError)
              return Center(
                  child: Text(lanProvider.texts('something went wrong !')));
            return Scrollbar(
              child: ListView.builder(
                itemCount: snapshot.data?.docs.length??0,
                itemBuilder: (context, int index) {
                  var resData = snapshot.data!.docs;
                  return Card(
                    elevation: 3,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: Container(
                            child: Row(
                              children: [
                                if (resData[index]['imageUrl']!="")
                                  Container(
                                    padding: const EdgeInsets.all(3),
                                    width: width*0.24,
                                    height: height*0.16,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: CachedNetworkImage(
                                        fit: BoxFit.fill,
                                        imageUrl: resData[index]['imageUrl'],
                                        placeholder: (context, url) => const Center(child: const CircularProgressIndicator()),
                                        errorWidget: (context, url, error) => const Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(height: height*0.025),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6),
                                      child: Text(
                                        resData[index]['meal name'],
                                        style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w800),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    SizedBox(
                                      width: width*0.4,
                                      child: AutoSizeText(
                                        resData[index]['description'],
                                        maxLines: 3,
                                        minFontSize: 12,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 7),
                                      alignment: Alignment.bottomLeft,
                                      margin: const EdgeInsets.only(top: 16),
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.symmetric(vertical: 7),
                                        child: Text(
                                          lanProvider.texts('price') +
                                              " " +
                                              resData[index]['meal price'] +
                                              " " +
                                              lanProvider.texts('jd'),
                                          style: const TextStyle(
                                              fontSize: 15, color: Colors.pink),
                                        ),
                                      ),
                                    ),
                                    // SizedBox(height: 50),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            if (provider.isLoading)
                              const CircularProgressIndicator(),
                            if (!provider.isLoading)
                              IconButton(
                                alignment: Alignment.topLeft,
                                icon: Icon(
                                  provider.isMyFav(resData[index].id)
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: Colors.red,
                                ),
                                onPressed: () async {
                                  try {
                                    setState(() {
                                      provider.isLoading = true;
                                      provider.mealID = resData[index].id;
                                    });
                                    await provider.toggleFavourite();
                                    setState(() {
                                      provider.isLoading = false;
                                    });
                                  } on FirebaseException catch (e) {
                                    setState(() {
                                      provider.isLoading = false;
                                    });
                                    dialog(e.message);
                                    print(e.message);
                                  } catch (e) {
                                    setState(() {
                                      provider.isLoading = false;
                                    });
                                    dialog(lanProvider
                                        .texts('Error occurred !'));
                                    print(e);
                                  }
                                },
                              ),
                            Row(
                              children: [
                                provider.existsInCart(resData[index].id)
                                    ? IconButton(
                                  icon: const Icon(
                                    Icons.remove,
                                    color: Colors.red,
                                  ),
                                  onPressed: () async {
                                    setState(() {
                                      provider.mealID = resData[index].id;
                                    });
                                    await provider.removeFoodCart(resData[index]['meal price']);
                                  },
                                )
                                    : Container(),
                                Text(provider.getIndex(resData[index].id) == -1
                                    ? "0"
                                    : (provider
                                    .myCart[provider
                                    .getIndex(resData[index].id)]
                                    .quantity)
                                    .toString()),
                                IconButton(
                                    icon: const Icon(
                                      Icons.add,
                                      color: Colors.green,
                                    ),
                                    onPressed: () async {
                                      setState(() {
                                        provider.mealID = resData[index].id;
                                      });
                                      if (provider.myCart.length != 0 &&
                                          provider.restaurantName !=
                                              provider.myCart[0].resName)
                                        return dialog(
                                            lanProvider.texts('foodCart'));
                                      provider.addFoodCart(
                                          resData[index]['meal name'],
                                          resData[index]['meal price'],resData[index]['description']);
                                    }),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
        bottomNavigationBar: Container(
          height: height*0.1,
          child: Opacity(
            opacity: provider.total == 0 ? 0.4 : 1,
            child: Container(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 15),
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 4,
                    primary: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () =>
                      Navigator.of(context).pushReplacementNamed('Shopping'),
                  child: Row(
                    children: <Widget>[
                      const Icon(
                        Icons.shopping_basket_outlined,
                        color: Colors.white,
                      ),
                      SizedBox(width: width*0.02),
                      Text(
                        lanProvider.texts('food cart'),
                        style: const TextStyle(
                            fontSize: 17, color: Colors.white),
                      ),
                      Spacer(),
                      Text(
                        lanProvider.texts('total'),
                        style: const TextStyle(
                            fontSize: 17, color: Colors.white),
                      ),
                      Text(
                        " ${provider.total} ",
                        style: const TextStyle(
                            fontSize: 16, color: Colors.white),
                      ),
                      Text(
                        lanProvider.texts('jd'),
                        style: const TextStyle(
                            fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
