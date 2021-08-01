import 'package:app/LanguageProvider.dart';
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
enum types{
  shawarma,snacks,others
}
class _AdminState extends State<Admin> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    var lanProvider = Provider.of<LanProvider>(context);
    return Directionality(
        textDirection: lanProvider.isEn ? TextDirection.ltr : TextDirection.rtl,
        child: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.redAccent,
              centerTitle: true,
              title: Text('restaurant\'s name'),
              bottom: TabBar(
                tabs: [
                  Tab(text: lanProvider.texts('tab1'),),
                  Tab(text: lanProvider.texts('tab2')),
                  Tab(text: lanProvider.texts('tab3')),
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
        ));
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
  var mealId;

  @override
  Widget build(BuildContext context) {
    var lanProvider = Provider.of<LanProvider>(context);
    var provider = Provider.of<MyProvider>(context);
    dialog(title) {
      return showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return AlertDialog(
              title: Row(
                children: [
                  Icon(
                    Icons.error_outline,
                    color: Colors.red,
                  ),
                  SizedBox(width: 10),
                  Text(
                    title,
                    textAlign:
                    lanProvider.isEn ? TextAlign.start : TextAlign.end,
                    style: TextStyle(fontSize: 23),
                  ),
                ],
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
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(lanProvider.texts('ok'),
                          style: TextStyle(fontSize: 19, color: Colors.blue)),
                    ),
                    onTap: () => Navigator.of(context).pop()),
              ],
            );
          });
    }
    return Directionality(
        textDirection: lanProvider.isEn ? TextDirection.ltr : TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: Text(lanProvider.texts('edit meal')),
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
                    labelText: lanProvider.texts('meal name'),
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _price,
                  decoration: InputDecoration(
                      labelText: lanProvider.texts('meal price'),
                      hintText: "ex: 2.00"),
                ),
                SizedBox(height: 30),
                if (provider.isLoading) Center(child: CircularProgressIndicator()),
                if (!provider.isLoading)
                ElevatedButton(
                    onPressed: () async{
                      try{
                        setState(() {
                            provider.isLoading= true;
                        });
                        await provider.editMeal(_mealName.text, _price.text, "shawarma");
                        Navigator.of(context).pop();
                        setState(() {
                          provider.isLoading= false;
                        });
                      } on FirebaseException catch (e){
                        setState(() {
                          provider.isLoading= false;
                        });
                        dialog(e.message);
                      } catch (e){
                        setState(() {
                          provider.isLoading= false;
                        });
                        dialog('error !');
                      }
                    },
                    child: Text(lanProvider.texts('save'))),
              ],
            ),
          ),
        ));
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
    var lanProvider = Provider.of<LanProvider>(context);
    var provider = Provider.of<MyProvider>(context);
    dialog(title) {
      return showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return AlertDialog(
              title: Row(
                children: [
                  Icon(
                    Icons.error_outline,
                    color: Colors.red,
                  ),
                  SizedBox(width: 10),
                  Text(
                    title,
                    textAlign:
                        lanProvider.isEn ? TextAlign.start : TextAlign.end,
                    style: TextStyle(fontSize: 23),
                  ),
                ],
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
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(lanProvider.texts('ok'),
                          style: TextStyle(fontSize: 19, color: Colors.blue)),
                    ),
                    onTap: () => Navigator.of(context).pop()),
              ],
            );
          });
    }

    return Directionality(
      textDirection: lanProvider.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(lanProvider.texts('add meal')),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const SizedBox(height: 30),
              TextField(
                keyboardType: TextInputType.text,
                controller: _mealName,
                decoration: InputDecoration(
                  labelText: lanProvider.texts('add meal'),
                ),
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: _price,
                decoration: InputDecoration(
                  labelText: lanProvider.texts('meal price'),
                  hintText: "ex: 2.00",
                ),
              ),
              const SizedBox(height: 30),
              if (provider.isLoading)
                Center(child: CircularProgressIndicator()),
              if (!provider.isLoading)
                ElevatedButton(
                    onPressed: () async {
                      try {
                        if (_mealName.text.isEmpty || _price.text.isEmpty)
                          return dialog(lanProvider.texts('empty field'));
                        setState(() {
                          provider.isLoading = true;
                        });
                        await provider.addMeal(
                            _mealName.text, _price.text, "shawarma");
                        Navigator.of(context).pop();
                        setState(() {
                          provider.isLoading = false;
                        });
                      } on FirebaseException catch (e) {
                        setState(() {
                          provider.isLoading = false;
                        });
                        return dialog(e.message);
                      } catch (e) {
                        setState(() {
                          provider.isLoading = false;
                        });
                        print(e);
                        dialog('error !');
                      }
                    },
                    child: Text(lanProvider.texts('add'))),
            ],
          ),
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
                SizedBox(width: 11),
                InkWell(
                    child: Text(lanProvider.texts('ok'),
                        style: TextStyle(fontSize: 19)),
                    onTap: () => Navigator.of(context).pop()),
              ],
            );
          });
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
              return Card(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  provider.mealID = resData[index].id;
                                });
                                Navigator.of(context).pushNamed('edit');
                              },
                              icon: Icon(Icons.edit),
                              color: Colors.blue,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 20),
                                Container(
                                  padding: EdgeInsets.only(left: 10),
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    resData[index]['meal name'],
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w800),
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
                              ],
                            ),
                            Spacer(),
                            IconButton(
                              onPressed: () => showDialog(
                                  context: context,
                                  builder: (BuildContext ctx) {
                                    return AlertDialog(
                                      title: Text(
                                        lanProvider.texts('delete this meal?'),
                                        textAlign: lanProvider.isEn
                                            ? TextAlign.start
                                            : TextAlign.end,
                                        style: TextStyle(fontSize: 23),
                                      ),
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 7),
                                      elevation: 24,
                                      content: Container(
                                        height: 30,
                                        child: const Divider(),
                                        alignment: Alignment.topCenter,
                                      ),
                                      actions: [
                                        if (provider.isLoading)
                                          Center(
                                              child:
                                                  CircularProgressIndicator()),
                                        if (!provider.isLoading)
                                          InkWell(
                                            child: Text(
                                              lanProvider.texts('yes?'),
                                              style: TextStyle(
                                                  fontSize: 19,
                                                  color: Colors.red),
                                            ),
                                            onTap: () async {
                                              try {
                                                setState(() {
                                                  provider.mealID =
                                                      resData[index].id;
                                                  provider.isLoading = true;
                                                });
                                                await provider
                                                    .deleteMeal("shawarma");
                                                Navigator.of(context).pop();
                                                setState(() {
                                                  provider.isLoading = false;
                                                });
                                              } on FirebaseException catch (e) {
                                                setState(() {
                                                  provider.isLoading = false;
                                                });
                                                return dialog(e.message);
                                              } catch (e) {
                                                setState(() {
                                                  provider.isLoading = false;
                                                });
                                                print(e);
                                                dialog('error !');
                                              }
                                            },
                                          ),
                                        SizedBox(width: 11),
                                        if (!provider.isLoading)
                                          InkWell(
                                              child: Text(
                                                  lanProvider.texts('cancel?'),
                                                  style:
                                                      TextStyle(fontSize: 19)),
                                              onTap: () =>
                                                  Navigator.of(context).pop()),
                                      ],
                                    );
                                  }),
                              icon: const Icon(Icons.delete),
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ),
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
class SecondAdmin extends StatefulWidget {
  @override
  _SecondAdminState createState() => _SecondAdminState();
}

class _SecondAdminState extends State<SecondAdmin> {
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
                SizedBox(width: 11),
                InkWell(
                    child: Text(lanProvider.texts('ok'),
                        style: TextStyle(fontSize: 19)),
                    onTap: () => Navigator.of(context).pop()),
              ],
            );
          });
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
              return Card(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  provider.mealID = resData[index].id;
                                });
                                Navigator.of(context).pushNamed('edit');
                              },
                              icon: Icon(Icons.edit),
                              color: Colors.blue,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 20),
                                Container(
                                  padding: EdgeInsets.only(left: 10),
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    resData[index]['meal name'],
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w800),
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
                              ],
                            ),
                            Spacer(),
                            IconButton(
                              onPressed: () => showDialog(
                                  context: context,
                                  builder: (BuildContext ctx) {
                                    return AlertDialog(
                                      title: Text(
                                        lanProvider.texts('delete this meal?'),
                                        textAlign: lanProvider.isEn
                                            ? TextAlign.start
                                            : TextAlign.end,
                                        style: TextStyle(fontSize: 23),
                                      ),
                                      contentPadding:
                                      EdgeInsets.symmetric(vertical: 7),
                                      elevation: 24,
                                      content: Container(
                                        height: 30,
                                        child: const Divider(),
                                        alignment: Alignment.topCenter,
                                      ),
                                      actions: [
                                        if (provider.isLoading)
                                          Center(
                                              child:
                                              CircularProgressIndicator()),
                                        if (!provider.isLoading)
                                          InkWell(
                                            child: Text(
                                              lanProvider.texts('yes?'),
                                              style: TextStyle(
                                                  fontSize: 19,
                                                  color: Colors.red),
                                            ),
                                            onTap: () async {
                                              try {
                                                setState(() {
                                                  provider.mealID =
                                                      resData[index].id;
                                                  provider.isLoading = true;
                                                });
                                                await provider
                                                    .deleteMeal('snacks');
                                                Navigator.of(context).pop();
                                                setState(() {
                                                  provider.isLoading = false;
                                                });
                                              } on FirebaseException catch (e) {
                                                setState(() {
                                                  provider.isLoading = false;
                                                });
                                                return dialog(e.message);
                                              } catch (e) {
                                                setState(() {
                                                  provider.isLoading = false;
                                                });
                                                dialog('error!');
                                              }
                                            },
                                          ),
                                        SizedBox(width: 11),
                                        if (!provider.isLoading)
                                          InkWell(
                                              child: Text(
                                                  lanProvider.texts('cancel?'),
                                                  style:
                                                  TextStyle(fontSize: 19)),
                                              onTap: () =>
                                                  Navigator.of(context).pop()),
                                      ],
                                    );
                                  }),
                              icon: const Icon(Icons.delete),
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ),
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
class ThirdAdmin extends StatefulWidget {
  @override
  _ThirdAdminState createState() => _ThirdAdminState();
}

class _ThirdAdminState extends State<ThirdAdmin> {
  int _itemCount = 0;

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
                SizedBox(width: 11),
                InkWell(
                    child: Text(lanProvider.texts('ok'),
                        style: TextStyle(fontSize: 19)),
                    onTap: () => Navigator.of(context).pop()),
              ],
            );
          });
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
              return Card(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  provider.mealID = resData[index].id;
                                });
                                Navigator.of(context).pushNamed('edit');
                              },
                              icon: Icon(Icons.edit),
                              color: Colors.blue,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 20),
                                Container(
                                  padding: EdgeInsets.only(left: 10),
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    resData[index]['meal name'],
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w800),
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
                              ],
                            ),
                            Spacer(),
                            IconButton(
                              onPressed: () => showDialog(
                                  context: context,
                                  builder: (BuildContext ctx) {
                                    return AlertDialog(
                                      title: Text(
                                        lanProvider.texts('delete this meal?'),
                                        textAlign: lanProvider.isEn
                                            ? TextAlign.start
                                            : TextAlign.end,
                                        style: TextStyle(fontSize: 23),
                                      ),
                                      contentPadding:
                                      EdgeInsets.symmetric(vertical: 7),
                                      elevation: 24,
                                      content: Container(
                                        height: 30,
                                        child: const Divider(),
                                        alignment: Alignment.topCenter,
                                      ),
                                      actions: [
                                        if (provider.isLoading)
                                          Center(
                                              child:
                                              CircularProgressIndicator()),
                                        if (!provider.isLoading)
                                          InkWell(
                                            child: Text(
                                              lanProvider.texts('yes?'),
                                              style: TextStyle(
                                                  fontSize: 19,
                                                  color: Colors.red),
                                            ),
                                            onTap: () async {
                                              try {
                                                setState(() {
                                                  provider.mealID =
                                                      resData[index].id;
                                                  provider.isLoading = true;
                                                });
                                                await provider
                                                    .deleteMeal("others");
                                                Navigator.of(context).pop();
                                                setState(() {
                                                  provider.isLoading = false;
                                                });
                                              } on FirebaseException catch (e) {
                                                setState(() {
                                                  provider.isLoading = false;
                                                });
                                                return dialog(e.message);
                                              } catch (e) {
                                                setState(() {
                                                  provider.isLoading = false;
                                                });
                                                dialog('error!');
                                              }
                                            },
                                          ),
                                        SizedBox(width: 11),
                                        if (!provider.isLoading)
                                          InkWell(
                                              child: Text(
                                                  lanProvider.texts('cancel?'),
                                                  style:
                                                  TextStyle(fontSize: 19)),
                                              onTap: () =>
                                                  Navigator.of(context).pop()),
                                      ],
                                    );
                                  }),
                              icon: const Icon(Icons.delete),
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ),
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
