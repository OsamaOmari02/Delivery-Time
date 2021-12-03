import 'package:app/Myprovider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Drawer.dart';
import 'LanguageProvider.dart';

class MyFavourites extends StatefulWidget {
  @override
  _MyFavouritesState createState() => _MyFavouritesState();
}

var stream;
class _MyFavouritesState extends State<MyFavourites> {
  var user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    Provider.of<MyProvider>(context, listen: false).fetchFav();
    setState(() {
      stream = FirebaseFirestore.instance
          .collection('/favorites/${user!.uid}/myFavorites')
          .snapshots();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    dialog(title) {
      return showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return AlertDialog(
              title: Text(
                title,
                textAlign:  Provider.of<LanProvider>(context,listen: false).isEn ? TextAlign.start : TextAlign.end,
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
                    child: Text( Provider.of<LanProvider>(context,listen: false).texts('ok'),
                        style: const TextStyle(fontSize: 19)),
                    onTap: () => Navigator.of(context).pop()),
              ],
            );
          });
    }

    Future<bool> _onWillPop() async {
      await Navigator.of(context).pushReplacementNamed('MyHomepage');
      throw "";
    }
    return Directionality(
      textDirection:  Provider.of<LanProvider>(context,listen: false).isEn ? TextDirection.ltr : TextDirection.rtl,
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          drawer: MyDrawer(),
          appBar: AppBar(
            title: Text( Provider.of<LanProvider>(context,listen: false).texts('my favorites')),
            centerTitle: true,
          ),
          body: StreamBuilder<QuerySnapshot>(
            stream: stream,
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return const Center(child: const CircularProgressIndicator());
              return Scrollbar(
                child: Stack(children: [
                  Provider.of<MyProvider>(context,listen: false).myFavorites.length == 0
                      ? Center(
                          child: Text(
                            Provider.of<LanProvider>(context,listen: false).texts('no meals were added to favorites'),
                          style: const TextStyle(
                              fontSize: 18, fontStyle: FontStyle.italic),
                        ))
                      : ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, int index) {
                            var resData = snapshot.data!.docs;
                            if (resData.length != 0)
                              return Card(
                                elevation: 2.5,
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        child: Row(
                                          children: [
                                            if (Provider.of<MyProvider>(context,listen: false).isLoading)
                                              const CircularProgressIndicator(),
                                            if (!Provider.of<MyProvider>(context,listen: false).isLoading)
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.favorite,
                                                  color: Colors.red,
                                                ),
                                                onPressed: () async {
                                                  try {
                                                    setState(() {
                                                      Provider.of<MyProvider>(context,listen: false).isLoading = true;
                                                      Provider.of<MyProvider>(context,listen: false).mealID =
                                                          resData[index].id;
                                                    });
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection(
                                                            'favorites/${user!.uid}/myFavorites')
                                                        .doc(Provider.of<MyProvider>(context,listen: false).mealID)
                                                        .delete()
                                                        .then((value) {
                                                      Provider.of<MyProvider>(context,listen: false).myFavorites
                                                          .removeWhere((element) =>
                                                              element
                                                                  .myFavoriteID ==
                                                                  Provider.of<MyProvider>(context,listen: false).mealID);
                                                    });
                                                    setState(() {
                                                      Provider.of<MyProvider>(context,listen: false).isLoading = false;
                                                    });
                                                  } on FirebaseException catch (e) {
                                                    setState(() {
                                                      Provider.of<MyProvider>(context,listen: false).isLoading = false;
                                                    });
                                                    dialog(e.message);
                                                    print(e);
                                                  } catch (e) {
                                                    setState(() {
                                                      Provider.of<MyProvider>(context,listen: false).isLoading = false;
                                                    });
                                                    dialog( Provider.of<LanProvider>(context,listen: false).texts(
                                                        'Error occurred !'));
                                                    print(e);
                                                  }
                                                },
                                              ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                SizedBox(height: height*0.02),
                                                Container(
                                                  child: Text(
                                                    resData[index]['meal name'],
                                                    style: const TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w800),
                                                  ),
                                                ),
                                                SizedBox(height: height*0.015),
                                                Container(
                                                  child: Text(
                                                    resData[index]['description'],
                                                    style: const TextStyle(
                                                        fontSize: 15, color: Colors.grey),
                                                  ),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 17),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(vertical: 7),
                                                    child: Text(
                                                      Provider.of<LanProvider>(context,listen: false).texts('price') +
                                                          " " +
                                                          resData[index]
                                                              ['meal price'] +
                                                          " " +
                                                          Provider.of<LanProvider>(context,listen: false).texts('jd'),
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.pink),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Row(children: [
                                      Text(
                                        resData[index]['resName'],
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                      const Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: const Icon(Icons.arrow_forward),
                                      ),
                                    ]),
                                  ],
                                ),
                              );
                            return Center(
                                child: Text(
                                    Provider.of<LanProvider>(context,listen: false).texts(
                                        'no meals were added to favorites'),
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontStyle: FontStyle.italic)));
                          },
                        ),
                ]),
              );
            },
          ),
        ),
      ),
    );
  }
}
