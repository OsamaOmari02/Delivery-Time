import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Myprovider.dart';

class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          centerTitle: true,
          title: Text('restaurant\'s name'),
          bottom: TabBar(
            tabs: [
              Tab(text: "shawarma"),
              Tab(text: "snacks"),
              Tab(text: "others"),
            ],
          ),
        ),
        body: Stack(children: [
          TabBarView(
            children: <Widget>[
              FirstAdmin(),
              SecondAdmin(),
              ThirdAdmin(),
            ],
          ),
        ]),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.of(context).pushNamed('addMeal'),
          child: Icon(Icons.add),
          backgroundColor: Colors.redAccent,
        ),
      ),
    );
  }
}

//--------------------------Edit-----------------------------------
class Edit extends StatefulWidget {
  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  TextEditingController _mealName = TextEditingController();
  TextEditingController _price = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Meal"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(height: 30),
            TextField(
              keyboardType: TextInputType.text,
              controller: _mealName,
              decoration: InputDecoration(
                labelText: "Meal Name",
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: _price,
              decoration: InputDecoration(
                labelText: "Meal Price",
                hintText: "ex: 2.00"
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(onPressed: (){}, child: Text("Save")),
          ],
        ),
      ),
    );
  }
  // User? res = FirebaseAuth.instance.currentUser;
  // Future editFun() async{
  //   FirebaseFirestore.instance.collection('/restaurants/${res!.uid}/')
  // }
}

//-------------------------addMeal-----------------------------
class AddMeal extends StatefulWidget {
  @override
  _AddMealState createState() => _AddMealState();
}

class _AddMealState extends State<AddMeal> {
  TextEditingController _mealName = TextEditingController();
  TextEditingController _price = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Meal"),
        centerTitle: true,
      ),
      body:  Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(height: 30),
            TextField(
              keyboardType: TextInputType.text,
              controller: _mealName,
              decoration: const InputDecoration(
                labelText: "Meal Name",
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: _price,
              decoration: const InputDecoration(
                labelText: "Meal Price",
                hintText: "ex: 2.00",
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(onPressed: (){}, child: const Text("Add")),
          ],
        ),
      ),
    );
  }

}

//-------------------------------1----------------------------
class FirstAdmin extends StatefulWidget {
  @override
  _FirstAdminState createState() => _FirstAdminState();
}

class _FirstAdminState extends State<FirstAdmin> {

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var provider = Provider.of<MyProvider>(context);
    var res = FirebaseAuth.instance.currentUser;
    dialog() {
      return showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return AlertDialog(
              title: const Text(
                "Are you sure you want to delete this meal?",
                style: TextStyle(fontSize: 23),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 7),
              elevation: 24,
              content: Container(
                height: 30,
                child: const Divider(),
                alignment: Alignment.topCenter,
              ),
              actions: [
                InkWell(
                  child: const Text(
                    "Yes",
                    style: TextStyle(fontSize: 19, color: Colors.red),
                  ),
                  onTap: (){},
                ),
                SizedBox(width: 11),
                InkWell(
                    child: const Text("Cancel", style: TextStyle(fontSize: 19)),
                    onTap: () => Navigator.of(context).pop()),
              ],
            );
          });
    }
    Card theCommodity(name, price, id) {
      return Card(
        key: Key(id),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                child: Row(
                  children: [
                    IconButton(onPressed: ()=>
                        Navigator.of(context).pushNamed('edit'),
                      icon: Icon(Icons.edit),color: Colors.blue,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 20),
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          alignment: Alignment.topLeft,
                          child: Text(
                            name,
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w800),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 10),
                          alignment: Alignment.bottomLeft,
                          margin: const EdgeInsets.only(top: 17),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 7),
                            child: Text(
                              "Price: $price JD",
                              style:
                                  const TextStyle(fontSize: 16, color: Colors.pink),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    IconButton(onPressed: dialog, icon: const Icon(Icons.delete),color: Colors.red,),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('/restaurants/grill house/shawarma')
          .snapshots(),
      builder: (ctx, snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());
        return Scrollbar(
          child: ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, int index) {
              var resData = snapshot.data!.docs;
              return theCommodity(resData[index]['meal name'],
                  resData[index]['price'], res!.uid);
            },
          ),
        );
      },
    );
  }
}

//-----------------------2--------------------------
class SecondAdmin extends StatefulWidget {
  @override
  _SecondAdminState createState() => _SecondAdminState();
}

class _SecondAdminState extends State<SecondAdmin> {
  int _itemCount = 0;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var provider = Provider.of<MyProvider>(context);
    var res = FirebaseAuth.instance.currentUser;
    dialog() {
      return showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return AlertDialog(
              title: const Text(
                "Are you sure you want to delete this meal?",
                style: TextStyle(fontSize: 23),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 7),
              elevation: 24,
              content: Container(
                height: 30,
                child: Divider(),
                alignment: Alignment.topCenter,
              ),
              actions: [
                InkWell(
                  child: const Text(
                    "Yes",
                    style: TextStyle(fontSize: 19, color: Colors.red),
                  ),
                  onTap: (){},
                ),
                SizedBox(width: 11),
                InkWell(
                    child: const Text("Cancel", style: TextStyle(fontSize: 19)),
                    onTap: () => Navigator.of(context).pop()),
              ],
            );
          });
    }
    Card theCommodity(name, price, id) {
      return Card(
        key: Key(id),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                child: Row(
                  children: [
                    IconButton(onPressed: ()=>
                        Navigator.of(context).pushNamed('edit'),
                      icon: Icon(Icons.edit),color: Colors.blue,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 20),
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          alignment: Alignment.topLeft,
                          child: Text(
                            name,
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w800),
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
                              style:
                              TextStyle(fontSize: 16, color: Colors.pink),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    IconButton(onPressed: dialog, icon: Icon(Icons.delete),color: Colors.red,),
                  ],
                ),
              ),
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
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());
        return Scrollbar(
            child: ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, int index) {
            var resData = snapshot.data!.docs;
            return theCommodity(
                resData[index]['meal name'], resData[index]['price'], res!.uid);
          },
        ));
      },
    );
  }
}

//-----------------------------3-----------------------
class ThirdAdmin extends StatefulWidget {
  @override
  _ThirdAdminState createState() => _ThirdAdminState();
}

class _ThirdAdminState extends State<ThirdAdmin> {
  int _itemCount = 0;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var provider = Provider.of<MyProvider>(context);
    var res = FirebaseAuth.instance.currentUser;
    dialog() {
      return showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return AlertDialog(
              title: const Text(
                "Are you sure you want to delete this meal?",
                style: TextStyle(fontSize: 23),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 7),
              elevation: 24,
              content: Container(
                height: 30,
                child: Divider(),
                alignment: Alignment.topCenter,
              ),
              actions: [
                InkWell(
                  child: const Text(
                    "Yes",
                    style: TextStyle(fontSize: 19, color: Colors.red),
                  ),
                  onTap: (){},
                ),
                SizedBox(width: 11),
                InkWell(
                    child: const Text("Cancel", style: TextStyle(fontSize: 19)),
                    onTap: () => Navigator.of(context).pop()),
              ],
            );
          });
    }
    Card theCommodity(name, price, id) {
      return Card(
        key: Key(id),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                child: Row(
                  children: [
                    IconButton(onPressed: ()=>
                        Navigator.of(context).pushNamed('edit'),
                      icon: Icon(Icons.edit),color: Colors.blue,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 20),
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          alignment: Alignment.topLeft,
                          child: Text(
                            name,
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w800),
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
                              style:
                              TextStyle(fontSize: 16, color: Colors.pink),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    IconButton(onPressed: dialog, icon: Icon(Icons.delete),color: Colors.red,),
                  ],
                ),
              ),
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
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());
        return Scrollbar(
          child: ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, int index) {
              var resData = snapshot.data!.docs;
              return theCommodity(resData[index]['meal name'],
                  resData[index]['price'], res!.uid);
            },
          ),
        );
      },
    );
  }
}
