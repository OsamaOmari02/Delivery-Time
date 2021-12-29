import 'package:app/Myprovider.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'LanguageProvider.dart';

class SweetScreen extends StatefulWidget {
  @override
  _SweetScreenState createState() => _SweetScreenState();
}

var tab1s;
var tab2s;
var tab3s;
var tab4s;
var tab5s;
var tab6s;
var tab7s;
var tab8s;
var tabGateau;

class _SweetScreenState extends State<SweetScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      Provider.of<MyProvider>(context, listen: false).fetchMealsSweets(
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
        length: Provider.of<MyProvider>(context, listen: false)
                    .restaurantName ==
                'نفيسة'
            ? 4
            : Provider.of<MyProvider>(context, listen: false).restaurantName ==
                    'الصالون الأخضر-شويكة'
                ? 8
                : 3,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
                Provider.of<MyProvider>(context, listen: false).restaurantName),
            bottom: TabBar(
              labelPadding: Provider.of<MyProvider>(context, listen: false)
                          .restaurantName ==
                      'الصالون الأخضر-شويكة'
                  ? EdgeInsets.symmetric(horizontal: getWidth() * 0.05)
                  : EdgeInsets.symmetric(horizontal: getWidth() * 0.08),
              isScrollable: true,
              tabs: [
                if (Provider.of<MyProvider>(context, listen: false)
                            .restaurantName ==
                        'نفيسة' ||
                    Provider.of<MyProvider>(context, listen: false)
                            .restaurantName ==
                        'الصالون الأخضر-شويكة')
                  Tab(
                      text: Provider.of<LanProvider>(context, listen: false)
                          .texts('tabNafesa')),
                if (Provider.of<MyProvider>(context, listen: false)
                        .restaurantName ==
                    'الصالون الأخضر-شويكة')
                  Tab(
                      text: Provider.of<LanProvider>(context, listen: false)
                          .texts('tabSweets')),
                if (Provider.of<MyProvider>(context, listen: false)
                        .restaurantName !=
                    'الصالون الأخضر-شويكة')
                  Tab(
                      text: Provider.of<LanProvider>(context, listen: false)
                          .texts('tab4')),
                if (Provider.of<MyProvider>(context, listen: false)
                        .restaurantName ==
                    'الصالون الأخضر-شويكة')
                  Tab(
                      text: Provider.of<LanProvider>(context, listen: false)
                          .texts('tabSnacks')),
                if (Provider.of<MyProvider>(context, listen: false)
                        .restaurantName ==
                    'الصالون الأخضر-شويكة')
                  Tab(
                      text: Provider.of<LanProvider>(context, listen: false)
                          .texts('tabPizza&mnaqish')),
                if (Provider.of<MyProvider>(context, listen: false)
                        .restaurantName ==
                    'الصالون الأخضر-شويكة')
                  Tab(
                      text: Provider.of<LanProvider>(context, listen: false)
                          .texts('tabRolls')),
                if (Provider.of<MyProvider>(context, listen: false)
                        .restaurantName ==
                    'الصالون الأخضر-شويكة')
                  Tab(
                      text: Provider.of<LanProvider>(context, listen: false)
                          .texts('tabWaffle')),
                if (Provider.of<MyProvider>(context, listen: false)
                        .restaurantName ==
                    'الصالون الأخضر-شويكة')
                  Tab(
                      text: Provider.of<LanProvider>(context, listen: false)
                          .texts('tabCocktail')),
                if (Provider.of<MyProvider>(context, listen: false)
                        .restaurantName !=
                    'الصالون الأخضر-شويكة')
                  Tab(
                      text: Provider.of<LanProvider>(context, listen: false)
                          .texts('tab5')),
                Tab(
                    text: Provider.of<LanProvider>(context, listen: false)
                        .texts('tab3')),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            height: getHeight() * 0.1,
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
                      'نفيسة' ||
                  Provider.of<MyProvider>(context, listen: false)
                          .restaurantName ==
                      'الصالون الأخضر-شويكة')
                Gateau(),
              First(),
              if (Provider.of<MyProvider>(context, listen: false)
                      .restaurantName ==
                  'الصالون الأخضر-شويكة')
                Snacks(),
              if (Provider.of<MyProvider>(context, listen: false)
                      .restaurantName ==
                  'الصالون الأخضر-شويكة')
                Pizza(),
              if (Provider.of<MyProvider>(context, listen: false)
                      .restaurantName ==
                  'الصالون الأخضر-شويكة')
                Rolls(),
              if (Provider.of<MyProvider>(context, listen: false)
                      .restaurantName ==
                  'الصالون الأخضر-شويكة')
                Waffle(),
              if (Provider.of<MyProvider>(context, listen: false)
                      .restaurantName ==
                  'الصالون الأخضر-شويكة')
                IceCream(),
              if (Provider.of<MyProvider>(context, listen: false)
                      .restaurantName !=
                  'الصالون الأخضر-شويكة')
                Second(),
              Third(),
            ],
          ),
        ),
      ),
    );
  }
}

//--------------------------1----------------------------
class First extends StatefulWidget {
  @override
  _FirstState createState() => _FirstState();
}

class _FirstState extends State<First> {
  @override
  void initState() {
    tab1s = FirebaseFirestore.instance
        .collection(
            '/sweets/${Provider.of<MyProvider>(context, listen: false).restaurantName}/kunafeh')
        .orderBy("meal name")
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

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: tab1s,
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return const Center(child: const CircularProgressIndicator());
        if (snapshot.hasError)
          return Center(
              child: Text(Provider.of<LanProvider>(context, listen: false)
                  .texts('something went wrong !')));
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
                                SizedBox(height: getWidth() * 0.025),
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

//-----------------------2--------------------------
class Gateau extends StatefulWidget {
  @override
  _GateauState createState() => _GateauState();
}

class _GateauState extends State<Gateau> {
  @override
  void initState() {
    tabGateau = FirebaseFirestore.instance
        .collection(
            '/sweets/${Provider.of<MyProvider>(context, listen: false).restaurantName}/gateau')
        .orderBy("meal name")
        .snapshots();
    super.initState();
  }

  int _counter = 0;
  double _price = 0.00;

  Widget radioListType(index, setState) {
    return RadioListTile(
      value: Provider.of<MyProvider>(context).cakeTypes[index].value,
      groupValue: Provider.of<MyProvider>(context).radioValue2,
      onChanged: (val) {
        setState(() {
          Provider.of<MyProvider>(context, listen: false).radioValue2 = val!;
        });
      },
      title: Text(Provider.of<MyProvider>(context).cakeTypes[index].title),
    );
  }

  Widget radioListType1(index, setState) {
    return RadioListTile(
      value: Provider.of<MyProvider>(context).saloonTypes1[index].value,
      groupValue: Provider.of<MyProvider>(context).radioValue10,
      onChanged: (val) {
        setState(() {
          Provider.of<MyProvider>(context, listen: false).radioValue10 = val!;
        });
      },
      title: Text(Provider.of<MyProvider>(context).saloonTypes1[index].title),
    );
  }

  Widget radioListType2(index, setState) {
    return RadioListTile(
      value: Provider.of<MyProvider>(context).saloonTypes2[index].value,
      groupValue: Provider.of<MyProvider>(context).radioValue11,
      onChanged: (val) {
        setState(() {
          Provider.of<MyProvider>(context, listen: false).radioValue11 = val!;
        });
      },
      title: Text(Provider.of<MyProvider>(context).saloonTypes2[index].title),
    );
  }

  bottomSheet(mealName) {
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
                        'نفيسة'
                    ? Provider.of<MyProvider>(context).cakeTypes.length
                    : mealName.toString() == 'قالب جاتو صغير' ||
                            mealName.toString() == 'قالب جاتو كبير'
                        ? 2
                        : 4,
                itemBuilder: (BuildContext context, int index) {
                  return Provider.of<MyProvider>(context, listen: false)
                              .restaurantName ==
                          'نفيسة'
                      ? radioListType(index, setState)
                      : mealName.toString() == 'قالب جاتو صغير' ||
                              mealName.toString() == 'قالب جاتو كبير' ||
                              mealName.toString() == 'قالب جاتو محشي صغير'
                          ? radioListType1(index, setState)
                          : radioListType2(index, setState);
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
                                        .restaurantName ==
                                    'نفيسة'
                                ? Provider.of<MyProvider>(context,
                                        listen: false)
                                    .addFoodCartRadio(_counter)
                                : Provider.of<MyProvider>(context,
                                        listen: false)
                                    .addFoodCartRadioSaloon(_counter, mealName);
                            setState(() {
                              _price = 0.00;
                              _counter = 0;
                              Provider.of<MyProvider>(context, listen: false)
                                  .radioValue2 = Provider.of<MyProvider>(
                                      context,
                                      listen: false)
                                  .radioValue10 = Provider.of<MyProvider>(
                                      context,
                                      listen: false)
                                  .radioValue11 = null;
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
      stream: tabGateau,
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
                              Icons.cake,
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
                                    builder: (_) => bottomSheet(
                                        resData[index]['meal name']));
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
                                    builder: (_) => bottomSheet(
                                        resData[index]['meal name']));
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

//------------------------------2----------------------------
class Second extends StatefulWidget {
  @override
  _SecondState createState() => _SecondState();
}

class _SecondState extends State<Second> {
  @override
  void initState() {
    tab2s = FirebaseFirestore.instance
        .collection(
            '/sweets/${Provider.of<MyProvider>(context, listen: false).restaurantName}/cake')
        .orderBy("meal name")
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
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: tab2s,
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return const Center(child: const CircularProgressIndicator());
        if (snapshot.hasError)
          return Center(
              child: Text(Provider.of<LanProvider>(context, listen: false)
                  .texts('something went wrong !')));
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
    tab3s = FirebaseFirestore.instance
        .collection(
            '/sweets/${Provider.of<MyProvider>(context, listen: false).restaurantName}/others')
        .orderBy("meal name")
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

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: tab3s,
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return const Center(child: const CircularProgressIndicator());
        if (snapshot.hasError)
          return Center(
              child: Text(Provider.of<LanProvider>(context, listen: false)
                  .texts('something went wrong !')));
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

//---------------------------Snacks------------------------
class Snacks extends StatefulWidget {
  @override
  _SnacksState createState() => _SnacksState();
}

class _SnacksState extends State<Snacks> {
  @override
  void initState() {
    tab4s = FirebaseFirestore.instance
        .collection(
            '/sweets/${Provider.of<MyProvider>(context, listen: false).restaurantName}/snacks')
        .orderBy("meal name")
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

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: tab4s,
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return const Center(child: const CircularProgressIndicator());
        if (snapshot.hasError)
          return Center(
              child: Text(Provider.of<LanProvider>(context, listen: false)
                  .texts('something went wrong !')));
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

//----------------------------Pizza--------------------------
class Pizza extends StatefulWidget {
  @override
  _PizzaState createState() => _PizzaState();
}

class _PizzaState extends State<Pizza> {
  @override
  void initState() {
    tab5s = FirebaseFirestore.instance
        .collection(
            '/sweets/${Provider.of<MyProvider>(context, listen: false).restaurantName}/pizza')
        .orderBy("meal name")
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

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: tab5s,
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return const Center(child: const CircularProgressIndicator());
        if (snapshot.hasError)
          return Center(
              child: Text(Provider.of<LanProvider>(context, listen: false)
                  .texts('something went wrong !')));
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

//------------------------------Rolls-------------------------
class Rolls extends StatefulWidget {
  @override
  _RollsState createState() => _RollsState();
}

class _RollsState extends State<Rolls> {
  @override
  void initState() {
    tab6s = FirebaseFirestore.instance
        .collection(
            '/sweets/${Provider.of<MyProvider>(context, listen: false).restaurantName}/rolls')
        .orderBy("meal name")
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

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: tab6s,
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return const Center(child: const CircularProgressIndicator());
        if (snapshot.hasError)
          return Center(
              child: Text(Provider.of<LanProvider>(context, listen: false)
                  .texts('something went wrong !')));
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

//---------------------------------waffle----------------------
class Waffle extends StatefulWidget {
  @override
  _WaffleState createState() => _WaffleState();
}

class _WaffleState extends State<Waffle> {
  @override
  void initState() {
    tab7s = FirebaseFirestore.instance
        .collection(
            '/sweets/${Provider.of<MyProvider>(context, listen: false).restaurantName}/waffle')
        .orderBy("meal name")
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

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: tab7s,
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return const Center(child: const CircularProgressIndicator());
        if (snapshot.hasError)
          return Center(
              child: Text(Provider.of<LanProvider>(context, listen: false)
                  .texts('something went wrong !')));
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

//--------------------------------IceCream---------------------
class IceCream extends StatefulWidget {
  @override
  _IceCreamState createState() => _IceCreamState();
}

class _IceCreamState extends State<IceCream> {
  @override
  void initState() {
    tab8s = FirebaseFirestore.instance
        .collection(
            '/sweets/${Provider.of<MyProvider>(context, listen: false).restaurantName}/ice cream')
        .orderBy("meal name")
        .snapshots();
    super.initState();
  }

  double? width;
  double? height;

  getWidth() => width = MediaQuery.of(context).size.width;

  getHeight() => height = MediaQuery.of(context).size.height;

  Widget radioListType3(index, setState) {
    return RadioListTile(
      value: Provider.of<MyProvider>(context).iceCreamTypes2[index].value,
      groupValue: Provider.of<MyProvider>(context).radioValue12,
      onChanged: (val) {
        setState(() {
          Provider.of<MyProvider>(context, listen: false).radioValue12 = val!;
        });
      },
      title: Text(Provider.of<MyProvider>(context).iceCreamTypes2[index].title),
    );
  }

  int _counter = 0;
  double _price = 0.00;

  bottomSheet(mealName) {
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
                itemCount: mealName.toString() == 'بوظة مشكل 1 كيلو' ||
                        mealName.toString() == 'بوظة مشكل 1/2 كيلو'
                    ? 4
                    : mealName.toString() == 'علبة بوظة حجم صغير'
                        ? 7
                        : 6,
                itemBuilder: (BuildContext context, int index) {
                  return radioListType3(index, setState);
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
                                .addFoodCartRadioSaloon(_counter, mealName);
                            setState(() {
                              _price = 0.00;
                              _counter = 0;
                              Provider.of<MyProvider>(context, listen: false)
                                  .radioValue12 = null;
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

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: tab8s,
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return const Center(child: const CircularProgressIndicator());
        if (snapshot.hasError)
          return Center(
              child: Text(Provider.of<LanProvider>(context, listen: false)
                  .texts('something went wrong !')));
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
                    resData[index]['meal name'].toString() ==
                                'بوظة مشكل 1 كيلو' ||
                            resData[index]['meal name'].toString() ==
                                'بوظة مشكل 1/2 كيلو' ||
                            resData[index]['meal name'].toString() ==
                                'علبة بوظة حجم صغير' ||
                            resData[index]['meal name'].toString() ==
                                'علبة بوظة حجم كبير'
                        ? Column(
                            children: [
                              if (Provider.of<MyProvider>(context,
                                      listen: false)
                                  .isLoading)
                                const CircularProgressIndicator(),
                              if (!Provider.of<MyProvider>(context,
                                      listen: false)
                                  .isLoading)
                                IconButton(
                                  icon: Icon(
                                    Icons.icecream,
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
                                          builder: (_) => bottomSheet(
                                              resData[index]['meal name']));
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 1.0),
                                child: TextButton(
                                  child: Text(
                                      Provider.of<LanProvider>(context,
                                              listen: false)
                                          .texts('choose pizza'),
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.blueAccent)),
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
                                          builder: (_) => bottomSheet(
                                              resData[index]['meal name']));
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
                          )
                        : Column(
                            children: [
                              if (Provider.of<MyProvider>(context,
                                      listen: false)
                                  .isLoading)
                                const CircularProgressIndicator(),
                              if (!Provider.of<MyProvider>(context,
                                      listen: false)
                                  .isLoading)
                                IconButton(
                                  alignment: Alignment.topLeft,
                                  icon: Icon(
                                    Provider.of<MyProvider>(context,
                                                listen: false)
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
                                  Text(Provider.of<MyProvider>(context,
                                                  listen: false)
                                              .getIndex(resData[index].id) ==
                                          -1
                                      ? "0"
                                      : (Provider.of<MyProvider>(context,
                                                  listen: false)
                                              .myCart[Provider.of<MyProvider>(
                                                      context,
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
                                          return dialog1(
                                              Provider.of<LanProvider>(context,
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
