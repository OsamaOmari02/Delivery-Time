import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'LanguageProvider.dart';
import 'Myprovider.dart';

class Shopping extends StatefulWidget {
  @override
  _ShoppingState createState() => _ShoppingState();
}

class _ShoppingState extends State<Shopping> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    var lanProvider = Provider.of<LanProvider>(context);
    dialog(title) {
      return showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return AlertDialog(
              title: Text(
                title,
                textAlign: lanProvider.isEn ? TextAlign.start : TextAlign.end,
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
                    child: Text(lanProvider.texts('ok'),
                        style: const TextStyle(fontSize: 19)),
                    onTap: () => Navigator.of(context).pop()),
              ],
            );
          });
    }

    bottomSheet() {
      return Directionality(
        textDirection: lanProvider.isEn ? TextDirection.ltr : TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              lanProvider.texts('choose address'),
              style: TextStyle(
                  color: CupertinoColors.black, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Theme.of(context).canvasColor,
            elevation: 1,
            actions: [
              IconButton(
                icon: Icon(
                  Icons.add,
                  color: Colors.blue,
                ),
                onPressed: () => Navigator.of(context).pushNamed('addAddress'),
              ),
            ],
          ),
          body: ListView.builder(
            itemCount: provider.loc.length,
            itemBuilder: (BuildContext context, int index) {
              if (provider.loc.isEmpty)
                return Center(
                  child: TextButton(
                      onPressed: () =>
                          Navigator.of(context).pushNamed('addAddress'),
                      child: Text(lanProvider.texts('new address'),
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ))),
                );
              return Card(
                elevation: 0.5,
                child: ListTile(
                  onTap: () {
                    setState(() {
                      provider.checkOut['area'] = provider.loc[index].area;
                      provider.checkOut['street'] = provider.loc[index].street;
                      provider.checkOut['phoneNum'] =
                          provider.loc[index].phoneNum;
                    });
                    Navigator.of(context).pushNamed('checkOut');
                  },
                  title: Text(provider.loc[index].area),
                  subtitle: Text(lanProvider.texts('street:') +
                      provider.loc[index].street +
                      "\n" +
                      lanProvider.texts('phone:') +
                      provider.loc[index].phoneNum),
                  isThreeLine: true,
                ),
              );
            },
          ),
        ),
      );
    }

    return Directionality(
        textDirection: lanProvider.isEn ? TextDirection.ltr : TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              lanProvider.texts('food cart'),
              style: const TextStyle(fontSize: 20),
            ),
            actions: provider.myCart.isEmpty
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
                                  lanProvider.texts('clear everything?'),
                                  style: const TextStyle(fontSize: 23),
                                ),
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 7),
                                elevation: 24,
                                content: Container(
                                  height: 46,
                                  child: const Divider(),
                                  alignment: Alignment.topCenter,
                                ),
                                actions: [
                                  InkWell(
                                    child: Text(
                                      lanProvider.texts('yes?'),
                                      style: const TextStyle(
                                          fontSize: 19, color: Colors.red),
                                    ),
                                    onTap: () {
                                      provider.myCartClear();
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  const SizedBox(width: 11),
                                  InkWell(
                                      child: Text(lanProvider.texts('cancel?'),
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
          body: provider.myCart.length == 0
              ? Center(
                  child: Text(
                  lanProvider.texts('empty cart'),
                  style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                ))
              : ListView.builder(
                  itemCount: provider.myCart.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 3,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const SizedBox(height: 20),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                    alignment: lanProvider.isEn
                                        ? Alignment.topLeft
                                        : Alignment.topRight,
                                    child: Text(
                                      provider.myCart[index].mealName,
                                      style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    alignment: lanProvider.isEn
                                        ? Alignment.topLeft
                                        : Alignment.topRight,
                                    child: Text(
                                      provider.myCart[index].description,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                          fontSize: 16),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                    alignment: lanProvider.isEn
                                        ? Alignment.bottomLeft
                                        : Alignment.bottomRight,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 7),
                                      child: Text(
                                        lanProvider.texts('price') +
                                            " " +
                                            provider.myCart[index].mealPrice +
                                            " " +
                                            lanProvider.texts('jd'),
                                        style: const TextStyle(
                                            fontSize: 16, color: Colors.pink),
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
                                      provider.mealID =
                                          provider.myCart[index].foodID;
                                    });
                                    await provider.removeFoodCart(provider.myCart[index].mealPrice);
                                  } catch (e) {
                                    dialog(
                                        lanProvider.texts('Error occurred !'));
                                    print(e);
                                  }
                                },
                              ),
                              Text(provider.myCart[index].quantity.toString()),
                              IconButton(
                                icon: const Icon(
                                  Icons.add,
                                  color: Colors.green,
                                ),
                                onPressed: () async {
                                  try {
                                    setState(() {
                                      provider.mealID =
                                          provider.myCart[index].foodID;
                                    });
                                    await provider.addFoodCart(
                                        provider.myCart[index].mealName,
                                        provider.myCart[index].mealPrice,
                                        provider.myCart[index].description);
                                  } catch (e) {
                                    dialog(
                                        lanProvider.texts('Error occurred !'));
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
            height: 100,
            child: Column(children: [
              if (provider.myCart.isNotEmpty)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(lanProvider.texts('cart total :'),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    Text(provider.total.toString() + " ",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                    Text(lanProvider.texts('jd'),
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
              if (provider.myCart.isNotEmpty)
                provider.isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : TextButton(
                        onPressed: () async {
                          if (provider.long == null && provider.lat == null) {
                            try {
                              setState(() {
                                provider.isLoading = true;
                              });
                              await provider.sendLocationToDB(context);
                              setState(() {
                                provider.isLoading = false;
                              });
                              if (provider.approved)
                                showModalBottomSheet(
                                    context: context,
                                    builder: (_) => bottomSheet());
                              print('done');
                            } on FirebaseException catch (e) {
                              setState(() {
                                provider.isLoading = false;
                              });
                              dialog(lanProvider.texts('Error occurred !'));
                              print(e.message);
                            } catch (e) {
                              setState(() {
                                provider.isLoading = false;
                              });
                              dialog(lanProvider.texts('Error occurred !'));
                              print(e);
                            }
                          } else {
                            showModalBottomSheet(
                                context: context,
                                builder: (_) => bottomSheet());
                          }
                        },
                        child: Text(lanProvider.texts('Next'),
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ))),
            ]),
          ),
        ));
  }
}
