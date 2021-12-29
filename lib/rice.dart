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

class RiceScreen extends StatefulWidget {
  @override
  _RiceScreenState createState() => _RiceScreenState();
}

var tab1p;
var tab2p;
var tab3p;


class _RiceScreenState extends State<RiceScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      Provider.of<MyProvider>(context, listen: false).fetchMealsRice(
          Provider.of<MyProvider>(context, listen: false).restaurantName);
    });
    super.initState();
  }

  double? width;
  double? height;

  getWidth() => width = MediaQuery.of(context).size.width;

  getHeight() => height = MediaQuery.of(context).size.height;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: Provider.of<LanProvider>(context).isEn
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: DefaultTabController(
        length:
            Provider.of<MyProvider>(context, listen: false).restaurantName ==
                        'قايد حضر موت' ||
                    Provider.of<MyProvider>(context, listen: false)
                            .restaurantName ==
                        'بوابة حضر موت'
                ? 3
                : 2,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
                Provider.of<MyProvider>(context, listen: false).restaurantName),
            bottom: TabBar(
              labelPadding:EdgeInsets.symmetric(horizontal: getWidth()*0.08),
              isScrollable: true,
              tabs: [
                if (Provider.of<MyProvider>(context, listen: false)
                            .restaurantName ==
                        'قايد حضر موت' ||
                    Provider.of<MyProvider>(context, listen: false)
                            .restaurantName ==
                        'بوابة حضر موت')
                  Tab(
                      text: Provider.of<LanProvider>(context, listen: false)
                          .texts('tabRice')),
                Tab(
                    text: Provider.of<LanProvider>(context, listen: false)
                        .texts('tabRice2')),
                Tab(
                    text: Provider.of<LanProvider>(context, listen: false)
                        .texts('tab3')),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            height: getHeight() * 0.095,
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
                        SizedBox(width: getWidth() * 0.02),
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
              if (Provider.of<MyProvider>(context, listen: false)
                          .restaurantName ==
                      'قايد حضر موت' ||
                  Provider.of<MyProvider>(context, listen: false)
                          .restaurantName ==
                      'بوابة حضر موت')
                First(),
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
            '/rice/${Provider.of<MyProvider>(context, listen: false).restaurantName}/riceTypes').orderBy("meal name")
        .snapshots();
    super.initState();
  }

  int _counter = 0;
  double _price = 0.00;

  Widget radioListType1(index,setState) {
    return RadioListTile(
      value: Provider.of<MyProvider>(context).riceTypes[index].value,
      groupValue: Provider.of<MyProvider>(context).radioValue,
      onChanged: (val) {
        setState(() {
          Provider.of<MyProvider>(context, listen: false).radioValue = val!;
        });
      },
      title: Text(Provider.of<MyProvider>(context).riceTypes[index].title),
    );
  } // قايد حضر موت

  Widget radioListType2(index,setState) {
    return RadioListTile(
      value: Provider.of<MyProvider>(context).riceTypes1[index].value,
      groupValue: Provider.of<MyProvider>(context).radioValue1,
      onChanged: (val) {
        setState(() {
          Provider.of<MyProvider>(context, listen: false).radioValue1 = val!;
        });
      },
      title: Text(Provider.of<MyProvider>(context).riceTypes1[index].title),
    );
  } // بوابة حضر موت

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
            elevation: 2,
          ),
          body: Scrollbar(
            child: StatefulBuilder(builder: (BuildContext context,
                void Function(void Function()) setState) {
              return ListView.builder(
                itemCount: Provider.of<MyProvider>(context, listen: false)
                            .restaurantName ==
                        'قايد حضر موت'
                    ? Provider.of<MyProvider>(context).riceTypes.length
                    : Provider.of<MyProvider>(context).riceTypes1.length,
                itemBuilder: (BuildContext context, int index) {
                  return  Provider.of<MyProvider>(context, listen: false)
                      .restaurantName ==
                      'قايد حضر موت'
                      ? radioListType1(index,setState):radioListType2(index,setState);
                },
              );
            }),
          ),
          bottomNavigationBar: StatefulBuilder(builder:
              (BuildContext context, void Function(void Function()) setState) {
            return Container(
              height: getWidth() * 0.2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                      Provider.of<LanProvider>(context, listen: false)
                              .texts('total') +
                          ' ${_price.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 15)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _counter != 0
                          ? IconButton(
                              icon: const Icon(
                                Icons.remove,
                                color: Colors.red,
                              ),
                              onPressed: () async {
                                setState(() {
                                  _counter--;
                                  _price -= Provider.of<MyProvider>(context,
                                              listen: false)
                                          .mealPrice ??
                                      0;
                                });
                              },
                            )
                          : Container(),
                      Text(_counter.toString()),
                      IconButton(
                          icon: const Icon(
                            Icons.add,
                            color: Colors.green,
                          ),
                          onPressed: () {
                            if (Provider.of<MyProvider>(context,
                                listen: false)
                                .myCart
                                .length !=
                                0 &&
                                Provider.of<MyProvider>(context,
                                    listen: false)
                                    .restaurantName !=
                                    Provider.of<MyProvider>(context,
                                        listen: false)
                                        .myCart[0]
                                        .resName)
                              return dialog1(Provider.of<LanProvider>(
                                  context,
                                  listen: false)
                                  .texts('foodCart'));
                            setState(() {
                              _counter++;
                              _price += Provider.of<MyProvider>(context,
                                          listen: false)
                                      .mealPrice ??
                                  0;
                            });
                          }),
                    ],
                  ),
                  _counter != 0
                      ? TextButton(
                          child: Text(
                              Provider.of<LanProvider>(context, listen: false)
                                  .texts('add')),
                          onPressed: () {
                            Provider.of<MyProvider>(context, listen: false)
                                .addFoodCartRadio(_counter);
                            setState(() {
                              _price = 0.00;
                              _counter = 0;
                              Provider.of<MyProvider>(context, listen: false)
                                  .radioValue = null;
                              Provider.of<MyProvider>(context, listen: false)
                                  .radioValue1 = null;
                            });
                            Navigator.of(context).pop();
                          })
                      : Container(),
                ],
              ),
            );
          }),
        ));
  }

  dialog1(title) {
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
                          style:
                              const TextStyle(fontSize: 19, color: Colors.red)),
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
  dialog2(title) {
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
  double? width;
  double? height;

  getWidth() => width = MediaQuery.of(context).size.width;

  getHeight() => height = MediaQuery.of(context).size.height;

  @override
  Widget build(BuildContext context) {
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
                                width: getWidth() * 0.21,
                                height: getHeight() * 0.14,
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
                                SizedBox(height: getHeight() * 0.025),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  width: getWidth() * 0.54,
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
                                SizedBox(height: getHeight() * 0.01),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  width: getWidth() * 0.51,
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
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 7),
                                  alignment: Alignment.bottomLeft,
                                  margin: const EdgeInsets.only(top: 16),
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
                                      style: TextStyle(
                                          fontSize: 15,
                                          color:
                                              Provider.of<MyProvider>(context)
                                                      .isDark
                                                  ? Colors.white70
                                                  : Colors.pink),
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
                            icon: Icon(
                              Icons.restaurant,
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
                                  Provider.of<MyProvider>(context,
                                              listen: false)
                                          .mealPrice =
                                      double.parse(
                                          resData[index]['meal price']);
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
                                dialog2(e.message);
                                print(e.message);
                              } catch (e) {
                                setState(() {
                                  Provider.of<MyProvider>(context,
                                          listen: false)
                                      .isLoading = false;
                                });
                                dialog2(Provider.of<LanProvider>(context,
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
                                  Provider.of<MyProvider>(context,
                                              listen: false)
                                          .mealPrice =
                                      double.parse(
                                          resData[index]['meal price']);
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
                                dialog2(e.message);
                                print(e.message);
                              } catch (e) {
                                setState(() {
                                  Provider.of<MyProvider>(context,
                                          listen: false)
                                      .isLoading = false;
                                });
                                dialog2(Provider.of<LanProvider>(context,
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
            '/rice/${Provider.of<MyProvider>(context, listen: false).restaurantName}/rice').orderBy("meal name")
        .snapshots();
    super.initState();
  }

  double? width;
  double? height;

  getWidth() => width = MediaQuery.of(context).size.width;

  getHeight() => height = MediaQuery.of(context).size.height;

  dialog1(title) {
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
  dialog2(title) {
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
  @override
  Widget build(BuildContext context) {
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
                                width: getWidth() * 0.21,
                                height: getHeight() * 0.14,
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
                                SizedBox(height: getHeight() * 0.025),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  width: getWidth() * 0.54,
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
                                SizedBox(height: getHeight() * 0.01),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  width: getWidth() * 0.51,
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
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 7),
                                  alignment: Alignment.bottomLeft,
                                  margin: const EdgeInsets.only(top: 16),
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
                                      style: TextStyle(
                                          fontSize: 15,
                                          color:
                                              Provider.of<MyProvider>(context)
                                                      .isDark
                                                  ? Colors.white70
                                                  : Colors.pink),
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
                                dialog2(e.message);
                                print(e.message);
                              } catch (e) {
                                setState(() {
                                  Provider.of<MyProvider>(context,
                                          listen: false)
                                      .isLoading = false;
                                });
                                dialog2(Provider.of<LanProvider>(context,
                                        listen: false)
                                    .texts('Error occurred !'));
                                print(e);
                              }
                            },
                          ),
                        Row(
                          children: [
                            Text(Provider.of<MyProvider>(context, listen: false)
                                        .getIndex(resData[index].id) ==
                                    -1
                                ? "0"
                                : (Provider.of<MyProvider>(context,
                                            listen: false)
                                        .myCart[Provider.of<MyProvider>(context,
                                                listen: false)
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
                                    Provider.of<MyProvider>(context,
                                            listen: false)
                                        .mealID = resData[index].id;
                                  });
                                  if (Provider.of<MyProvider>(context,
                                                  listen: false)
                                              .myCart
                                              .length !=
                                          0 &&
                                      Provider.of<MyProvider>(context,
                                                  listen: false)
                                              .restaurantName !=
                                          Provider.of<MyProvider>(context,
                                                  listen: false)
                                              .myCart[0]
                                              .resName)
                                    return dialog1(Provider.of<LanProvider>(
                                            context,
                                            listen: false)
                                        .texts('foodCart'));
                                  Provider.of<MyProvider>(context,
                                          listen: false)
                                      .addFoodCart(
                                          resData[index]['meal name'],
                                          resData[index]['meal price'],
                                          resData[index]['description']);
                                }),
                          ],
                        ),
                        Provider.of<MyProvider>(context, listen: false)
                                .existsInCart(resData[index].id)
                            ? IconButton(
                                icon: const Icon(
                                  Icons.remove,
                                  color: Colors.red,
                                ),
                                onPressed: () async {
                                  setState(() {
                                    Provider.of<MyProvider>(context,
                                            listen: false)
                                        .mealID = resData[index].id;
                                  });
                                  await Provider.of<MyProvider>(context,
                                          listen: false)
                                      .removeFoodCart(
                                          resData[index]['meal price']);
                                },
                              )
                            : Container(),
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
            '/rice/${Provider.of<MyProvider>(context, listen: false).restaurantName}/others').orderBy("meal name")
        .snapshots();
    super.initState();
  }

  double? width;
  double? height;

  getWidth() => width = MediaQuery.of(context).size.width;

  getHeight() => height = MediaQuery.of(context).size.height;

  dialog1(title) {
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
  dialog2(title) {
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
  @override
  Widget build(BuildContext context) {
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
                                width: getWidth() * 0.21,
                                height: getHeight() * 0.14,
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
                                SizedBox(height: getHeight() * 0.025),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  width: getWidth() * 0.54,
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
                                SizedBox(height: getHeight() * 0.01),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  width: getWidth() * 0.51,
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
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 7),
                                  alignment: Alignment.bottomLeft,
                                  margin: const EdgeInsets.only(top: 16),
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
                                      style: TextStyle(
                                          fontSize: 15,
                                          color:
                                              Provider.of<MyProvider>(context)
                                                      .isDark
                                                  ? Colors.white70
                                                  : Colors.pink),
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
                                dialog2(e.message);
                                print(e.message);
                              } catch (e) {
                                setState(() {
                                  Provider.of<MyProvider>(context,
                                          listen: false)
                                      .isLoading = false;
                                });
                                dialog2(Provider.of<LanProvider>(context,
                                        listen: false)
                                    .texts('Error occurred !'));
                                print(e);
                              }
                            },
                          ),
                        Row(
                          children: [
                            Text(Provider.of<MyProvider>(context, listen: false)
                                        .getIndex(resData[index].id) ==
                                    -1
                                ? "0"
                                : (Provider.of<MyProvider>(context,
                                            listen: false)
                                        .myCart[Provider.of<MyProvider>(context,
                                                listen: false)
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
                                    Provider.of<MyProvider>(context,
                                            listen: false)
                                        .mealID = resData[index].id;
                                  });
                                  if (Provider.of<MyProvider>(context,
                                                  listen: false)
                                              .myCart
                                              .length !=
                                          0 &&
                                      Provider.of<MyProvider>(context,
                                                  listen: false)
                                              .restaurantName !=
                                          Provider.of<MyProvider>(context,
                                                  listen: false)
                                              .myCart[0]
                                              .resName)
                                    return dialog1(Provider.of<LanProvider>(
                                            context,
                                            listen: false)
                                        .texts('foodCart'));
                                  Provider.of<MyProvider>(context,
                                          listen: false)
                                      .addFoodCart(
                                          resData[index]['meal name'],
                                          resData[index]['meal price'],
                                          resData[index]['description']);
                                }),
                          ],
                        ),
                        Provider.of<MyProvider>(context, listen: false)
                                .existsInCart(resData[index].id)
                            ? IconButton(
                                icon: const Icon(
                                  Icons.remove,
                                  color: Colors.red,
                                ),
                                onPressed: () async {
                                  setState(() {
                                    Provider.of<MyProvider>(context,
                                            listen: false)
                                        .mealID = resData[index].id;
                                  });
                                  await Provider.of<MyProvider>(context,
                                          listen: false)
                                      .removeFoodCart(
                                          resData[index]['meal price']);
                                },
                              )
                            : Container(),
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
