import 'dart:developer';

import 'package:app/Myprovider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'LanguageProvider.dart';

class Store extends StatefulWidget {
  @override
  _StoreState createState() => _StoreState();
}
class _StoreState extends State<Store> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value){
      Provider.of<MyProvider>(context,listen: false).
      fetchMeals(Provider.of<MyProvider>(context,listen: false).restaurantName);
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
      textDirection: lanProvider.isEn?TextDirection.ltr : TextDirection.rtl,
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(provider.restaurantName),
            // actions: <Widget>[
            //   IconButton(
            //       icon: Icon(Icons.search),
            //       onPressed: (){
            //
            //       }
            //       ),
            // ],
            bottom: TabBar(
              tabs: [
                Tab(text: lanProvider.texts('tab1')),
                Tab(text: lanProvider.texts('tab2')),
                Tab(text: lanProvider.texts('tab3')),
              ],
            ),
          ),
          body: Stack(
            children: [
              TabBarView(
                children: <Widget>[
                  First(),
                  Second(),
                  Third(),
                ],
              ),
              Opacity(
                opacity: provider.t==0?0.4:1,
                child: Container(
                  padding:  const EdgeInsets.fromLTRB(12,0,12,15),
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 4,
                          primary:Colors.orange,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15),),
                      ),
                      onPressed: () =>Navigator.of(context).pushNamed('Shopping'),
                      child: Row(
                        children: <Widget>[
                          const Icon(Icons.shopping_basket_outlined,color: Colors.white,),
                          const SizedBox(width: 7),
                          Text(
                            lanProvider.texts('food cart'),
                            style: const TextStyle(fontSize: 17, color: Colors.white),
                          ),
                          SizedBox(width: width*0.23),
                          Text(
                            lanProvider.texts('total'),
                            style: const TextStyle(fontSize: 17, color: Colors.white),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "${provider.t}",
                            style: const TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            lanProvider.texts('jd'),
                            style: const TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// -------------------------search-----------------------------
// class Search extends SearchDelegate{
//   @override
//   List<Widget> buildActions(BuildContext context) {
//     // TODO: implement buildActions
//     throw UnimplementedError();
//   }
//
//   @override
//   Widget buildLeading(BuildContext context) {
//     // TODO: implement buildLeading
//     throw UnimplementedError();
//   }
//
//   @override
//   Widget buildResults(BuildContext context) {
//     // TODO: implement buildResults
//     throw UnimplementedError();
//   }
//
//   @override
//   Widget buildSuggestions(BuildContext context) {
//     // TODO: implement buildSuggestions
//     throw UnimplementedError();
//   }
//
// }

//-------------------------------1----------------------------
class First extends StatefulWidget {
  @override
  _FirstState createState() => _FirstState();
}

class _FirstState extends State<First> {
  int _itemCount = 0;

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
          .collection('/restaurants/${provider.restaurantName}/shawarma').snapshots(),
      builder: (ctx, snapshot) {
        if(!snapshot.hasData)
          return Center(child: const CircularProgressIndicator());
        return Scrollbar(
          child: ListView.builder(
            itemCount: snapshot.data!.docs.length,
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
                              if (provider.isLoading) const CircularProgressIndicator(),
                              if (!provider.isLoading) IconButton(
                                icon: Icon(
                                  provider.isMyFav(resData[index].id)?
                                  Icons.favorite:Icons.favorite_border,
                                  color: Colors.red,
                                ),
                                onPressed: () async{
                                  try{
                                    setState(() {
                                      provider.isLoading = true;
                                      provider.mealID = resData[index].id;
                                    });
                                    provider.toggleFavourite();
                                    setState(() {
                                      provider.isLoading = false;
                                    });
                                  } on FirebaseException catch (e){
                                    setState(() {
                                      provider.isLoading = false;
                                    });
                                    dialog(e.message);
                                    print(e.message);
                                  } catch (e){
                                    setState(() {
                                      provider.isLoading = false;
                                    });
                                    dialog(lanProvider.texts('Error occurred !'));
                                    print(e);
                                  }
                                },
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const SizedBox(height: 20),
                                    Container(
                                      padding: const EdgeInsets.only(left: 10),
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        resData[index]['meal name'],
                                        style:
                                        const TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
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
                                        padding: const EdgeInsets.symmetric(vertical: 7),
                                        child: Text(
                                          lanProvider.texts('price') +" "+
                                              resData[index]['meal price'] +
                                              " " + lanProvider.texts('jd'),
                                          style: const TextStyle(fontSize: 16, color: Colors.pink),
                                        ),
                                      ),
                                    ),
                                    // SizedBox(height: 50),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          _itemCount != 0
                              ? IconButton(
                            icon: const Icon(
                              Icons.remove,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              provider.subtractPrice(int.parse(resData[index]['meal price']));
                              setState (()=>_itemCount--);
                            },
                          )
                              : Container(),
                          Text(_itemCount.toString()),
                          IconButton(
                              icon: const Icon(
                                Icons.add,
                                color: Colors.green,
                              ),
                              onPressed: () {
                                provider.addPrice(int.parse(resData[index]['meal price']));
                                setState(() => _itemCount++);
                              }
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
  int _itemCount = 0;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var provider = Provider.of<MyProvider>(context);
    var lanProvider = Provider.of<LanProvider>(context);
    var res = FirebaseAuth.instance.currentUser;
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
          .collection('/restaurants/${provider.restaurantName}/snacks')
          .snapshots(),
      builder: (ctx, snapshot) {
        if(!snapshot.hasData)
          return Center(child: CircularProgressIndicator());
        return Scrollbar(
          child: ListView.builder(
            itemCount: snapshot.data!.docs.length,
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
                            if (provider.isLoading) const CircularProgressIndicator(),
                            if (!provider.isLoading) IconButton(
                              icon: Icon(
                                provider.isMyFav(resData[index].id)?
                                Icons.favorite:Icons.favorite_border,
                                color: Colors.red,
                              ),
                              onPressed: () async{
                                try{
                                  setState(() {
                                    provider.isLoading = true;
                                    provider.mealID = resData[index].id;
                                  });
                                  provider.toggleFavourite();
                                  setState(() {
                                    provider.isLoading = false;
                                  });
                                } on FirebaseException catch (e){
                                  setState(() {
                                    provider.isLoading = false;
                                  });
                                  dialog(e.message);
                                  print(e.message);
                                } catch (e){
                                  setState(() {
                                    provider.isLoading = false;
                                  });
                                  dialog(lanProvider.texts('Error occurred !'));
                                  print(e);
                                }
                              },
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const SizedBox(height: 20),
                                  Container(
                                    padding: const EdgeInsets.only(left: 10),
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      resData[index]['meal name'],
                                      style:
                                      const TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
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
                                      padding: const EdgeInsets.symmetric(vertical: 7),
                                      child: Text(
                                        lanProvider.texts('price') +" "+
                                            resData[index]['meal price'] +
                                            " " + lanProvider.texts('jd'),
                                        style: const TextStyle(fontSize: 16, color: Colors.pink),
                                      ),
                                    ),
                                  ),
                                  // SizedBox(height: 50),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        _itemCount != 0
                            ? IconButton(
                          icon: const Icon(
                            Icons.remove,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            provider.subtractPrice(int.parse(resData[index]['meal price']));
                            setState (()=>_itemCount--);
                          },
                        )
                            : Container(),
                        Text(_itemCount.toString()),
                        IconButton(
                            icon: const Icon(
                              Icons.add,
                              color: Colors.green,
                            ),
                            onPressed: () {
                              provider.addPrice(int.parse(resData[index]['meal price']));
                              setState(() => _itemCount++);
                            }
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
//-----------------------------3-----------------------
class Third extends StatefulWidget {
  @override
  _ThirdState createState() => _ThirdState();
}
class _ThirdState extends State<Third> {
  int _itemCount = 0;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var provider = Provider.of<MyProvider>(context);
    var lanProvider = Provider.of<LanProvider>(context);
    var res = FirebaseAuth.instance.currentUser;
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
          .collection('/restaurants/${provider.restaurantName}/others')
          .snapshots(),
      builder: (ctx, snapshot) {
        if(!snapshot.hasData)
          return Center(child: CircularProgressIndicator());
        return Scrollbar(
          child: ListView.builder(
            itemCount: snapshot.data!.docs.length,
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
                            if (provider.isLoading) const CircularProgressIndicator(),
                            if (!provider.isLoading) IconButton(
                              icon: Icon(
                                provider.isMyFav(resData[index].id)?
                                Icons.favorite:Icons.favorite_border,
                                color: Colors.red,
                              ),
                              onPressed: () async{
                                try{
                                  setState(() {
                                    provider.isLoading = true;
                                    provider.mealID = resData[index].id;
                                  });
                                  provider.toggleFavourite();
                                  setState(() {
                                    provider.isLoading = false;
                                  });
                                } on FirebaseException catch (e){
                                  setState(() {
                                    provider.isLoading = false;
                                  });
                                  dialog(e.message);
                                  print(e.message);
                                } catch (e){
                                  setState(() {
                                    provider.isLoading = false;
                                  });
                                  dialog(lanProvider.texts('Error occurred !'));
                                  print(e);
                                }
                              },
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const SizedBox(height: 20),
                                  Container(
                                    padding: const EdgeInsets.only(left: 10),
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      resData[index]['meal name'],
                                      style:
                                      const TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
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
                                      padding: const EdgeInsets.symmetric(vertical: 7),
                                      child: Text(
                                        lanProvider.texts('price') +" "+
                                            resData[index]['meal price'] +
                                            " " + lanProvider.texts('jd'),
                                        style:const TextStyle(fontSize: 16, color: Colors.pink),
                                      ),
                                    ),
                                  ),
                                  // SizedBox(height: 50),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        _itemCount != 0
                            ? IconButton(
                          icon: const Icon(
                            Icons.remove,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            provider.subtractPrice(int.parse(resData[index]['meal price']));
                            setState (()=>_itemCount--);
                          },
                        )
                            : Container(),
                        Text(_itemCount.toString()),
                        IconButton(
                            icon: const Icon(
                              Icons.add,
                              color: Colors.green,
                            ),
                            onPressed: () {
                              provider.addPrice(int.parse(resData[index]['meal price']));
                              setState(() => _itemCount++);
                            }
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