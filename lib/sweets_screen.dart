import 'package:app/Myprovider.dart';
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

class _SweetScreenState extends State<SweetScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      Provider.of<MyProvider>(context, listen: false).fetchMealsSweets(
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
    return Directionality(
      textDirection: lanProvider.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(provider.restaurantName),
            bottom: TabBar(
              tabs: [
                Tab(text: lanProvider.texts('tab4')),
                Tab(text: lanProvider.texts('tab5')),
                Tab(text: lanProvider.texts('tab3')),
              ],
            ),
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
          body: TabBarView(
            children: <Widget>[
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

class First extends StatefulWidget {
  @override
  _FirstState createState() => _FirstState();
}

class _FirstState extends State<First> {
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

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('sweets/${provider.restaurantName}/kunafeh')
          .snapshots(),
      builder: (ctx, snapshot) {
        // if (snapshot.connectionState == ConnectionState.waiting)
        //   return Center(child: CircularProgressIndicator());
        if (snapshot.hasError)
          return Center(
              child: Text(lanProvider.texts('something went wrong !')));
        return Scrollbar(
          child: ListView.builder(
            itemCount: snapshot.data?.docs.length??0,
            itemBuilder: (context, int index) {
              var resData = snapshot.data!.docs;
              return Card(
                elevation: 2.5,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: Row(
                          children: [
                            if (provider.isLoading)
                              const CircularProgressIndicator(),
                            if (!provider.isLoading)
                              IconButton(
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
                                    dialog(
                                        lanProvider.texts('Error occurred !'));
                                    print(e);
                                  }
                                },
                              ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: height*0.02),
                                Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    resData[index]['meal name'],
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    resData[index]['description'],
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.grey),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  alignment: Alignment.bottomLeft,
                                  margin: const EdgeInsets.only(top: 17),
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
                                    .myCart[
                                        provider.getIndex(resData[index].id)]
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
                              if (provider.myCart.length!=0 && provider.restaurantName!=provider.myCart[0].resName)
                                return dialog(lanProvider.texts('foodCart'));
                              await provider.addFoodCart(resData[index]['meal name'],
                                  resData[index]['meal price'],resData[index]['description']);
                            }),
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

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('sweets/${provider.restaurantName}/cake')
          .snapshots(),
      builder: (ctx, snapshot) {
        // if (snapshot.connectionState == ConnectionState.waiting)
        //   return Center(child: CircularProgressIndicator());
        if (snapshot.hasError)
          return Center(
              child: Text(lanProvider.texts('something went wrong !')));
        return Scrollbar(
          child: ListView.builder(
            itemCount: snapshot.data?.docs.length??0,
            itemBuilder: (context, int index) {
              var resData = snapshot.data!.docs;
              return Card(
                elevation: 2.5,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: Row(
                          children: [
                            if (provider.isLoading)
                              const CircularProgressIndicator(),
                            if (!provider.isLoading)
                              IconButton(
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
                                    dialog(
                                        lanProvider.texts('Error occurred !'));
                                    print(e);
                                  }
                                },
                              ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: height*0.02),
                                Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    resData[index]['meal name'],
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    resData[index]['description'],
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.grey),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  alignment: Alignment.bottomLeft,
                                  margin: const EdgeInsets.only(top: 17),
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
                                    .myCart[
                                        provider.getIndex(resData[index].id)]
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
                              await provider.addFoodCart(resData[index]['meal name'],
                                  resData[index]['meal price'],resData[index]['description']);
                            }),
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
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('sweets/${provider.restaurantName}/others')
          .snapshots(),
      builder: (ctx, snapshot) {
        // if (snapshot.connectionState == ConnectionState.waiting)
        //   return Center(child: CircularProgressIndicator());
        if (snapshot.hasError)
          return Center(
              child: Text(lanProvider.texts('something went wrong !')));
        return Scrollbar(
          child: ListView.builder(
            itemCount: snapshot.data?.docs.length??0,
            itemBuilder: (context, int index) {
              var resData = snapshot.data!.docs;
              return Card(
                elevation: 2.5,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: Row(
                          children: [
                            if (provider.isLoading)
                              const CircularProgressIndicator(),
                            if (!provider.isLoading)
                              IconButton(
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
                                    dialog(
                                        lanProvider.texts('Error occurred !'));
                                    print(e);
                                  }
                                },
                              ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: height*0.02),
                                Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    resData[index]['meal name'],
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    resData[index]['description'],
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.grey),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  alignment: Alignment.bottomLeft,
                                  margin: const EdgeInsets.only(top: 17),
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
                                    .myCart[
                                        provider.getIndex(resData[index].id)]
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
                              await provider.addFoodCart(resData[index]['meal name'],
                                  resData[index]['meal price'],resData[index]['description']);
                            }),
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
