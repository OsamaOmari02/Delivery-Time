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

class _MyFavouritesState extends State<MyFavourites> {
  @override
  void initState() {
    Provider.of<MyProvider>(context, listen: false).fetchFav();
    super.initState();
  }

  int _itemCount = 0;

  @override
  Widget build(BuildContext context) {
    var lanProvider = Provider.of<LanProvider>(context);
    var provider = Provider.of<MyProvider>(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var user = FirebaseAuth.instance.currentUser;
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

    return Directionality(
      textDirection: lanProvider.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          title: Text(lanProvider.texts('my favorites')),
          centerTitle: true,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('/favorites/${user!.uid}/myFavorites')
              .snapshots(),
          builder: (ctx, snapshot) {
            // if (!snapshot.hasData)
            //   return Center(child: Text(lanProvider.texts('no meals were added to favorites'),
            //     style: TextStyle(fontSize: 17,fontStyle: FontStyle.italic)));
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(child: const CircularProgressIndicator());
            return Scrollbar(
              child: Stack(children: [
                ListView.builder(
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
                                    if (provider.isLoading)
                                      const CircularProgressIndicator(),
                                    if (!provider.isLoading)
                                      IconButton(
                                        icon: const Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                        ),
                                        onPressed: () async {
                                          try {
                                            setState(() {
                                              provider.isLoading = true;
                                              provider.mealID =
                                                  resData[index].id;
                                            });
                                            await FirebaseFirestore.instance
                                                .collection(
                                                    'favorites/${user.uid}/myFavorites')
                                                .doc(provider.mealID)
                                                .delete()
                                                .then((value) {
                                              provider.myFavorites.removeWhere(
                                                  (element) =>
                                                      element.myFavoriteID ==
                                                      provider.mealID);
                                            });
                                            print(
                                                "provider.mealID ${provider.mealID}");
                                            setState(() {
                                              provider.isLoading = false;
                                            });
                                          } on FirebaseException catch (e) {
                                            setState(() {
                                              provider.isLoading = false;
                                            });
                                            dialog(e.message);
                                            print(e);
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
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          const SizedBox(height: 20),
                                          Container(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              resData[index]['meal name'],
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w800),
                                            ),
                                          ),
                                          // const SizedBox(height: 10),
                                          // Container(
                                          //   padding: const EdgeInsets.only(left: 10),
                                          //   child: Text(
                                          //     resData[index]['description'],
                                          //     style: const TextStyle(
                                          //         fontSize: 15, color: Colors.grey),
                                          //   ),
                                          // ),
                                          Container(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            alignment: Alignment.bottomLeft,
                                            margin:
                                                const EdgeInsets.only(top: 17),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 7),
                                              child: Text(
                                                lanProvider.texts('price') +
                                                    " " +
                                                    resData[index]
                                                        ['meal price'] +
                                                    " " +
                                                    lanProvider.texts('jd'),
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.pink),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Row(children: [
                              Container(
                                  child: Image.asset(
                                    provider.restaurantName=="grill house"?
                                    'file/grill_house.jpg':'file/دلع_كرشك.jpg',
                                fit: BoxFit.fill,
                              ),
                                height: 80,
                              ),
                            ]),
                          ],
                        ),
                      );
                    return Center(
                        child: Text(
                            lanProvider
                                .texts('no meals were added to favorites'),
                            style: const TextStyle(
                                fontSize: 17, fontStyle: FontStyle.italic)));
                  },
                ),
                // Opacity(
                //   opacity: provider.t==0?0.4:1,
                //   child: Container(
                //     padding:  const EdgeInsets.fromLTRB(12,0,12,15),
                //     alignment: Alignment.bottomCenter,
                //     child: Container(
                //       decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),),
                //       child: ElevatedButton(
                //         style: ElevatedButton.styleFrom(
                //           elevation: 4,
                //           primary:Colors.orange,
                //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15),),
                //         ),
                //         onPressed: () =>Navigator.of(context).pushNamed('Shopping'),
                //         child: Row(
                //           children: <Widget>[
                //             const Icon(Icons.shopping_basket_outlined,color: Colors.white,),
                //             const SizedBox(width: 7),
                //             Text(
                //               lanProvider.texts('food cart'),
                //               style: const TextStyle(fontSize: 17, color: Colors.white),
                //             ),
                //             SizedBox(width: width*0.23),
                //             Text(
                //               lanProvider.texts('total'),
                //               style: const TextStyle(fontSize: 17, color: Colors.white),
                //             ),
                //             const SizedBox(width: 5),
                //             Text(
                //               "${provider.t}",
                //               style: const TextStyle(fontSize: 16, color: Colors.white),
                //             ),
                //             const SizedBox(width: 5),
                //             Text(
                //               lanProvider.texts('jd'),
                //               style: const TextStyle(fontSize: 16, color: Colors.white),
                //             ),
                //           ],
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
              ]),
            );
          },
        ),
      ),
    );
  }
}
