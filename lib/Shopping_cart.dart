import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'LanguageProvider.dart';
import 'Myprovider.dart';

class Shopping extends StatefulWidget {
  @override
  _ShoppingState createState() => _ShoppingState();
}

class _ShoppingState extends State<Shopping> {

  double? width;
  double? height;

  getWidth() => width = MediaQuery.of(context).size.width;
  getHeight() => height = MediaQuery.of(context).size.height;
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
                .texts('choose address'),
            style: TextStyle(
                color: Provider.of<MyProvider>(context).isDark
                    ? CupertinoColors.white
                    : CupertinoColors.black,
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: Theme.of(context).canvasColor,
          elevation: 1,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.add,
                color: Colors.blue,
              ),
              onPressed: () => Navigator.of(context).pushNamed('addAddress'),
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: Provider.of<MyProvider>(context).loc.length,
          itemBuilder: (BuildContext context, int index) {
            if (Provider.of<MyProvider>(context).loc.isEmpty)
              return Center(
                child: TextButton(
                    onPressed: () =>
                        Navigator.of(context).pushNamed('addAddress'),
                    child: Text(
                        Provider.of<LanProvider>(context, listen: false)
                            .texts('new address'),
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ))),
              );
            return Card(
              elevation: 0.5,
              child: ListTile(
                onTap: () {
                  setState(() {
                    Provider.of<MyProvider>(context, listen: false)
                        .checkOut['area'] =
                        Provider.of<MyProvider>(context, listen: false)
                            .loc[index]
                            .area;
                    Provider.of<MyProvider>(context, listen: false)
                        .checkOut['street'] =
                        Provider.of<MyProvider>(context, listen: false)
                            .loc[index]
                            .street;
                    Provider.of<MyProvider>(context, listen: false)
                        .checkOut['phoneNum'] =
                        Provider.of<MyProvider>(context, listen: false)
                            .loc[index]
                            .phoneNum;
                  });
                  Provider.of<MyProvider>(context, listen: false)
                      .deliveryPriceOnArea();
                  Navigator.of(context).pushNamed('checkOut');
                },
                title: Text(Provider.of<MyProvider>(context, listen: false)
                    .loc[index]
                    .area),
                subtitle: Text(
                    Provider.of<LanProvider>(context, listen: false)
                        .texts('street:') +
                        Provider.of<MyProvider>(context, listen: false)
                            .loc[index]
                            .street +
                        "\n" +
                        Provider.of<LanProvider>(context, listen: false)
                            .texts('phone:') +
                        Provider.of<MyProvider>(context, listen: false)
                            .loc[index]
                            .phoneNum),
                isThreeLine: true,
              ),
            );
          },
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: Provider.of<LanProvider>(context).isEn
            ? TextDirection.ltr
            : TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              Provider.of<LanProvider>(context, listen: false)
                  .texts('food cart'),
              style: const TextStyle(fontSize: 20),
            ),
            actions: Provider.of<MyProvider>(context).myCart.isEmpty
                ? null
                : [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext ctx) {
                              return AlertDialog(
                                title: Text(
                                  Provider.of<LanProvider>(context,
                                          listen: false)
                                      .texts('clear everything?'),
                                  style: const TextStyle(fontSize: 23),
                                ),
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 7),
                                elevation: 24,
                                content: Container(
                                  height: getHeight() * 0.05,
                                  child: const Divider(),
                                  alignment: Alignment.topCenter,
                                ),
                                actions: [
                                  InkWell(
                                    child: Text(
                                      Provider.of<LanProvider>(context,
                                              listen: false)
                                          .texts('yes?'),
                                      style: const TextStyle(
                                          fontSize: 19, color: Colors.red),
                                    ),
                                    onTap: () {
                                      Provider.of<MyProvider>(context,
                                              listen: false)
                                          .myCartClear();
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  const SizedBox(width: 11),
                                  InkWell(
                                      child: Text(
                                          Provider.of<LanProvider>(context,
                                                  listen: false)
                                              .texts('cancel?'),
                                          style: const TextStyle(fontSize: 19)),
                                      onTap: () => Navigator.of(context).pop()),
                                ],
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ),
                  ],
          ),
          body: Provider.of<MyProvider>(context).myCart.length == 0
              ? Center(
                  child: Text(
                  Provider.of<LanProvider>(context, listen: false)
                      .texts('empty cart'),
                  style: const TextStyle(
                      fontSize: 18, fontStyle: FontStyle.italic),
                ))
              : ListView.builder(
                  itemCount: Provider.of<MyProvider>(context).myCart.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 5,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 5,
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: getHeight() * 0.02),
                                  Container(
                                    width: getWidth() * 0.6,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 5),
                                    alignment:
                                        Provider.of<LanProvider>(context).isEn
                                            ? Alignment.topLeft
                                            : Alignment.topRight,
                                    child: AutoSizeText(
                                      Provider.of<MyProvider>(context,
                                              listen: false)
                                          .myCart[index]
                                          .mealName,
                                      maxLines: 2,
                                      minFontSize: 12,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ),
                                  Container(
                                    width: getWidth() * 0.56,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    alignment:
                                        Provider.of<LanProvider>(context).isEn
                                            ? Alignment.topLeft
                                            : Alignment.topRight,
                                    child: AutoSizeText(
                                      Provider.of<MyProvider>(context,
                                              listen: false)
                                          .myCart[index]
                                          .description,
                                      maxLines: 3,
                                      minFontSize: 11,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 14,color: Colors.grey),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    alignment:
                                        Provider.of<LanProvider>(context).isEn
                                            ? Alignment.bottomLeft
                                            : Alignment.bottomRight,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 7),
                                      child: Text(
                                        Provider.of<LanProvider>(context,
                                                    listen: false)
                                                .texts('price') +
                                            " " +
                                            Provider.of<MyProvider>(context,
                                                    listen: false)
                                                .myCart[index]
                                                .mealPrice +
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
                                ],
                              ),
                            ),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.remove,
                                  color: Colors.red,
                                ),
                                onPressed: () async {
                                  try {
                                    setState(() {
                                      Provider.of<MyProvider>(context,
                                              listen: false)
                                          .mealID = Provider.of<MyProvider>(
                                              context,
                                              listen: false)
                                          .myCart[index]
                                          .foodID;
                                    });
                                    if (Provider.of<MyProvider>(context, listen: false)
                                        .myCart[index].resName == 'بيتزا المفرق'
                                        || Provider.of<MyProvider>(context,
                                            listen: false).myCart[index].resName ==
                                            'بيتزا اونلاين'|| Provider.of<MyProvider>(context,
                                        listen: false).myCart[index].resName ==
                                        'قايد حضر موت' ||  Provider.of<MyProvider>(context, listen: false)
                                        .restaurantName ==
                                        'نفيسة'|| Provider.of<MyProvider>(context, listen: false)
                                        .restaurantName ==
                                        'ارزه لبنان' || Provider.of<MyProvider>(context, listen: false)
                                        .restaurantName ==
                                        'لبناني الشمال'|| Provider.of<MyProvider>(context, listen: false)
                                        .restaurantName ==
                                        'الحفرة'|| Provider.of<MyProvider>(context, listen: false)
                                        .restaurantName ==
                                        'معجنات ورد'|| Provider.of<MyProvider>(context, listen: false)
                                        .restaurantName ==
                                        'بوابة حضر موت'|| Provider.of<MyProvider>(context, listen: false)
                                        .restaurantName ==
                                        'هون وبس'|| Provider.of<MyProvider>(context, listen: false)
                                        .restaurantName ==
                                        'الدويري'|| Provider.of<MyProvider>(context, listen: false)
                                        .restaurantName ==
                                        'الصالون الأخضر-شويكة')
                                      await Provider.of<MyProvider>(context,
                                              listen: false)
                                          .removeFoodCartTypes(
                                              Provider.of<MyProvider>(context,
                                                      listen: false)
                                                  .myCart[index]
                                                  .mealPrice,
                                              Provider.of<MyProvider>(context,
                                                      listen: false)
                                                  .myCart[index]
                                                  .description,Provider.of<MyProvider>(context,
                                          listen: false)
                                          .myCart[index]
                                          .mealName);
                                    else
                                      await Provider.of<MyProvider>(context,
                                              listen: false)
                                          .removeFoodCart(
                                              Provider.of<MyProvider>(context,
                                                      listen: false)
                                                  .myCart[index]
                                                  .mealPrice);
                                  } catch (e) {
                                    dialog(Provider.of<LanProvider>(context,
                                            listen: false)
                                        .texts('Error occurred !'));
                                    print(e);
                                  }
                                },
                              ),
                              Text(Provider.of<MyProvider>(context,
                                      listen: false)
                                  .myCart[index]
                                  .quantity
                                  .toString()),
                              IconButton(
                                icon: const Icon(
                                  Icons.add,
                                  color: Colors.green,
                                ),
                                onPressed: () async {
                                  try {
                                    setState(() {
                                      Provider.of<MyProvider>(context,
                                              listen: false)
                                          .mealID = Provider.of<MyProvider>(
                                              context,
                                              listen: false)
                                          .myCart[index]
                                          .foodID;
                                    });
                                    if (Provider.of<MyProvider>(context, listen: false)
                                        .myCart[index].resName == 'بيتزا المفرق'
                                        || Provider.of<MyProvider>(context,
                                            listen: false).myCart[index].resName ==
                                            'بيتزا اونلاين'|| Provider.of<MyProvider>(context,
                                        listen: false).myCart[index].resName ==
                                        'قايد حضر موت' ||  Provider.of<MyProvider>(context, listen: false)
                                        .restaurantName ==
                                        'نفيسة'|| Provider.of<MyProvider>(context, listen: false)
                                        .restaurantName ==
                                        'ارزه لبنان' || Provider.of<MyProvider>(context, listen: false)
                                        .restaurantName ==
                                        'لبناني الشمال'|| Provider.of<MyProvider>(context, listen: false)
                                        .restaurantName ==
                                        'الحفرة'|| Provider.of<MyProvider>(context, listen: false)
                                        .restaurantName ==
                                        'معجنات ورد'|| Provider.of<MyProvider>(context, listen: false)
                                        .restaurantName ==
                                        'بوابة حضر موت'|| Provider.of<MyProvider>(context, listen: false)
                                        .restaurantName ==
                                        'هون وبس'|| Provider.of<MyProvider>(context, listen: false)
                                        .restaurantName ==
                                        'الدويري'|| Provider.of<MyProvider>(context, listen: false)
                                        .restaurantName ==
                                        'الصالون الأخضر-شويكة')
                                      await Provider.of<MyProvider>(context,
                                          listen: false)
                                          .addFoodCartTypes(
                                          Provider.of<MyProvider>(context,
                                              listen: false)
                                              .myCart[index]
                                              .mealPrice,
                                          Provider.of<MyProvider>(context,
                                              listen: false)
                                              .myCart[index]
                                              .description,Provider.of<MyProvider>(context,
                                          listen: false)
                                          .myCart[index]
                                          .mealName);
                                    else
                                      await Provider.of<MyProvider>(context,
                                            listen: false)
                                        .addFoodCart(
                                            Provider.of<MyProvider>(context,
                                                    listen: false)
                                                .myCart[index]
                                                .mealName,
                                            Provider.of<MyProvider>(context,
                                                    listen: false)
                                                .myCart[index]
                                                .mealPrice,
                                            Provider.of<MyProvider>(context,
                                                    listen: false)
                                                .myCart[index]
                                                .description);
                                  } catch (e) {
                                    dialog(Provider.of<LanProvider>(context,
                                            listen: false)
                                        .texts('Error occurred !'));
                                    print(e);
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
          bottomNavigationBar: Container(
            height: getHeight() * 0.16,
            child: Column(children: [
              if (Provider.of<MyProvider>(context).myCart.isNotEmpty)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                          Provider.of<LanProvider>(context, listen: false)
                              .texts('cart total :'),
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    Text(
                        Provider.of<MyProvider>(context)
                                .total
                                .toStringAsFixed(2) +
                            " ",
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                    Text(
                        Provider.of<LanProvider>(context, listen: false)
                            .texts('jd'),
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
              if (Provider.of<MyProvider>(context).myCart.isNotEmpty)
                Provider.of<MyProvider>(context, listen: false).isLoading
                    ? const Center(
                        child: const CircularProgressIndicator(),
                      )
                    : TextButton(
                        onPressed: () async {
                          if (Provider.of<MyProvider>(context, listen: false)
                                      .long ==
                                  null &&
                              Provider.of<MyProvider>(context, listen: false)
                                      .lat ==
                                  null) {
                            try {
                              setState(() {
                                Provider.of<MyProvider>(context, listen: false)
                                    .isLoading = true;
                              });
                              await Provider.of<MyProvider>(context,
                                      listen: false)
                                  .sendLocationToDB(context);
                              setState(() {
                                Provider.of<MyProvider>(context, listen: false)
                                    .isLoading = false;
                              });
                              if (Provider.of<MyProvider>(context,
                                      listen: false)
                                  .approved)
                                showModalBottomSheet(
                                    context: context,
                                    builder: (_) => bottomSheet());
                              print('done');
                            } on FirebaseException catch (e) {
                              setState(() {
                                Provider.of<MyProvider>(context, listen: false)
                                    .isLoading = false;
                              });
                              dialog(Provider.of<LanProvider>(context,
                                      listen: false)
                                  .texts('Error occurred !'));
                              print(e.message);
                            } catch (e) {
                              setState(() {
                                Provider.of<MyProvider>(context, listen: false)
                                    .isLoading = false;
                              });
                              dialog(Provider.of<LanProvider>(context,
                                      listen: false)
                                  .texts('Error occurred !'));
                              print(e);
                            }
                          } else {
                            showModalBottomSheet(
                                context: context,
                                builder: (_) => bottomSheet());
                          }
                        },
                        child: Text(
                            Provider.of<LanProvider>(context, listen: false)
                                .texts('Next'),
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ))),
            ]),
          ),
        ));
  }
}
