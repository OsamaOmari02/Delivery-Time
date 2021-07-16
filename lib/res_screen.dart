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
  //========Functions=======//

  //=========End Functions===========//

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var provider = Provider.of<MyProvider>(context);
    // Container funHorizantal(img, title) {
    //   return Container(
    //     width: width * 0.4,
    //     child: ListTile(
    //       title: Image.asset(
    //         img,
    //         height: height * 0.18,
    //         alignment: Alignment.center,
    //         fit: BoxFit.contain,
    //       ),
    //       subtitle: Container(
    //         child: Text(title,
    //             style: TextStyle(
    //                 color: Colors.black,
    //                 fontSize: 17,
    //                 fontWeight: FontWeight.w500),
    //             textAlign: TextAlign.center),
    //       ),
    //     ),
    //   );
    // }

    Text nameOfStore(name) {
      return Text(name);
    }

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: nameOfStore("name"),
          actions: <Widget>[
            // padding: EdgeInsets.only(left: 10),
            IconButton(
                icon: Icon(
                  Icons.search,
                ),
                onPressed: () {},
                ),
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
                Second(),

              ],
            ),
            Container(
              padding:  EdgeInsets.fromLTRB(12,0,12,15),
              // padding: EdgeInsets.only(left: width*0.08),
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 4,
                      primary:Colors.orange,
                    // shadowColor: Colors.orange,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15),),
                  ),
                  onPressed: () {},
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.shopping_cart_outlined,color: Colors.white,),
                      SizedBox(width: 5),
                      Text(
                        "Add items",
                        style: TextStyle(fontSize: 17, color: Colors.white),
                      ),
                      SizedBox(width: width*0.17),
                      Text(
                        "Total JD",
                        style: TextStyle(fontSize: 17, color: Colors.white),
                      ),
                      SizedBox(width: 2),
                      Text(
                        "555.000",
                        style: TextStyle(fontSize: 17, color: Colors.white),
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

//-------Pages appBar-------//
//-------1
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
                          child: Text(
                            "Price: $price JD",
                            style: TextStyle(fontSize: 16, color: Colors.brown),
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
                  onPressed: () => setState(() => _itemCount--),
                )
                    : Container(),
                Text(_itemCount.toString()),
                IconButton(
                  icon: Icon(
                    Icons.add,
                    color: Colors.green,
                  ),
                  onPressed: () => setState(() => _itemCount++),
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
//-------2
class Second extends StatefulWidget {
  @override
  _SecondState createState() => _SecondState();
}

class _SecondState extends State<Second> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Icon(
        Icons.add,
        size: 100.0,
        color: Colors.green,
      ),
    );
  }
}