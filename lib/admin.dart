import 'package:app/LanguageProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'Myprovider.dart';

class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}


class _AdminState extends State<Admin> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      Provider.of<MyProvider>(context, listen: false).tabIndex = "shawarma";
      Provider.of<MyProvider>(context, listen: false).fetchMeals("grill house");
    });
    super.initState();
  }

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
              actions: [
                IconButton(
                  onPressed: () => Navigator.of(context).pushNamed('addMeal'),
                  icon: const Icon(Icons.add),
                ),
              ],
              centerTitle: true,
              title: Text('restaurant\'s name'),
              bottom: TabBar(
                tabs: [
                  Tab(
                    text: lanProvider.texts('tab1'),
                  ),
                  Tab(text: lanProvider.texts('tab2')),
                  Tab(text: lanProvider.texts('tab3')),
                ],
                onTap: (index) {
                  if (index == 0)
                    provider.tabIndex = "shawarma";
                  else if (index == 1)
                    provider.tabIndex = "snacks";
                  else
                    provider.tabIndex = "others";
                  print(provider.tabIndex);
                  print(index);
                },
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
  TextEditingController _description = TextEditingController();

  @override
  void dispose() {
    _mealName.dispose();
    _price.dispose();
    _description.dispose();
    super.dispose();
  }

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
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      title,
                      textAlign:
                          lanProvider.isEn ? TextAlign.start : TextAlign.end,
                      style: const TextStyle(fontSize: 23),
                    ),
                  ),
                ],
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 7),
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
                          style: const TextStyle(
                              fontSize: 19, color: Colors.blue)),
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
                const SizedBox(height: 30),
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
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _description,
                  decoration: InputDecoration(
                    labelText: lanProvider.texts('desc'),
                  ),
                ),
                const SizedBox(height: 30),
                if (provider.isLoading)
                  Center(child: const CircularProgressIndicator()),
                if (!provider.isLoading)
                  ElevatedButton(
                      onPressed: () async {
                        try {
                          if (_mealName.text.isEmpty || _price.text.isEmpty)
                            return dialog(lanProvider.texts('empty field'));
                          setState(() {
                            provider.isLoading = true;
                          });
                          await provider.editMeal(_mealName.text, _price.text,
                              _description.text, provider.tabIndex);
                          Navigator.of(context).pop();
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
                          dialog(lanProvider.texts('Error occurred !'));
                          print(e);
                        }
                      },
                      child: Text(lanProvider.texts('save'))),
              ],
            ),
          ),
        ));
  }
}

//-------------------------addMeal-----------------------------
class AddMeal extends StatefulWidget {
  @override
  _AddMealState createState() => _AddMealState();
}

class _AddMealState extends State<AddMeal> {
  TextEditingController _mealName = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _description = TextEditingController();

  @override
  void dispose() {
    _mealName.dispose();
    _price.dispose();
    _description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var lanProvider = Provider.of<LanProvider>(context);
    var provider = Provider.of<MyProvider>(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    dialog(title) {
      return showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return AlertDialog(
              title: Row(
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    title,
                    textAlign:
                        lanProvider.isEn ? TextAlign.start : TextAlign.end,
                    style: const TextStyle(fontSize: 23),
                  ),
                ],
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 7),
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
                          style: const TextStyle(
                              fontSize: 19, color: Colors.blue)),
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
          child: ListView(
            children: [
              const SizedBox(height: 30),
              TextField(
                keyboardType: TextInputType.text,
                controller: _mealName,
                decoration: InputDecoration(
                  labelText: lanProvider.texts('meal name'),
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
              TextField(
                keyboardType: TextInputType.text,
                controller: _description,
                decoration: InputDecoration(
                  labelText: lanProvider.texts('desc'),
                ),
              ),
              const SizedBox(height: 20),
              if (provider.isLoading)
                Center(child: const CircularProgressIndicator()),
              if (!provider.isLoading)
                Center(
                  child: Text(
                    lanProvider.texts('add text'),
                    style: TextStyle(fontSize: width * 0.037),
                  ),
                ),
              const SizedBox(height: 10),
              if (!provider.isLoading)
                Container(
                  width: width * 0.3,
                  height: height * 0.07,
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        if (_mealName.text.isEmpty || _price.text.isEmpty)
                          return dialog(lanProvider.texts('empty field'));
                        setState(() {
                          provider.isLoading = true;
                        });
                        await provider.addMeal(_mealName.text, _price.text,
                            _description.text, "shawarma");
                        Navigator.of(context).pop();
                        Fluttertoast.showToast(
                            msg: lanProvider.texts('Meal Added'),
                            toastLength: Toast.LENGTH_SHORT,
                            backgroundColor: Colors.grey,
                            textColor: Colors.white,
                            fontSize: 16.0);
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
                        dialog(lanProvider.texts('Error occurred !'));
                      }
                    },
                    child: Text(
                      lanProvider.texts('tab1'),
                      style: TextStyle(fontSize: width * 0.05),
                    ),
                  ),
                ),
              const SizedBox(height: 20),
              if (!provider.isLoading)
                Container(
                  width: width * 0.3,
                  height: height * 0.07,
                  child: ElevatedButton(
                      onPressed: () async {
                        try {
                          if (_mealName.text.isEmpty || _price.text.isEmpty)
                            return dialog(lanProvider.texts('empty field'));
                          setState(() {
                            provider.isLoading = true;
                          });
                          await provider.addMeal(_mealName.text, _price.text,
                              _description.text, "snacks");
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
                          dialog(lanProvider.texts('Error occurred !'));
                        }
                      },
                      child: Text(
                        lanProvider.texts('tab2'),
                        style: TextStyle(fontSize: width * 0.05),
                      )),
                ),
              const SizedBox(height: 20),
              if (!provider.isLoading)
                Container(
                  width: width * 0.3,
                  height: height * 0.07,
                  child: ElevatedButton(
                      onPressed: () async {
                        try {
                          if (_mealName.text.isEmpty || _price.text.isEmpty)
                            return dialog(lanProvider.texts('empty field'));
                          setState(() {
                            provider.isLoading = true;
                          });
                          await provider.addMeal(_mealName.text, _price.text,
                              _description.text, "others");
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
                          dialog(lanProvider.texts('Error occurred !'));
                        }
                      },
                      child: Text(
                        lanProvider.texts('tab3'),
                        style: TextStyle(fontSize: width * 0.05),
                      )),
                ),
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
      child: StreamBuilder<QuerySnapshot>(
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
                                icon: const Icon(Icons.edit),
                                color: Colors.blue,
                              ),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const SizedBox(height: 20),
                                    Container(
                                      padding: const EdgeInsets.only(left: 10),
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        resData[index]['meal name'],
                                        style: TextStyle(
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
                                      margin: const EdgeInsets.only(top: 10),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 7),
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
                                          style: const TextStyle(fontSize: 23),
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
                                                    const CircularProgressIndicator()),
                                          if (!provider.isLoading)
                                            InkWell(
                                              child: Text(
                                                lanProvider.texts('yes?'),
                                                style: const TextStyle(
                                                    fontSize: 19,
                                                    color: Colors.red),
                                              ),
                                              onTap: () async {
                                                try {
                                                  setState(() {
                                                    provider.mealID =
                                                        resData[index].id;
                                                  });
                                                  Navigator.of(context).pop();
                                                  await provider
                                                      .deleteMeal("shawarma");
                                                  Fluttertoast.showToast(
                                                      msg: lanProvider
                                                          .texts('Meal Deleted'),
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      backgroundColor:
                                                          Colors.grey,
                                                      textColor: Colors.white,
                                                      fontSize: 16.0);
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
                                                  dialog(lanProvider
                                                      .texts('Error occurred !'));
                                                }
                                              },
                                            ),
                                          const SizedBox(width: 11),
                                          if (!provider.isLoading)
                                            InkWell(
                                                child: Text(
                                                    lanProvider.texts('cancel?'),
                                                    style: const TextStyle(
                                                        fontSize: 19)),
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
      ),
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
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('/restaurants/grill house/snacks')
            .snapshots(),
        builder: (ctx, snapshot) {
          if (!snapshot.hasData)
            return Center(child: const CircularProgressIndicator());
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
                                icon: const Icon(Icons.edit),
                                color: Colors.blue,
                              ),
                               Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const SizedBox(height: 20),
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
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 7),
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
                                          style: const TextStyle(fontSize: 23),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 7),
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
                                                    const CircularProgressIndicator()),
                                          if (!provider.isLoading)
                                            InkWell(
                                              child: Text(
                                                lanProvider.texts('yes?'),
                                                style: const TextStyle(
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
                                                  dialog(lanProvider
                                                      .texts('Error occurred !'));
                                                }
                                              },
                                            ),
                                          const SizedBox(width: 11),
                                          if (!provider.isLoading)
                                            InkWell(
                                                child: Text(
                                                    lanProvider.texts('cancel?'),
                                                    style: const TextStyle(
                                                        fontSize: 19)),
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
      ),
    );
  }
}

//-----------------------------3-----------------------
class ThirdAdmin extends StatefulWidget {
  @override
  _ThirdAdminState createState() => _ThirdAdminState();
}

class _ThirdAdminState extends State<ThirdAdmin> {
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

    return Directionality(
      textDirection: lanProvider.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('/restaurants/grill house/others')
            .snapshots(),
        builder: (ctx, snapshot) {
          if (!snapshot.hasData)
            return Center(child: const CircularProgressIndicator());
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
                                  icon: const Icon(Icons.edit),
                                  color: Colors.blue,
                                ),
                                   Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      const SizedBox(height: 20),
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
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 7),
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
                                            style: const TextStyle(fontSize: 23),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 7),
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
                                                      const CircularProgressIndicator()),
                                            if (!provider.isLoading)
                                              InkWell(
                                                child: Text(
                                                  lanProvider.texts('yes?'),
                                                  style: const TextStyle(
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
                                                    dialog(lanProvider
                                                        .texts('Error occurred !'));
                                                  }
                                                },
                                              ),
                                            const SizedBox(width: 11),
                                            if (!provider.isLoading)
                                              InkWell(
                                                  child: Text(
                                                      lanProvider.texts('cancel?'),
                                                      style: const TextStyle(
                                                          fontSize: 19)),
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
      ),
    );
  }
}
