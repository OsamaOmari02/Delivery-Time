import 'dart:ffi';

import 'package:app/Myprovider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Store extends StatefulWidget {
  @override
  _StoreState createState() => _StoreState();
}
class _StoreState extends State<Store> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var provider = Provider.of<MyProvider>(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('name'),
          actions: <Widget>[
            // padding: EdgeInsets.only(left: 10),
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {}),
          ],
          bottom: TabBar(
            tabs: [
              Tab(text: "Shawarmah"),
              Tab(text: "snacks"),
              Tab(text: "Others"),
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
            Container(
              padding:  EdgeInsets.fromLTRB(12,0,12,15),
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
                      Icon(Icons.shopping_basket_outlined,color: Colors.white,),
                      SizedBox(width: 7),
                      Text(
                        "Food Cart",
                        style: TextStyle(fontSize: 17, color: Colors.white),
                      ),
                      SizedBox(width: width*0.23),
                      Text(
                        "Total JD",
                        style: TextStyle(fontSize: 17, color: Colors.white),
                      ),
                      SizedBox(width: 5),
                      Text(
                        "${provider.t}",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
    var res = FirebaseAuth.instance.currentUser;
    Card theCommodity(name,price,id) {
      return Card(
        key: Key(id),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        provider.isFavourite?Icons.favorite:Icons.favorite_border,
                        color: Colors.red,
                      ),
                      onPressed: ()=>provider.toggleFavourite(),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 20),
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          alignment: Alignment.topLeft,
                          child: Text(
                            name,
                            style:
                            TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          alignment: Alignment.bottomLeft,
                          margin: EdgeInsets.only(top: 17),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 7),
                            child: Text(
                              "Price: $price JD",
                              style: TextStyle(fontSize: 16, color: Colors.pink),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                _itemCount != 0
                    ? IconButton(
                  icon: Icon(
                    Icons.remove,
                    color: Colors.red,
                  ),
                  onPressed: (){
                    provider.subtractPrice(1);
                    setState (()=>_itemCount--);
                    },
                )
                    : Container(),
                Text(_itemCount.toString()),
                IconButton(
                  icon: Icon(
                    Icons.add,
                    color: Colors.green,
                  ),
                  onPressed: () {
                    provider.addPrice(1);
                    setState(() => _itemCount++);
                  }
                ),
              ],
            ),
          ],
        ),
      );
    }
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('/restaurants/grill house/shawarmah')
          .snapshots(),
      builder: (ctx, snapshot) {
        if(!snapshot.hasData)
          return Center(child: CircularProgressIndicator());
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, int index) {
            var resData = snapshot.data!.docs;
            return theCommodity(resData[index]['meal name']
                ,resData[index]['price'],res!.uid);
          },
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
    var res = FirebaseAuth.instance.currentUser;
    Card theCommodity(name,price,id) {
      return Card(
        key: Key(id),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        provider.isFavourite?Icons.favorite:Icons.favorite_border,
                        color: Colors.red,
                      ),
                      onPressed: ()=>provider.toggleFavourite(),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 20),
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          alignment: Alignment.topLeft,
                          child: Text(
                            name,
                            style:
                            TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          alignment: Alignment.bottomLeft,
                          margin: EdgeInsets.only(top: 17),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 7),
                            child: Text(
                              "Price: $price JD",
                              style: TextStyle(fontSize: 16, color: Colors.pink),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                _itemCount != 0
                    ? IconButton(
                  icon: Icon(
                    Icons.remove,
                    color: Colors.red,
                  ),
                  onPressed: (){
                    provider.subtractPrice(1);
                    setState (()=>_itemCount--);
                  },
                )
                    : Container(),
                Text(_itemCount.toString()),
                IconButton(
                    icon: Icon(
                      Icons.add,
                      color: Colors.green,
                    ),
                    onPressed: () {
                      provider.addPrice(1);
                      setState(() => _itemCount++);
                    }
                ),
              ],
            ),
          ],
        ),
      );
    }
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('/restaurants/grill house/snacks')
          .snapshots(),
      builder: (ctx, snapshot) {
        if(!snapshot.hasData)
          return Center(child: CircularProgressIndicator());
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, int index) {
            var resData = snapshot.data!.docs;
            return theCommodity(resData[index]['meal name']
                ,resData[index]['price'],res!.uid);
          },
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
    var res = FirebaseAuth.instance.currentUser;
    Card theCommodity(name,price,id) {
      return Card(
        key: Key(id),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        provider.isFavourite?Icons.favorite:Icons.favorite_border,
                        color: Colors.red,
                      ),
                      onPressed: ()=>provider.toggleFavourite(),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 20),
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          alignment: Alignment.topLeft,
                          child: Text(
                            name,
                            style:
                            TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          alignment: Alignment.bottomLeft,
                          margin: EdgeInsets.only(top: 17),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 7),
                            child: Text(
                              "Price: $price JD",
                              style: TextStyle(fontSize: 16, color: Colors.pink),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                _itemCount != 0
                    ? IconButton(
                  icon: Icon(
                    Icons.remove,
                    color: Colors.red,
                  ),
                  onPressed: (){
                    provider.subtractPrice(1);
                    setState (()=>_itemCount--);
                  },
                )
                    : Container(),
                Text(_itemCount.toString()),
                IconButton(
                    icon: Icon(
                      Icons.add,
                      color: Colors.green,
                    ),
                    onPressed: () {
                      provider.addPrice(1);
                      setState(() => _itemCount++);
                    }
                ),
              ],
            ),
          ],
        ),
      );
    }
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('/restaurants/grill house/others')
          .snapshots(),
      builder: (ctx, snapshot) {
        if(!snapshot.hasData)
          return Center(child: CircularProgressIndicator());
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, int index) {
            var resData = snapshot.data!.docs;
            return theCommodity(resData[index]['meal name']
                ,resData[index]['price'],res!.uid);
          },
        );
      },
    );
  }
}