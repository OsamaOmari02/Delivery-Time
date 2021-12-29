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

class MilkScreen extends StatefulWidget {
  @override
  _MilkScreenState createState() => _MilkScreenState();
}

var tab1p;
var tab2p;
var tab3p;
var tab4p;
var tab5p;
var tab6p;
var tab7p;
var tab8p;
var tab9p;

class _MilkScreenState extends State<MilkScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      Provider.of<MyProvider>(context, listen: false).fetchMealsDrinks(
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
                    'لبناني الشمال'
                ? 7
                : 3,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
                Provider.of<MyProvider>(context, listen: false).restaurantName),
            bottom: TabBar(
              // labelPadding: EdgeInsets.symmetric(horizontal: getWidth() * 0.1),
              isScrollable: Provider.of<MyProvider>(context, listen: false)
                          .restaurantName ==
                      'لبناني الشمال'
                  ? true
                  : false,
              tabs: [
                Tab(
                    text: Provider.of<LanProvider>(context, listen: false)
                        .texts('tabMilk')),
                if (Provider.of<MyProvider>(context, listen: false)
                        .restaurantName ==
                    'لبناني الشمال')
                  Tab(
                      text: Provider.of<LanProvider>(context, listen: false)
                          .texts('tabCockTail')),
                if (Provider.of<MyProvider>(context, listen: false)
                        .restaurantName ==
                    'لبناني الشمال')
                  Tab(
                      text: Provider.of<LanProvider>(context, listen: false)
                          .texts('tabNaturalDrinks')),
                if (Provider.of<MyProvider>(context, listen: false)
                        .restaurantName ==
                    'لبناني الشمال')
                  Tab(
                      text: Provider.of<LanProvider>(context, listen: false)
                          .texts('tabSpecial')),
                if (Provider.of<MyProvider>(context, listen: false)
                        .restaurantName ==
                    'لبناني الشمال')
                  Tab(
                      text: Provider.of<LanProvider>(context, listen: false)
                          .texts('tabSlushDrinks')),
                if (Provider.of<MyProvider>(context, listen: false)
                        .restaurantName ==
                    'لبناني الشمال')
                  Tab(
                      text: Provider.of<LanProvider>(context, listen: false)
                          .texts('tabSalads')),
                if (Provider.of<MyProvider>(context, listen: false)
                        .restaurantName ==
                    'لبناني الشمال')
                  Tab(
                      text: Provider.of<LanProvider>(context, listen: false)
                          .texts('tabWaffles&Pancakes')),
                if (Provider.of<MyProvider>(context, listen: false)
                        .restaurantName ==
                    'الحفرة')
                  Tab(
                      text: Provider.of<LanProvider>(context, listen: false)
                          .texts('tabMixes')),
                if (Provider.of<MyProvider>(context, listen: false)
                        .restaurantName ==
                    'الحفرة')
                  Tab(
                      text: Provider.of<LanProvider>(context, listen: false)
                          .texts('tabHot')),
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
              First(),
              if (Provider.of<MyProvider>(context, listen: false)
                      .restaurantName ==
                  'لبناني الشمال')
                NaturalCocktail(),
              if (Provider.of<MyProvider>(context, listen: false)
                      .restaurantName ==
                  'لبناني الشمال')
                NaturalDrinks(),
              if (Provider.of<MyProvider>(context, listen: false)
                      .restaurantName ==
                  'لبناني الشمال')
                SpecialCocktail(),
              if (Provider.of<MyProvider>(context, listen: false)
                      .restaurantName ==
                  'لبناني الشمال')
                NaturalSlush(),
              if (Provider.of<MyProvider>(context, listen: false)
                      .restaurantName ==
                  'لبناني الشمال')
                FruitsSalads(),
              if (Provider.of<MyProvider>(context, listen: false)
                      .restaurantName ==
                  'لبناني الشمال')
                CrepeAndWaffls(),
              if (Provider.of<MyProvider>(context, listen: false)
                      .restaurantName !=
                  'لبناني الشمال')
                Second(),
              if (Provider.of<MyProvider>(context, listen: false)
                      .restaurantName !=
                  'لبناني الشمال')
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
            '/drinks/${Provider.of<MyProvider>(context, listen: false).restaurantName}/milk')
        .orderBy("meal price")
        .snapshots();
    super.initState();
  }

  int _counter = 0;
  double _price = 0.00;

  Widget radioListType1(index, setState) {
    return RadioListTile(
      value: Provider.of<MyProvider>(context).milkTypes[index].value,
      groupValue: Provider.of<MyProvider>(context).radioValue7,
      onChanged: (val) {
        setState(() {
          Provider.of<MyProvider>(context, listen: false).radioValue7 = val!;
        });
      },
      title: Text(Provider.of<MyProvider>(context).milkTypes[index].title),
    );
  }

  Widget radioListType2(index, setState) {
    return RadioListTile(
      value: Provider.of<MyProvider>(context).iceCreamTypes[index].value,
      groupValue: Provider.of<MyProvider>(context).radioValue8,
      onChanged: (val) {
        setState(() {
          Provider.of<MyProvider>(context, listen: false).radioValue8 = val!;
        });
      },
      title: Text(Provider.of<MyProvider>(context).iceCreamTypes[index].title),
    );
  }

  Widget radioListType3(index, setState) {
    return RadioListTile(
      value: Provider.of<MyProvider>(context).iceCreamTypes3[index].value,
      groupValue: Provider.of<MyProvider>(context).radioValue17,
      onChanged: (val) {
        setState(() {
          Provider.of<MyProvider>(context, listen: false).radioValue17 = val!;
        });
      },
      title: Text(Provider.of<MyProvider>(context).iceCreamTypes3[index].title),
    );
  }

  Widget radioListType4(index, setState) {
    return RadioListTile(
      value: Provider.of<MyProvider>(context).milkShakeTypes[index].value,
      groupValue: Provider.of<MyProvider>(context).radioValue18,
      onChanged: (val) {
        setState(() {
          Provider.of<MyProvider>(context, listen: false).radioValue18 = val!;
        });
      },
      title: Text(Provider.of<MyProvider>(context).milkShakeTypes[index].title),
    );
  }

  bottomSheet(itemCount, mealName) {
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
                itemCount: itemCount,
                itemBuilder: (BuildContext context, int index) {
                  return mealName.toString() == 'ايس كريم عادي' ||
                          mealName.toString() == 'ايس كريم سبيشال'
                      ? radioListType3(index, setState)
                      : mealName.toString() == 'ميلك شيك سبيشال' ||
                              mealName.toString() == 'ميلك شيك عادي'
                          ? radioListType4(index, setState)
                          : mealName.toString() == 'بوظة كبير'
                              ? radioListType2(index, setState)
                              : mealName.toString() == 'ميلك شيك صغير' ||
                                      mealName.toString() == 'ميلك شيك كبير'
                                  ? radioListType1(index, setState)
                                  : Container();
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
                            if (Provider.of<MyProvider>(context, listen: false)
                                        .myCart
                                        .length !=
                                    0 &&
                                Provider.of<MyProvider>(context, listen: false)
                                        .restaurantName !=
                                    Provider.of<MyProvider>(context,
                                            listen: false)
                                        .myCart[0]
                                        .resName)
                              return dialog1(Provider.of<LanProvider>(context,
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
                                .addFoodCartRadioMilk(_counter, mealName);
                            setState(() {
                              _price = 0.00;
                              _counter = 0;
                              Provider.of<MyProvider>(context, listen: false)
                                  .radioValue7 = null;
                              Provider.of<MyProvider>(context, listen: false)
                                  .radioValue8 = null;
                              Provider.of<MyProvider>(context, listen: false)
                                  .radioValue17 = null;
                              Provider.of<MyProvider>(context, listen: false)
                                  .radioValue18 = null;
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
                    resData[index]['meal name'].toString() != 'بوظة كبير' &&
                            (resData[index]['meal name'] != 'ميلك شيك كبير' &&
                                resData[index]['meal name'] !=
                                    'ميلك شيك صغير') &&
                            (resData[index]['meal name'] != 'ميلك شيك عادي' &&
                                resData[index]['meal name'] !=
                                    'ميلك شيك سبيشال')
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
                                  icon: Icon(
                                    resData[index]['meal name'].toString() ==
                                                'بوظة كبير' ||
                                            resData[index]['meal name']
                                                .toString()
                                                .startsWith('ايس كريم')
                                        ? Icons.icecream
                                        : Icons.local_drink,
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
                                          builder: (_) => resData[index]['meal name']
                                                      .toString() ==
                                                  'بوظة كبير'
                                              ? bottomSheet(9,
                                                  resData[index]['meal name'])
                                              : resData[index]['meal name']
                                                              .toString() ==
                                                          'ميلك شيك كبير' ||
                                                      resData[index]['meal name']
                                                              .toString() ==
                                                          'ميلك شيك صغير'
                                                  ? bottomSheet(
                                                      9,
                                                      resData[index]
                                                          ['meal name'])
                                                  : resData[index]['meal name']
                                                                  .toString() ==
                                                              'ميلك شيك عادي' ||
                                                          resData[index]['meal name']
                                                                  .toString() ==
                                                              'ميلك شيك سبيشال'
                                                      ? bottomSheet(5, resData[index]['meal name'].toString())
                                                      : resData[index]['meal name'].toString().startsWith('ايس كريم')
                                                          ? bottomSheet(6, resData[index]['meal name'].toString())
                                                          : null);
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
                                          builder: (_) => resData[index]['meal name']
                                              .toString() ==
                                              'بوظة كبير'
                                              ? bottomSheet(9,
                                              resData[index]['meal name'])
                                              : resData[index]['meal name']
                                              .toString() ==
                                              'ميلك شيك كبير' ||
                                              resData[index]['meal name']
                                                  .toString() ==
                                                  'ميلك شيك صغير'
                                              ? bottomSheet(
                                              9,
                                              resData[index]
                                              ['meal name'])
                                              : resData[index]['meal name']
                                              .toString() ==
                                              'ميلك شيك عادي' ||
                                              resData[index]['meal name']
                                                  .toString() ==
                                                  'ميلك شيك سبيشال'
                                              ? bottomSheet(5, resData[index]['meal name'].toString())
                                              : resData[index]['meal name'].toString().startsWith('ايس كريم')
                                              ? bottomSheet(6, resData[index]['meal name'].toString())
                                              : null);
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
            '/drinks/${Provider.of<MyProvider>(context, listen: false).restaurantName}/mixes')
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
            '/drinks/${Provider.of<MyProvider>(context, listen: false).restaurantName}/hot drinks')
        .orderBy("meal name")
        .snapshots();
    super.initState();
  }

  int _counter = 0;
  double _price = 0.00;

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
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  return RadioListTile(
                    value:
                        Provider.of<MyProvider>(context).hotTypes[index].value,
                    groupValue: Provider.of<MyProvider>(context).radioValue9,
                    onChanged: (val) {
                      setState(() {
                        Provider.of<MyProvider>(context, listen: false)
                            .radioValue9 = val!;
                      });
                    },
                    title: Text(
                        Provider.of<MyProvider>(context).hotTypes[index].title),
                  );
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
                            if (Provider.of<MyProvider>(context, listen: false)
                                        .myCart
                                        .length !=
                                    0 &&
                                Provider.of<MyProvider>(context, listen: false)
                                        .restaurantName !=
                                    Provider.of<MyProvider>(context,
                                            listen: false)
                                        .myCart[0]
                                        .resName)
                              return dialog1(Provider.of<LanProvider>(context,
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
                                .addFoodCartRadioHot(_counter);
                            setState(() {
                              _price = 0.00;
                              _counter = 0;
                              Provider.of<MyProvider>(context, listen: false)
                                  .radioValue9 = null;
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
                            icon: Icon(
                              Icons.coffee,
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

//---------------------------NaturalCocktail--------------------------
class NaturalCocktail extends StatefulWidget {
  @override
  _NaturalCocktailState createState() => _NaturalCocktailState();
}

class _NaturalCocktailState extends State<NaturalCocktail> {
  @override
  void initState() {
    tab4p = FirebaseFirestore.instance
        .collection(
            '/drinks/${Provider.of<MyProvider>(context, listen: false).restaurantName}/natural cocktail')
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
      stream: tab4p,
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

//---------------------------NaturalDrinks----------------------
class NaturalDrinks extends StatefulWidget {
  @override
  _NaturalDrinksState createState() => _NaturalDrinksState();
}

class _NaturalDrinksState extends State<NaturalDrinks> {
  @override
  void initState() {
    tab5p = FirebaseFirestore.instance
        .collection(
            '/drinks/${Provider.of<MyProvider>(context, listen: false).restaurantName}/natural drinks')
        .orderBy("meal price")
        .snapshots();
    super.initState();
  }

  int _counter = 0;
  double _price = 0.00;

  Widget radioListType1(index, setState) {
    return RadioListTile(
      value: Provider.of<MyProvider>(context).naturalDrinks[index].value,
      groupValue: Provider.of<MyProvider>(context).radioValue15,
      onChanged: (val) {
        setState(() {
          Provider.of<MyProvider>(context, listen: false).radioValue15 = val!;
        });
      },
      title: Text(Provider.of<MyProvider>(context).naturalDrinks[index].title),
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
                    .naturalDrinks
                    .length,
                itemBuilder: (BuildContext context, int index) {
                  return radioListType1(index, setState);
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
                            if (Provider.of<MyProvider>(context, listen: false)
                                        .myCart
                                        .length !=
                                    0 &&
                                Provider.of<MyProvider>(context, listen: false)
                                        .restaurantName !=
                                    Provider.of<MyProvider>(context,
                                            listen: false)
                                        .myCart[0]
                                        .resName)
                              return dialog1(Provider.of<LanProvider>(context,
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
                                .addFoodCartRadioLebanese(_counter, mealName);
                            setState(() {
                              _price = 0.00;
                              _counter = 0;
                              Provider.of<MyProvider>(context, listen: false)
                                  .radioValue15 = null;
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
      stream: tab5p,
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
                    resData[index]['meal name'].toString() !=
                                'عصير طبيعي حجم صغير' &&
                            resData[index]['meal name'] !=
                                'عصير طبيعي حجم كبير' &&
                            resData[index]['meal name'] !=
                                'عصير طبيعي حجم 1 لتر' &&
                            resData[index]['meal name'] !=
                                'عصير طبيعي حجم 1.5 لتر'
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
                                  icon: Icon(
                                    Icons.local_drink,
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

//----------------------------------SpecialCocktail-------------------
class SpecialCocktail extends StatefulWidget {
  @override
  _SpecialCocktailState createState() => _SpecialCocktailState();
}

class _SpecialCocktailState extends State<SpecialCocktail> {
  @override
  void initState() {
    tab6p = FirebaseFirestore.instance
        .collection(
            '/drinks/${Provider.of<MyProvider>(context, listen: false).restaurantName}/special cocktail')
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
      stream: tab6p,
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

//--------------------------NaturalSlush-------------------------
class NaturalSlush extends StatefulWidget {
  @override
  _NaturalSlushState createState() => _NaturalSlushState();
}

class _NaturalSlushState extends State<NaturalSlush> {
  @override
  void initState() {
    tab7p = FirebaseFirestore.instance
        .collection(
            '/drinks/${Provider.of<MyProvider>(context, listen: false).restaurantName}/natural slush')
        .orderBy("meal price")
        .snapshots();
    super.initState();
  }

  int _counter = 0;
  double _price = 0.00;

  Widget radioListType1(index, setState) {
    return RadioListTile(
      value: Provider.of<MyProvider>(context).naturalSlush[index].value,
      groupValue: Provider.of<MyProvider>(context).radioValue16,
      onChanged: (val) {
        setState(() {
          Provider.of<MyProvider>(context, listen: false).radioValue16 = val!;
        });
      },
      title: Text(Provider.of<MyProvider>(context).naturalSlush[index].title),
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
                    .naturalSlush
                    .length,
                itemBuilder: (BuildContext context, int index) {
                  return radioListType1(index, setState);
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
                            if (Provider.of<MyProvider>(context, listen: false)
                                        .myCart
                                        .length !=
                                    0 &&
                                Provider.of<MyProvider>(context, listen: false)
                                        .restaurantName !=
                                    Provider.of<MyProvider>(context,
                                            listen: false)
                                        .myCart[0]
                                        .resName)
                              return dialog1(Provider.of<LanProvider>(context,
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
                                .addFoodCartRadioLebanese(_counter, mealName);
                            setState(() {
                              _price = 0.00;
                              _counter = 0;
                              Provider.of<MyProvider>(context, listen: false)
                                  .radioValue16 = null;
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
      stream: tab7p,
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
                              Icons.local_drink,
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

//-----------------------------FruitsSalads----------------------
class FruitsSalads extends StatefulWidget {
  @override
  _FruitsSaladsState createState() => _FruitsSaladsState();
}

class _FruitsSaladsState extends State<FruitsSalads> {
  @override
  void initState() {
    tab8p = FirebaseFirestore.instance
        .collection(
            '/drinks/${Provider.of<MyProvider>(context, listen: false).restaurantName}/fruits salads')
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
      stream: tab8p,
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

//-----------------------------CrepeAndWaffls----------------------
class CrepeAndWaffls extends StatefulWidget {
  @override
  _CrepeAndWafflsState createState() => _CrepeAndWafflsState();
}

class _CrepeAndWafflsState extends State<CrepeAndWaffls> {
  @override
  void initState() {
    tab9p = FirebaseFirestore.instance
        .collection(
            '/drinks/${Provider.of<MyProvider>(context, listen: false).restaurantName}/waffle')
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
      stream: tab9p,
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
