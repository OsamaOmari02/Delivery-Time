import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
                onPressed: () {}),
          ],
          bottom: TabBar(
            tabs: [
              Tab(
                text: "Shawarmah",
              ),
              Tab(
                text: "snacks",
              ),
              Tab(
                text: "Others",
              ),
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

  Card theCommodity(img, name1, type, name2, name3, price,id) {
    return Card(
      key: Key(id),
      child: Row(
        children: <Widget>[
          // Container(
          //   child: Expanded(
          //     flex: 1,
          //     child: Image.asset(img),
          //   ),
          // ),
          // you can't change height in last Container
          // height: height*0.148,
          Expanded(
            flex: 2,
            child: Container(
              // alignment: Alignment.center,
              // height: height * 0.18,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.favorite_border,
                      color: Colors.red,
                    ), onPressed: () {},
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Name: ${name1}",
                          style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        alignment: Alignment.bottomLeft,
                        // decoration: BoxDecoration(border: Border.all(color: Colors.red),),
                        // padding: EdgeInsets.only(top: 5),
                        margin: EdgeInsets.only(top: 17),
                        child: Text(
                          "Price: ${price} JD",
                          style: TextStyle(fontSize: 17, color: Colors.red),
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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return ListView(
      children: <Widget>[
        Divider(
          height: 10,
        ),
        Container(
          height: height * 0.16,
          child: theCommodity("images/1j.jpg", "ss", "ww", "ee", "rr", "44","111"),
        ),
        Container(
          height: height * 0.16,
          child: theCommodity("images/1j.jpg", "ss", "ww", "ee", "rr", "44","111"),
        ),
        Container(
          height: height * 0.16,
          child: theCommodity("images/1j.jpg", "ss", "ww", "ee", "rr", "44","222"),
        ),
        Container(
          height: height * 0.16,
          child: theCommodity("images/1j.jpg", "ss", "ww", "ee", "rr", "44","444"),
        ),
        Container(
          height: height * 0.16,
          child: theCommodity("images/1j.jpg", "ss", "ww", "ee", "rr", "44","555"),
        ),
        SizedBox(height: height*0.1),
      ],
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