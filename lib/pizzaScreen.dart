import 'package:app/Myprovider.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'LanguageProvider.dart';

class PizzaScreen extends StatefulWidget {
  @override
  _PizzaScreenState createState() => _PizzaScreenState();
}

var tab1p;
var tab2p;
var tab3p;

class _PizzaScreenState extends State<PizzaScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      Provider.of<MyProvider>(context, listen: false).fetchMealsPizza(
          Provider.of<MyProvider>(context, listen: false).restaurantName);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Directionality(
      textDirection: Provider.of<LanProvider>(context).isEn
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: DefaultTabController(
        length:
            Provider.of<MyProvider>(context, listen: false).restaurantName ==
                    'بيتزا المفرق'
                ? 3
                : 2,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
                Provider.of<MyProvider>(context, listen: false).restaurantName),
            bottom: TabBar(
              tabs: [
                Tab(
                    text: Provider.of<LanProvider>(context, listen: false)
                        .texts('tabPizza')),
                if (Provider.of<MyProvider>(context, listen: false)
                        .restaurantName ==
                    'بيتزا المفرق')
                  Tab(
                      text: Provider.of<LanProvider>(context, listen: false)
                          .texts('tabPM')),
                Tab(
                    text: Provider.of<LanProvider>(context, listen: false)
                        .texts('tab3')),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            height: height * 0.095,
            child: Opacity(
              opacity: Provider.of<MyProvider>(context).total < 0.009 ? 0.4 : 1,
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
                        SizedBox(width: width * 0.02),
                        Text(
                          Provider.of<LanProvider>(context, listen: false)
                              .texts('food cart'),
                          style: const TextStyle(
                              fontSize: 17, color: Colors.white),
                        ),
                        Spacer(),
                        Text(
                          Provider.of<LanProvider>(context, listen: false)
                              .texts('total'),
                          style: const TextStyle(
                              fontSize: 17, color: Colors.white),
                        ),
                        Text(
                          " ${Provider.of<MyProvider>(context).total.toStringAsFixed(2) == "-0.00" ? 0.0 : Provider.of<MyProvider>(context).total.toStringAsFixed(2)}",
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                          child: Text(
                            Provider.of<LanProvider>(context, listen: false)
                                .texts('jd'),
                            style: const TextStyle(
                                fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              First(),
              if (Provider.of<MyProvider>(context, listen: false)
                      .restaurantName ==
                  'بيتزا المفرق')
                Second(),
              Third(),
            ],
          ),
        ),
      ),
    );
  }
}

//-------------------------------1-------------------------------
class First extends StatefulWidget {
  @override
  _FirstState createState() => _FirstState();
}

class _FirstState extends State<First> {
  @override
  void initState() {
    tab1p = FirebaseFirestore.instance
        .collection(
            '/Pizza/${Provider.of<MyProvider>(context, listen: false).restaurantName}/Pizza')
        .snapshots();
    super.initState();
  }

  bool checkBoxValue = false;

  Widget checkBox() {
    return CheckboxListTile(
      title: Text("title text"),
      value: checkBoxValue,
      onChanged: (newValue) {
        setState(() {
          checkBoxValue = newValue!;
        });
      },
      controlAffinity: ListTileControlAffinity.leading,
    );
  }

  bottomSheet() {
    return Directionality(
        textDirection: Provider.of<LanProvider>(context).isEn
            ? TextDirection.ltr
            : TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              Provider.of<LanProvider>(context, listen: false)
                  .texts('choose pizza'),
              style: TextStyle(
                  color: Provider.of<MyProvider>(context).isDark
                      ? CupertinoColors.white
                      : CupertinoColors.black,
                  fontWeight: FontWeight.bold),
            ),
            backgroundColor: Theme.of(context).canvasColor,
            elevation: 1,
          ),
          body: StatefulBuilder(builder:
              (BuildContext context, void Function(void Function()) setState) {
            return ListView.builder(
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return CheckboxListTile(
                  title: Text(Provider.of<MyProvider>(context).pizzaTypes[index].title),
                  value: checkBoxValue,
                  onChanged: (newValue) {
                    setState(() {
                      checkBoxValue = newValue!;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                );
              },
            );
          }),
        ));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    dialog(title) {
      return showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return Directionality(
              textDirection: Provider.of<LanProvider>(context).isEn
                  ? TextDirection.ltr
                  : TextDirection.rtl,
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
                        child: Text(
                            Provider.of<LanProvider>(context, listen: false)
                                .texts('cancel?'),
                            style: const TextStyle(
                                fontSize: 19, color: Colors.red)),
                        onTap: () => Navigator.of(context).pop()),
                  ),
                  const SizedBox(width: 11),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                        child: Text(
                            Provider.of<LanProvider>(context, listen: false)
                                .texts('yes?'),
                            style: const TextStyle(fontSize: 19)),
                        onPressed: () {
                          Provider.of<MyProvider>(context, listen: false)
                              .myCartClear();
                          Navigator.of(context).pop();
                        }),
                  ),
                ],
              ),
            );
          });
    }

    return StreamBuilder<QuerySnapshot>(
      stream: tab1p,
      builder: (ctx, snapshot) {
        if (snapshot.hasError)
          return Center(
              child: Text(Provider.of<LanProvider>(context, listen: false)
                  .texts('something went wrong !')));
        if (snapshot.connectionState == ConnectionState.waiting)
          return const Center(child: const CircularProgressIndicator());
        return Scrollbar(
          child: ListView.builder(
            itemCount: snapshot.data?.docs.length ?? 0,
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
                            if (resData[index]['imageUrl'] != "")
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                width: width * 0.24,
                                height: height * 0.16,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.fill,
                                    imageUrl: resData[index]['imageUrl'],
                                    placeholder: (context, url) => const Center(
                                        child:
                                            const CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
                              ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: height * 0.025),
                                SizedBox(
                                  width: width * 0.54,
                                  child: AutoSizeText(
                                    resData[index]['meal name'],
                                    maxLines: 2,
                                    minFontSize: 12,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                                SizedBox(height: height * 0.01),
                                SizedBox(
                                  width: width * 0.5,
                                  child: AutoSizeText(
                                    resData[index]['description'],
                                    maxLines: 3,
                                    minFontSize: 12,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 7),
                                    child: Text(
                                      Provider.of<LanProvider>(context,
                                                  listen: false)
                                              .texts('price') +
                                          " " +
                                          resData[index]['meal price'] +
                                          " " +
                                          Provider.of<LanProvider>(context,
                                                  listen: false)
                                              .texts('jd'),
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.pink),
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
                        if (Provider.of<MyProvider>(context, listen: false)
                            .isLoading)
                          const CircularProgressIndicator(),
                        if (!Provider.of<MyProvider>(context, listen: false)
                            .isLoading)
                          IconButton(
                            alignment: Alignment.topLeft,
                            icon: Icon(
                              Icons.local_pizza,
                              color: Colors.blue,
                            ),
                            onPressed: () async {
                              try {
                                setState(() {
                                  Provider.of<MyProvider>(context,
                                          listen: false)
                                      .isLoading = true;
                                  Provider.of<MyProvider>(context,
                                          listen: false)
                                      .mealID = resData[index].id;
                                });
                                showModalBottomSheet(
                                    context: context,
                                    builder: (_) => bottomSheet());
                                setState(() {
                                  Provider.of<MyProvider>(context,
                                          listen: false)
                                      .isLoading = false;
                                });
                              } on FirebaseException catch (e) {
                                setState(() {
                                  Provider.of<MyProvider>(context,
                                          listen: false)
                                      .isLoading = false;
                                });
                                dialog(e.message);
                                print(e.message);
                              } catch (e) {
                                setState(() {
                                  Provider.of<MyProvider>(context,
                                          listen: false)
                                      .isLoading = false;
                                });
                                dialog(Provider.of<LanProvider>(context,
                                        listen: false)
                                    .texts('Error occurred !'));
                                print(e);
                              }
                            },
                          ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 1.0),
                          child: TextButton(
                            child: Text(
                                Provider.of<LanProvider>(context, listen: false)
                                    .texts('choose pizza'),
                                style: TextStyle(
                                    fontSize: 14, color: Colors.blueAccent)),
                            onPressed: () {
                              try {
                                setState(() {
                                  Provider.of<MyProvider>(context,
                                          listen: false)
                                      .isLoading = true;
                                  Provider.of<MyProvider>(context,
                                          listen: false)
                                      .mealID = resData[index].id;
                                });
                                showModalBottomSheet(
                                    context: context,
                                    builder: (_) => bottomSheet());
                                setState(() {
                                  Provider.of<MyProvider>(context,
                                          listen: false)
                                      .isLoading = false;
                                });
                              } on FirebaseException catch (e) {
                                setState(() {
                                  Provider.of<MyProvider>(context,
                                          listen: false)
                                      .isLoading = false;
                                });
                                dialog(e.message);
                                print(e.message);
                              } catch (e) {
                                setState(() {
                                  Provider.of<MyProvider>(context,
                                          listen: false)
                                      .isLoading = false;
                                });
                                dialog(Provider.of<LanProvider>(context,
                                        listen: false)
                                    .texts('Error occurred !'));
                                print(e);
                              }
                            },
                          ),
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
    );
  }
}

//-----------------------2--------------------------
class Second extends StatefulWidget {
  @override
  _SecondState createState() => _SecondState();
}

class _SecondState extends State<Second> {
  @override
  void initState() {
    tab2p = FirebaseFirestore.instance
        .collection(
            '/Pizza/${Provider.of<MyProvider>(context, listen: false).restaurantName}/broasted')
        .snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    dialog(title) {
      return showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return AlertDialog(
              title: Text(
                title,
                textAlign: Provider.of<LanProvider>(context).isEn
                    ? TextAlign.start
                    : TextAlign.end,
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
                const SizedBox(width: 11),
                InkWell(
                    child: Text(
                        Provider.of<LanProvider>(context, listen: false)
                            .texts('ok'),
                        style: const TextStyle(fontSize: 19)),
                    onTap: () => Navigator.of(context).pop()),
              ],
            );
          });
    }

    return StreamBuilder<QuerySnapshot>(
      stream: tab2p,
      builder: (ctx, snapshot) {
        if (snapshot.hasError)
          return Center(
              child: Text(Provider.of<LanProvider>(context, listen: false)
                  .texts('something went wrong !')));
        if (snapshot.connectionState == ConnectionState.waiting)
          return const Center(child: const CircularProgressIndicator());
        return Scrollbar(
          child: ListView.builder(
            itemCount: snapshot.data?.docs.length ?? 0,
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
                            if (resData[index]['imageUrl'] != "")
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                width: width * 0.24,
                                height: height * 0.16,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.fill,
                                    imageUrl: resData[index]['imageUrl'],
                                    placeholder: (context, url) => const Center(
                                        child:
                                            const CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
                              ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: height * 0.025),
                                SizedBox(
                                  width: width * 0.54,
                                  child: AutoSizeText(
                                    resData[index]['meal name'],
                                    maxLines: 2,
                                    minFontSize: 12,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                                SizedBox(height: height * 0.01),
                                SizedBox(
                                  width: width * 0.5,
                                  child: AutoSizeText(
                                    resData[index]['description'],
                                    maxLines: 3,
                                    minFontSize: 12,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 7),
                                    child: Text(
                                      Provider.of<LanProvider>(context,
                                                  listen: false)
                                              .texts('price') +
                                          " " +
                                          resData[index]['meal price'] +
                                          " " +
                                          Provider.of<LanProvider>(context,
                                                  listen: false)
                                              .texts('jd'),
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.pink),
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
                        if (Provider.of<MyProvider>(context, listen: false)
                            .isLoading)
                          const CircularProgressIndicator(),
                        if (!Provider.of<MyProvider>(context, listen: false)
                            .isLoading)
                          IconButton(
                            alignment: Alignment.topLeft,
                            icon: Icon(
                              Provider.of<MyProvider>(context, listen: false)
                                      .isMyFav(resData[index].id)
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.red,
                            ),
                            onPressed: () async {
                              try {
                                setState(() {
                                  Provider.of<MyProvider>(context,
                                          listen: false)
                                      .isLoading = true;
                                  Provider.of<MyProvider>(context,
                                          listen: false)
                                      .mealID = resData[index].id;
                                });
                                await Provider.of<MyProvider>(context,
                                        listen: false)
                                    .toggleFavourite();
                                setState(() {
                                  Provider.of<MyProvider>(context,
                                          listen: false)
                                      .isLoading = false;
                                });
                              } on FirebaseException catch (e) {
                                setState(() {
                                  Provider.of<MyProvider>(context,
                                          listen: false)
                                      .isLoading = false;
                                });
                                dialog(e.message);
                                print(e.message);
                              } catch (e) {
                                setState(() {
                                  Provider.of<MyProvider>(context,
                                          listen: false)
                                      .isLoading = false;
                                });
                                dialog(Provider.of<LanProvider>(context,
                                        listen: false)
                                    .texts('Error occurred !'));
                                print(e);
                              }
                            },
                          ),
                        // Row(
                        //   children: [
                        //     Text(Provider.of<MyProvider>(context,listen: false).getIndex(resData[index].id) == -1
                        //         ? "0"
                        //         : (Provider.of<MyProvider>(context,listen: false)
                        //         .myCart[Provider.of<MyProvider>(context,listen: false)
                        //         .getIndex(resData[index].id)]
                        //         .quantity)
                        //         .toString()),
                        //     IconButton(
                        //         icon: const Icon(
                        //           Icons.add,
                        //           color: Colors.green,
                        //         ),
                        //         onPressed: () async {
                        //           setState(() {
                        //             Provider.of<MyProvider>(context,listen: false).mealID = resData[index].id;
                        //           });
                        //           if (Provider.of<MyProvider>(context,listen: false).myCart.length != 0 &&
                        //               Provider.of<MyProvider>(context,listen: false).restaurantName !=
                        //                   Provider.of<MyProvider>(context,listen: false).myCart[0].resName)
                        //             return dialog(
                        //                 Provider.of<LanProvider>(context,listen: false).texts('foodCart'));
                        //           Provider.of<MyProvider>(context,listen: false).addFoodCart(
                        //               resData[index]['meal name'],
                        //               resData[index]['meal price'],resData[index]['description']);
                        //         }),
                        //   ],
                        // ),
                        // Provider.of<MyProvider>(context,listen: false).existsInCart(resData[index].id)
                        //     ? IconButton(
                        //   icon: const Icon(
                        //     Icons.remove,
                        //     color: Colors.red,
                        //   ),
                        //   onPressed: () async {
                        //     setState(() {
                        //       Provider.of<MyProvider>(context,listen: false).mealID = resData[index].id;
                        //     });
                        //     await Provider.of<MyProvider>(context,listen: false).removeFoodCart(resData[index]['meal price']);
                        //   },
                        // )
                        //     : Container(),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}

//-----------------------------3-----------------------
class Third extends StatefulWidget {
  @override
  _ThirdState createState() => _ThirdState();
}

class _ThirdState extends State<Third> {
  @override
  void initState() {
    tab3p = FirebaseFirestore.instance
        .collection(
            '/Pizza/${Provider.of<MyProvider>(context, listen: false).restaurantName}/others')
        .snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    dialog(title) {
      return showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return AlertDialog(
              title: Text(
                title,
                textAlign: Provider.of<LanProvider>(context).isEn
                    ? TextAlign.start
                    : TextAlign.end,
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
                const SizedBox(width: 11),
                InkWell(
                    child: Text(
                        Provider.of<LanProvider>(context, listen: false)
                            .texts('ok'),
                        style: const TextStyle(fontSize: 19)),
                    onTap: () => Navigator.of(context).pop()),
              ],
            );
          });
    }

    return StreamBuilder<QuerySnapshot>(
      stream: tab3p,
      builder: (ctx, snapshot) {
        if (snapshot.hasError)
          return Center(
              child: Text(Provider.of<LanProvider>(context, listen: false)
                  .texts('something went wrong !')));
        if (snapshot.connectionState == ConnectionState.waiting)
          return const Center(child: const CircularProgressIndicator());
        return Scrollbar(
          child: ListView.builder(
            itemCount: snapshot.data?.docs.length ?? 0,
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
                            if (resData[index]['imageUrl'] != "")
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                width: width * 0.24,
                                height: height * 0.16,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.fill,
                                    imageUrl: resData[index]['imageUrl'],
                                    placeholder: (context, url) => const Center(
                                        child:
                                            const CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
                              ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: height * 0.025),
                                SizedBox(
                                  width: width * 0.54,
                                  child: AutoSizeText(
                                    resData[index]['meal name'],
                                    maxLines: 2,
                                    minFontSize: 12,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                                SizedBox(height: height * 0.01),
                                SizedBox(
                                  width: width * 0.5,
                                  child: AutoSizeText(
                                    resData[index]['description'],
                                    maxLines: 3,
                                    minFontSize: 12,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 7),
                                    child: Text(
                                      Provider.of<LanProvider>(context,
                                                  listen: false)
                                              .texts('price') +
                                          " " +
                                          resData[index]['meal price'] +
                                          " " +
                                          Provider.of<LanProvider>(context,
                                                  listen: false)
                                              .texts('jd'),
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.pink),
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
                        if (Provider.of<MyProvider>(context, listen: false)
                            .isLoading)
                          const CircularProgressIndicator(),
                        if (!Provider.of<MyProvider>(context, listen: false)
                            .isLoading)
                          IconButton(
                            alignment: Alignment.topLeft,
                            icon: Icon(
                              Provider.of<MyProvider>(context, listen: false)
                                      .isMyFav(resData[index].id)
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.red,
                            ),
                            onPressed: () async {
                              try {
                                setState(() {
                                  Provider.of<MyProvider>(context,
                                          listen: false)
                                      .isLoading = true;
                                  Provider.of<MyProvider>(context,
                                          listen: false)
                                      .mealID = resData[index].id;
                                });
                                await Provider.of<MyProvider>(context,
                                        listen: false)
                                    .toggleFavourite();
                                setState(() {
                                  Provider.of<MyProvider>(context,
                                          listen: false)
                                      .isLoading = false;
                                });
                              } on FirebaseException catch (e) {
                                setState(() {
                                  Provider.of<MyProvider>(context,
                                          listen: false)
                                      .isLoading = false;
                                });
                                dialog(e.message);
                                print(e.message);
                              } catch (e) {
                                setState(() {
                                  Provider.of<MyProvider>(context,
                                          listen: false)
                                      .isLoading = false;
                                });
                                dialog(Provider.of<LanProvider>(context,
                                        listen: false)
                                    .texts('Error occurred !'));
                                print(e);
                              }
                            },
                          ),
                        // Row(
                        //   children: [
                        //     Text(Provider.of<MyProvider>(context,listen: false).getIndex(resData[index].id) == -1
                        //         ? "0"
                        //         : (Provider.of<MyProvider>(context,listen: false)
                        //         .myCart[Provider.of<MyProvider>(context,listen: false)
                        //         .getIndex(resData[index].id)]
                        //         .quantity)
                        //         .toString()),
                        //     IconButton(
                        //         icon: const Icon(
                        //           Icons.add,
                        //           color: Colors.green,
                        //         ),
                        //         onPressed: () async {
                        //           setState(() {
                        //             Provider.of<MyProvider>(context,listen: false).mealID = resData[index].id;
                        //           });
                        //           if (Provider.of<MyProvider>(context,listen: false).myCart.length != 0 &&
                        //               Provider.of<MyProvider>(context,listen: false).restaurantName !=
                        //                   Provider.of<MyProvider>(context,listen: false).myCart[0].resName)
                        //             return dialog(
                        //                 Provider.of<LanProvider>(context,listen: false).texts('foodCart'));
                        //           Provider.of<MyProvider>(context,listen: false).addFoodCart(
                        //               resData[index]['meal name'],
                        //               resData[index]['meal price'],resData[index]['description']);
                        //         }),
                        //   ],
                        // ),
                        // Provider.of<MyProvider>(context,listen: false).existsInCart(resData[index].id)
                        //     ? IconButton(
                        //   icon: const Icon(
                        //     Icons.remove,
                        //     color: Colors.red,
                        //   ),
                        //   onPressed: () async {
                        //     setState(() {
                        //       Provider.of<MyProvider>(context,listen: false).mealID = resData[index].id;
                        //     });
                        //     await Provider.of<MyProvider>(context,listen: false).removeFoodCart(resData[index]['meal price']);
                        //   },
                        // )
                        //     : Container(),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
