import 'dart:math';

import 'package:app/LanguageProvider.dart';
import 'package:app/LogIn.dart';
import 'package:app/MyHistory.dart';
import 'package:app/Myfavourites_screen.dart';
import 'package:app/callCenter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

import 'main.dart';

enum authStatus { Authenticating, unAuthenticated, Authenticated }

class Address {
  final String id;
  final String area;
  final String street;
  final String phoneNum;

  Address({
    required this.area,
    required this.street,
    required this.phoneNum,
    required this.id,
  });
}

class Meals {
  final String id;
  var mealName;
  var mealPrice;
  var description;
  final String resName;

  Meals(
      {required this.resName,
      required this.description,
      required this.mealName,
      required this.mealPrice,
      required this.id});
}

class Favorites {
  final myFavoriteID;

  Favorites({required this.myFavoriteID});
}

class FoodCart {
  final foodID;
  var quantity;
  final mealName;
  final mealPrice;
  final resName;
  final description;

  FoodCart(
      {required this.description,
      required this.resName,
      required this.mealName,
      required this.mealPrice,
      required this.quantity,
      required this.foodID});
}

class TypesClass {
  String title;
  bool value;

  TypesClass({this.value = false, required this.title});
}

class Types2Class {
  String title;
  Object value;

  Types2Class({this.value = false, required this.title});
}

//-----------------------------------------------------------
class MyProvider with ChangeNotifier {
  bool isDark = false;

  getDarkMode() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    isDark = pref.getBool('darkMode') ?? false;
    notifyListeners();
  }

  setDarkMode(value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('darkMode', value);
    isDark = value;
    notifyListeners();
  }

  //----------------------intl package-----------------------

  String dateTime(timeStamp) {
    var time = DateTime.fromMillisecondsSinceEpoch(timeStamp.seconds * 1000);
    return DateFormat('dd-MM-yyyy    hh:mm a').format(time);
  }

  //-----------------------things----------------------------
  bool admin = false;

  setAdmin(val) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('admin', val);
    notifyListeners();
  }

  getAdmin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    admin = pref.getBool('admin') ?? false;
    notifyListeners();
  }

  bool isLoading = false;
  List<Meals> mealIDs = [];
  var mealID;
  var restaurantName;
  List imageFun = [
    'file/25dc71eea9f56697.jpg',
    'file/3f48b82e3140f7c0.jpg',
    'file/??????????.jpg',
    'file/DT_cover.jpg',
    'file/unknoswn.png'
  ];

  var radioValue;
  var radioValue1;
  var radioValue2;
  var radioValue3;
  var radioValue4;
  var radioValue5;
  var radioValue6;
  var radioValue7;
  var radioValue8;
  var radioValue9;
  var radioValue10;
  var radioValue11;
  var radioValue12;
  var radioValue13;
  var radioValue14;
  var radioValue15;
  var radioValue16;
  var radioValue17;
  var radioValue18;

  checkFun(val, index) {
    pizzaTypes[index].value = val;
    notifyListeners();
  }

  checkFun1(val, index) {
    pizzaTypes1[index].value = val;
    notifyListeners();
  }

  setFalse() {
    for (int i = 0; i < pizzaTypes.length; i++)
      if (pizzaTypes[i].value) pizzaTypes[i].value = false;
    notifyListeners();
  }

  setFalse1() {
    for (int i = 0; i < pizzaTypes1.length; i++)
      if (pizzaTypes1[i].value) pizzaTypes1[i].value = false;
    notifyListeners();
  }

  List<TypesClass> pizzaTypes = <TypesClass>[
    TypesClass(title: '?????????? '),
    TypesClass(title: '???????????? '),
    TypesClass(title: '???????? '),
    TypesClass(title: '???????? '),
    TypesClass(title: '?????????????? '),
    TypesClass(title: '???????? '),
    TypesClass(title: '?????? ?????? '),
  ];

  List<TypesClass> pizzaTypes1 = <TypesClass>[
    TypesClass(title: '??????????'),
    TypesClass(title: '????????????'),
    TypesClass(title: '????????'),
    TypesClass(title: '????????'),
    TypesClass(title: '??????????????'),
    TypesClass(title: '?????? ???????? ????????'),
    TypesClass(title: '??????????'),
    TypesClass(title: '?????? ????????'),
    TypesClass(title: '???????? ??????'),
    TypesClass(title: '???????? ??????'),
    TypesClass(title: '??????????????'),
  ];

  List<Types2Class> pizzaTypes2 = <Types2Class>[
    Types2Class(title: '????????  ', value: 0),
    Types2Class(title: '??????????  ', value: 1),
    Types2Class(title: '????????  ', value: 2),
    Types2Class(title: '????????  ', value: 3),
    Types2Class(title: '??????????????  ', value: 4),
    Types2Class(title: '????????????  ', value: 5),
    Types2Class(title: '??????????????  ', value: 6),
    Types2Class(title: '???????? ????????????  ', value: 7),
    Types2Class(title: '???????? ???? ????????  ', value: 8),
    Types2Class(title: '?????? ????????  ', value: 9),
  ];

  List<Types2Class> mo3ajanat1 = <Types2Class>[
    Types2Class(title: '???????? ??????????', value: 0),
    Types2Class(title: '?????????? ????????', value: 1),
    Types2Class(title: '????????', value: 2),
    Types2Class(title: '??????????', value: 3),
    Types2Class(title: '??????????', value: 4),
    Types2Class(title: '??????????', value: 5),
    Types2Class(title: '??????????', value: 6),
    Types2Class(title: '???????? ???? ??????????', value: 7),
  ];
  List<Types2Class> mo3ajanat2 = <Types2Class>[
    Types2Class(title: '????????????', value: 0),
    Types2Class(title: '?????????? ??????????????', value: 1),
    Types2Class(title: '?????????? ??????????????', value: 2),
    Types2Class(title: '???????? ??????????????', value: 3),
    Types2Class(title: '???????????? ??????????????', value: 4),
    Types2Class(title: '?????????? ??????????????', value: 5),
    Types2Class(title: '?????????? ??????????????', value: 6),
    Types2Class(title: '?????? ????????', value: 7),
    Types2Class(title: '?????? ??????????', value: 8),
    Types2Class(title: '???????? ??????????', value: 9),
    Types2Class(title: '???????? ?????????? ????????', value: 10),
  ];
  List<Types2Class> mo3ajanat3 = <Types2Class>[
    Types2Class(title: '??????????', value: 0),
    Types2Class(title: '???????? ??????????????', value: 1),
    Types2Class(title: '????????', value: 2),
    Types2Class(title: '?????????? ??????????????', value: 3),
    Types2Class(title: '?????????? ??????????????', value: 4),
    Types2Class(title: '?????????? ??????????????', value: 5),
    Types2Class(title: '???????? ??????????', value: 6),
    Types2Class(title: '????????', value: 7),
    Types2Class(title: '??????????', value: 8),
  ];

  List<Types2Class> riceTypes = <Types2Class>[
    Types2Class(title: '????????????', value: 0),
    Types2Class(title: '????????', value: 1),
    Types2Class(title: '????????', value: 2),
    Types2Class(title: '????????????', value: 3),
    Types2Class(title: '??????????', value: 4),
  ];

  List<Types2Class> riceTypes1 = <Types2Class>[
    Types2Class(title: '????????????', value: 0),
    Types2Class(title: '????????', value: 1),
    Types2Class(title: '??????????', value: 2),
    Types2Class(title: '????????????', value: 3),
    Types2Class(title: '??????????', value: 4),
    Types2Class(title: '??????', value: 5),
  ];

  List<Types2Class> cakeTypes = <Types2Class>[
    Types2Class(title: '????????????', value: 0),
    Types2Class(title: '????????????  ', value: 1),
    Types2Class(title: '????????????  ', value: 2),
  ];

  List<Types2Class> milkTypes = <Types2Class>[
    Types2Class(title: '????????', value: 0),
    Types2Class(title: '??????????', value: 1),
    Types2Class(title: '????????????', value: 2),
    Types2Class(title: '??????????', value: 3),
    Types2Class(title: '????????', value: 4),
    Types2Class(title: '???????? ??????', value: 5),
    Types2Class(title: '???? ??????', value: 6),
    Types2Class(title: '????????????', value: 7),
    Types2Class(title: '??????????????', value: 8),
  ];

  List<Types2Class> iceCreamTypes = <Types2Class>[
    Types2Class(title: '???????? ', value: 0),
    Types2Class(title: '?????????? ', value: 1),
    Types2Class(title: '?????????? ', value: 2),
    Types2Class(title: '???????? ', value: 3),
    Types2Class(title: '???????? ?????? ', value: 4),
    Types2Class(title: '???? ?????? ', value: 5),
    Types2Class(title: '???????????? ', value: 6),
    Types2Class(title: '???????????????? ', value: 7),
    Types2Class(title: '???????????? ', value: 8),
  ];

  List<Types2Class> hotTypes = <Types2Class>[
    Types2Class(title: '????????', value: 0),
    Types2Class(title: '??????', value: 1),
    Types2Class(title: '????????', value: 2),
  ];

  List<Types2Class> saloonTypes1 = <Types2Class>[
    Types2Class(title: '????????????????', value: 0),
    Types2Class(title: '????????????', value: 1),
    Types2Class(title: '???? ????????????', value: 2),
    Types2Class(title: '??????????', value: 3),
  ];

  List<Types2Class> saloonTypes2 = <Types2Class>[
    Types2Class(title: '???????????????? ', value: 0),
    Types2Class(title: '???????????? ', value: 1),
    Types2Class(title: '??????????', value: 2),
    Types2Class(title: '?????????? ', value: 3),
  ];

  List<Types2Class> iceCreamTypes2 = <Types2Class>[
    Types2Class(title: '???????? ????????', value: 0),
    Types2Class(title: '????????????', value: 1),
    Types2Class(title: '????????????????', value: 2),
    Types2Class(title: '??????????', value: 3),
    Types2Class(title: '???????? ??????', value: 4),
    Types2Class(title: '??????????', value: 5),
    Types2Class(title: '????????????', value: 6),
  ];

  List<Types2Class> pizzaTypes3 = <Types2Class>[
    Types2Class(title: '????????', value: 0),
    Types2Class(title: '????????', value: 1),
    Types2Class(title: '????????', value: 2),
    Types2Class(title: '??????????', value: 3),
    Types2Class(title: '??????????????', value: 4),
    Types2Class(title: '??????????', value: 5),
    Types2Class(title: '????????????', value: 6),
  ];

  List<Types2Class> mo3ajanat4 = <Types2Class>[
    Types2Class(title: '???????? ??????????', value: 0),
    Types2Class(title: '???????? ??????????', value: 1),
    Types2Class(title: '????????', value: 2),
    Types2Class(title: '???????????? ??????????????', value: 3),
    Types2Class(title: '?????????? ????????', value: 4),
    Types2Class(title: '??????????', value: 5),
    Types2Class(title: '??????????', value: 6),
    Types2Class(title: '??????', value: 7),
  ];

  List<Types2Class> naturalDrinks = <Types2Class>[
    Types2Class(title: '????????', value: 0),
    Types2Class(title: '??????', value: 1),
    Types2Class(title: '??????????', value: 2),
    Types2Class(title: '???????? ????????', value: 3),
    Types2Class(title: '????????????', value: 4),
    Types2Class(title: '????????????', value: 5),
    Types2Class(title: '????????????', value: 6),
    Types2Class(title: '????????????', value: 7),
    Types2Class(title: '??????????', value: 8),
    Types2Class(title: '????????', value: 9),
  ];

  List<Types2Class> naturalSlush = <Types2Class>[
    Types2Class(title: ' ????????????', value: 0),
    Types2Class(title: '?????????? ', value: 1),
    Types2Class(title: '???????????? ', value: 2),
    Types2Class(title: '?????????? ', value: 3),
  ];

  List<Types2Class> iceCreamTypes3 = <Types2Class>[
    Types2Class(title: '???????? ?????????? ', value: 0),
    Types2Class(title: '???????????????? ???? ', value: 1),
    Types2Class(title: '?????????????? ?????? ', value: 2),
    Types2Class(title: '?????????? ?????????? ', value: 3),
    Types2Class(title: '?????????? ???????? ', value: 4),
    Types2Class(title: '?????????? ???????????? ', value: 5),
  ];

  List<Types2Class> milkShakeTypes = <Types2Class>[
    Types2Class(title: '????????  ', value: 0),
    Types2Class(title: '????????????  ', value: 1),
    Types2Class(title: '????????????  ', value: 2),
    Types2Class(title: '??????????  ', value: 3),
    Types2Class(title: '????????????????  ', value: 4),
  ];

  //-------------------------
  List<String> areas = <String>[
    '---???????? ??????????????---',
    '???? ????????????',
    '???? ???????????? ????????????',
    '???? ????????????',
    '???? ????????????',
    '???? ???????????? ????????',
    '???? ??????????????',
    '?????????? ??????????????',
    '?????????? ??????????????',
    '??????????',
    '?????? ??????????????',
    '???? ??????????????',
    '?????? ??????????????',
    '???? ????????????????',
    '???? ????????????',
    '???? ????????????????',
    '???? ??????????',
    '???? ????????????',
    '???????? ??????????????',
    '?????????????? ??????????????',
    '???????? ??????????????????',
    '?????????? ??????????????',
    '???? ??????????',
    '???? ????????????????',
    '??????????????',
    '????????????????',
    '???????????????? ????????????????',
    '?????? ???????? ??????????????',
    '???? ????????????',
    '???????????????? 12',
    '?????????????? ????????????',
    '????????????',
    '??????????????',
    '????????????',
    '???????? ????????????',
    '????????????',
    '????????????????',
    '???????????? ????????????',
    '???????????? ????????????',
    '????????????',
    '?????? ??????????????',
    '???????? ??????????????',
    '???????? ??????????????',
    '?????????? ???????????? ????????????',
    '????????',
    '??????????????',
    '????????',
    '?????? ??????',
    '?????? ??????',
    '?????????? ????????????????',
    '?????????? ????????????????',
    '???????? ??????????????',
    '??????????',
    '??????????????',
    '?????????? ????????????????',
    '?????????? ????????????',
    '????????????',
    '???????? ????????????',
  ];
  String area = '---???????? ??????????????---';

  var deliveryPrice = 1.00;

  getDiscount() async {
    await FirebaseFirestore.instance
        .collection('DP')
        .doc('2')
        .get()
        .then((value) => discount = value['discountBool']);
    notifyListeners();
  }

  deliveryPriceOnArea() async {
    await getDiscount();
    if (!discount) {
      if (checkOut['area'] == "???? ????????????" ||
          checkOut['area'] == "???????? ??????????????" ||
          checkOut['area'] == "???? ????????????" ||
          checkOut['area'] == "???? ????????????" ||
          checkOut['area'] == "???? ????????????????" ||
          checkOut['area'] == "??????????" ||
          checkOut['area'] == "???? ????????????????" ||
          checkOut['area'] == "?????????? ??????????????")
        await FirebaseFirestore.instance
            .collection('DP')
            .doc('1')
            .get()
            .then((value) => deliveryPrice = double.parse(value['price1']));
      else if (checkOut['area'] == "?????????? ??????????????" ||
          checkOut['area'] == "?????? ??????????????" ||
          checkOut['area'] == "???? ????????????" ||
          checkOut['area'] == "???? ??????????????" ||
          checkOut['area'] == "???????? ??????????????????" ||
          checkOut['area'] == "?????????????? ??????????????")
        await FirebaseFirestore.instance
            .collection('DP')
            .doc('1')
            .get()
            .then((value) => deliveryPrice = double.parse(value['price2']));
      else if (checkOut['area'] == "?????????? ??????????????" ||
          checkOut['area'] == "???? ??????????????" ||
          checkOut['area'] == "???? ????????????" ||
          checkOut['area'] == "???? ???????????? ????????????" ||
          checkOut['area'] == "???? ???????????? ????????" ||
          checkOut['area'] == "???? ????????????" ||
          checkOut['area'] == "????????????????" ||
          checkOut['area'] == "???????????????? 12" ||
          checkOut['area'] == "?????????????? ????????????" ||
          checkOut['area'] == "??????????????" ||
          checkOut['area'] == "???? ??????????" ||
          checkOut['area'] == "?????????? ???????????? ????????????" ||
          checkOut['area'] == "???????????? ????????" ||
          checkOut['area'] == "???????????????? ????????????????" ||
          checkOut['area'] == "???????????? ????????????????" ||
          checkOut['area'] == "???? ????????????????" ||
          checkOut['area'] == "?????? ???????? ??????????????" ||
          checkOut['area'] == "???? ??????????")
        await FirebaseFirestore.instance
            .collection('DP')
            .doc('1')
            .get()
            .then((value) => deliveryPrice = double.parse(value['price3']));
      else if (checkOut['area'] == "?????? ????????" ||
          checkOut['area'] == "?????? ??????????????" ||
          checkOut['area'] == "???????????? ????????????" ||
          checkOut['area'] == "?????????? ????????????????")
        await FirebaseFirestore.instance
            .collection('DP')
            .doc('1')
            .get()
            .then((value) => deliveryPrice = double.parse(value['price4']));
      else if (checkOut['area'] == "????????????" || checkOut['area'] == "?????? ??????")
        await FirebaseFirestore.instance
            .collection('DP')
            .doc('1')
            .get()
            .then((value) => deliveryPrice = double.parse(value['price5']));
      else if (checkOut['area'] == "??????????????" ||
          checkOut['area'] == "????????????" ||
          checkOut['area'] == "??????????????")
        await FirebaseFirestore.instance
            .collection('DP')
            .doc('1')
            .get()
            .then((value) => deliveryPrice = double.parse(value['price6']));
      else if (checkOut['area'] == "????????????" || checkOut['area'] == "????????")
        await FirebaseFirestore.instance
            .collection('DP')
            .doc('1')
            .get()
            .then((value) => deliveryPrice = double.parse(value['price7']));
      else if (checkOut['area'] == "????????????????" ||
          checkOut['area'] == "?????????? ????????????????" ||
          checkOut['area'] == "???????? ????????????" ||
          checkOut['area'] == "????????????")
        await FirebaseFirestore.instance
            .collection('DP')
            .doc('1')
            .get()
            .then((value) => deliveryPrice = double.parse(value['price8']));
      else if (checkOut['area'] == "?????? ??????" ||
          checkOut['area'] == "???????? ??????????????")
        await FirebaseFirestore.instance
            .collection('DP')
            .doc('1')
            .get()
            .then((value) => deliveryPrice = double.parse(value['price9']));
      else if (checkOut['area'] == "????????????" ||
          checkOut['area'] == "?????? ??????????????" ||
          checkOut['area'] == "???????? ??????????????")
        await FirebaseFirestore.instance
            .collection('DP')
            .doc('1')
            .get()
            .then((value) => deliveryPrice = double.parse(value['price10']));
      else if (checkOut['area'] == "?????????? ????????????????")
        await FirebaseFirestore.instance
            .collection('DP')
            .doc('1')
            .get()
            .then((value) => deliveryPrice = double.parse(value['price11']));
      else if (checkOut['area'] == "????????" ||
          checkOut['area'] == "???????? ??????????????" ||
          checkOut['area'] == "?????????? ????????????")
        await FirebaseFirestore.instance
            .collection('DP')
            .doc('1')
            .get()
            .then((value) => deliveryPrice = double.parse(value['price12']));
      else if (checkOut['area'] == "??????????????")
        await FirebaseFirestore.instance
            .collection('DP')
            .doc('1')
            .get()
            .then((value) => deliveryPrice = double.parse(value['price13']));
      else if (checkOut['area'] == "???????????? ????????????" ||
          checkOut['area'] == "??????????")
        await FirebaseFirestore.instance
            .collection('DP')
            .doc('1')
            .get()
            .then((value) => deliveryPrice = double.parse(value['price14']));
      else if (checkOut['area'] == "???????? ????????????")
        await FirebaseFirestore.instance
            .collection('DP')
            .doc('1')
            .get()
            .then((value) => deliveryPrice = double.parse(value['price15']));
    } else {
      await FirebaseFirestore.instance
          .collection('DP')
          .doc('2')
          .get()
          .then((value) => deliveryPrice = double.parse(value['discount']));
    }
    notifyListeners();
  }

  bool discount = false;

  void getDiscountSharedPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    discount = pref.getBool('discount') ?? false;
    notifyListeners();
  }

  Map<String, String> checkOut = {
    'area': ' ',
    'street': ' ',
    'phoneNum': ' ',
  };

  Map<String, String> details = {
    'area': '',
    'street': '',
    'phoneNum': '',
    'name': '',
    'latitude': '',
    'longitude': '',
    'total': '',
    'note': '',
    'resName': '',
    'delivery': '',
    'length': '',
  };

  List<FoodCart> detailedCart = [];

  // ---------------addresses----------------------
  List<Address> loc = [];

  Future<void> fetchAddress() async {
    var user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('address/${user!.uid}/addresses')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        bool exists = loc.any((e) => e.id == element.id);
        if (!exists)
          loc.add(Address(
              id: element.id,
              area: element['area'],
              street: element['street'],
              phoneNum: element['phoneNum']));
      });
    });
    notifyListeners();
  }

  Future<void> add(String area, String street, String phone) async {
    var user = FirebaseAuth.instance.currentUser;
    isLoading = true;
    await FirebaseFirestore.instance
        .collection('/address/${user!.uid}/addresses')
        .add({
      'area': area,
      'street': street,
      'phoneNum': phone,
    }).then((value) {
      loc.add(
          Address(id: value.id, area: area, street: street, phoneNum: phone));
    });
    notifyListeners();
  }

  var iD;

  delete() async {
    isLoading = true;
    var user = FirebaseAuth.instance.currentUser;
    final addressIndex = loc.indexWhere((element) => element.id == iD);
    loc.removeAt(addressIndex);
    await FirebaseFirestore.instance
        .collection('/address/${user!.uid}/addresses')
        .doc(iD)
        .delete();
    notifyListeners();
  }

  // --------------------------favorites-----------------------

  List<Favorites> myFavorites = [];

  Future<void> fetchFav() async {
    var user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('favorites/${user!.uid}/myFavorites')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        bool exists = myFavorites.any((e) => e.myFavoriteID == element.id);
        if (!exists) myFavorites.add(Favorites(myFavoriteID: element.id));
      });
    });
    notifyListeners();
  }

  toggleFavourite() async {
    var user = FirebaseAuth.instance.currentUser;
    final mealIndex = mealIDs.indexWhere((element) => element.id == mealID);
    final exists =
        myFavorites.indexWhere((element) => element.myFavoriteID == mealID);
    if (exists < 0) {
      await FirebaseFirestore.instance
          .collection('/favorites/${user!.uid}/myFavorites')
          .doc(mealID)
          .set({
        'meal name': mealIDs[mealIndex].mealName,
        'meal price': mealIDs[mealIndex].mealPrice,
        'description': mealIDs[mealIndex].description,
        'resName': mealIDs[mealIndex].resName,
      });
      myFavorites.add(Favorites(myFavoriteID: mealID));
    } else {
      await FirebaseFirestore.instance
          .collection('favorites/${user!.uid}/myFavorites')
          .doc(mealID)
          .delete()
          .then((value) {
        myFavorites.removeAt(exists);
      });
    }
    notifyListeners();
  }

  bool isMyFav(id) {
    return myFavorites.any((element) => element.myFavoriteID == id);
  }

  getIndexFav(i) {
    return mealIDs.indexWhere((element) => element.id == i);
  }

  //  -----------------------------------------food cart------------------------

  List<FoodCart> myCart = [];

  double total = 0;

  addPrice(price) {
    total += price;
    notifyListeners();
  }

  subtractPrice(price) {
    if (total != 0) total -= price;
    notifyListeners();
  }

  myCartClear() {
    myCart.clear();
    total = 0;
    notifyListeners();
  }

  Future<void> fetchCart() async {
    var user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('orders/${user!.uid}/myOrders')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        bool exists = myCart.any((e) => e.foodID == element.id);
        if (!exists)
          myCart.add(FoodCart(
              quantity: element['quantity'],
              foodID: element.id,
              mealPrice: element['meal name'],
              mealName: element['meal price'],
              resName: restaurantName,
              description: element['description']));
      });
    });
    notifyListeners();
  }

  var mealPrice;

  Future<void> addFoodCartPizza(counter) async {
    String desc = '';
    if (restaurantName == '?????????? ????????????')
      for (int i = 0; i < pizzaTypes.length; i++) {
        if (pizzaTypes[i].value) desc += pizzaTypes[i].title + ' , ';
      }
    else if (restaurantName == '?????????? ??????????????')
      for (int i = 0; i < pizzaTypes1.length; i++) {
        if (pizzaTypes1[i].value) desc += pizzaTypes1[i].title + ' , ';
      }
    int index = mealIDs.indexWhere((element) => element.id == mealID);
    myCart.add(FoodCart(
        quantity: counter,
        foodID: mealID,
        mealName: mealIDs[index].mealName,
        mealPrice: mealIDs[index].mealPrice,
        resName: mealIDs[index].resName,
        description: desc));
    addPrice(double.parse(mealIDs[index].mealPrice) * counter);
    notifyListeners();
  }

  Future<void> addFoodCartRadio(counter) async {
    int desc = restaurantName == '???????? ?????? ??????'
        ? riceTypes.indexWhere((element) => element.value == radioValue)
        : restaurantName == '?????????? ?????? ??????'
            ? riceTypes1.indexWhere((element) => element.value == radioValue1)
            : cakeTypes.indexWhere((element) => element.value == radioValue2);
    int index = mealIDs.indexWhere((element) => element.id == mealID);
    myCart.add(FoodCart(
        quantity: counter,
        foodID: mealID,
        mealName: mealIDs[index].mealName,
        mealPrice: mealIDs[index].mealPrice,
        resName: mealIDs[index].resName,
        description: restaurantName == '???????? ?????? ??????'
            ? riceTypes[desc].title
            : restaurantName == '?????????? ?????? ??????'
                ? riceTypes1[desc].title
                : cakeTypes[desc].title));
    addPrice(double.parse(mealIDs[index].mealPrice) * counter);
    notifyListeners();
  }

  Future<void> addFoodCartRadioMilk(counter, mealName) async {
    int desc = mealName.toString().startsWith('?????? ????????')
        ? iceCreamTypes3.indexWhere((element) => element.value == radioValue17)
        : mealName.toString() == '???????? ?????? ????????????' ||
                mealName.toString() == '???????? ?????? ????????'
            ? milkShakeTypes
                .indexWhere((element) => element.value == radioValue18)
            : mealName.toString().startsWith('????????')
                ? iceCreamTypes
                    .indexWhere((element) => element.value == radioValue8)
                : milkTypes
                    .indexWhere((element) => element.value == radioValue7);
    int index = mealIDs.indexWhere((element) => element.id == mealID);
    myCart.add(FoodCart(
        quantity: counter,
        foodID: mealID,
        mealName: mealIDs[index].mealName,
        mealPrice: mealIDs[index].mealPrice,
        resName: mealIDs[index].resName,
        description: mealName.toString().startsWith('?????? ????????')
            ? iceCreamTypes3[desc].title
            : mealName.toString() == '???????? ?????? ????????????' ||
                    mealName.toString() == '???????? ?????? ????????'
                ? milkShakeTypes[desc].title
                : mealName.toString().startsWith('????????')
                    ? iceCreamTypes[desc].title
                    : milkTypes[desc].title));
    addPrice(double.parse(mealIDs[index].mealPrice) * counter);
    notifyListeners();
  }

  Future<void> addFoodCartRadioSaloon(counter, mealName) async {
    int desc = restaurantName == '?????????????? ????????????-??????????' &&
            (mealName.toString() == '???????? ???????? 1 ????????' ||
                mealName.toString() == '???????? ???????? 1/2 ????????' ||
                mealName.toString() == '???????? ???????? ?????? ????????' ||
                mealName.toString() == '???????? ???????? ?????? ????????')
        ? iceCreamTypes2.indexWhere((element) => element.value == radioValue12)
        : mealName.toString() == '???????? ???????? ????????' ||
                mealName.toString() == '???????? ???????? ????????' ||
                mealName.toString() == '???????? ???????? ???????? ????????'
            ? saloonTypes1
                .indexWhere((element) => element.value == radioValue10)
            : saloonTypes2
                .indexWhere((element) => element.value == radioValue11);
    int index = mealIDs.indexWhere((element) => element.id == mealID);
    myCart.add(FoodCart(
        quantity: counter,
        foodID: mealID,
        mealName: mealIDs[index].mealName,
        mealPrice: mealIDs[index].mealPrice,
        resName: mealIDs[index].resName,
        description: restaurantName == '?????????????? ????????????-??????????' &&
                (mealName.toString() == '???????? ???????? 1 ????????' ||
                    mealName.toString() == '???????? ???????? 1/2 ????????' ||
                    mealName.toString() == '???????? ???????? ?????? ????????' ||
                    mealName.toString() == '???????? ???????? ?????? ????????')
            ? iceCreamTypes2[desc].title
            : mealName.toString() == '???????? ???????? ????????' ||
                    mealName.toString() == '???????? ???????? ????????' ||
                    mealName.toString() == '???????? ???????? ???????? ????????'
                ? saloonTypes1[desc].title
                : saloonTypes2[desc].title));
    addPrice(double.parse(mealIDs[index].mealPrice) * counter);
    notifyListeners();
  }

  Future<void> addFoodCartRadioHot(counter) async {
    int desc = hotTypes.indexWhere((element) => element.value == radioValue9);
    int index = mealIDs.indexWhere((element) => element.id == mealID);
    myCart.add(FoodCart(
        quantity: counter,
        foodID: mealID,
        mealName: mealIDs[index].mealName,
        mealPrice: mealIDs[index].mealPrice,
        resName: mealIDs[index].resName,
        description: hotTypes[desc].title));
    addPrice(double.parse(mealIDs[index].mealPrice) * counter);
    notifyListeners();
  }

  Future<void> addFoodCartRadioMo3ajanat(counter, mealName) async {
    int desc = mealName.toString().startsWith('??????????')
        ? pizzaTypes2.indexWhere((element) => element.value == radioValue3)
        : mealName == '???????????? ????????'
            ? mo3ajanat1.indexWhere((element) => element.value == radioValue4)
            : mealName == '???????????? ????????'
                ? mo3ajanat2
                    .indexWhere((element) => element.value == radioValue5)
                : mo3ajanat3
                    .indexWhere((element) => element.value == radioValue6);
    int index = mealIDs.indexWhere((element) => element.id == mealID);
    myCart.add(FoodCart(
        quantity: counter,
        foodID: mealID,
        mealName: mealIDs[index].mealName,
        mealPrice: mealIDs[index].mealPrice,
        resName: mealIDs[index].resName,
        description: mealName.toString().startsWith('??????????')
            ? pizzaTypes2[desc].title
            : mealName == '???????????? ????????'
                ? mo3ajanat1[desc].title
                : mealName == '???????????? ????????'
                    ? mo3ajanat2[desc].title
                    : mo3ajanat3[desc].title));
    addPrice(double.parse(mealIDs[index].mealPrice) * counter);
    notifyListeners();
  }

  Future<void> addFoodCartRadioMo3ajanat1(counter, mealName) async {
    int desc = mealName.toString() == '??????????'
        ? pizzaTypes3.indexWhere((element) => element.value == radioValue13)
        : mo3ajanat4.indexWhere((element) => element.value == radioValue14);
    int index = mealIDs.indexWhere((element) => element.id == mealID);
    myCart.add(FoodCart(
        quantity: counter,
        foodID: mealID,
        mealName: mealIDs[index].mealName,
        mealPrice: mealIDs[index].mealPrice,
        resName: mealIDs[index].resName,
        description: mealName.toString() == '??????????'
            ? pizzaTypes3[desc].title
            : mo3ajanat4[desc].title));
    addPrice(double.parse(mealIDs[index].mealPrice) * counter);
    notifyListeners();
  }

  Future<void> addFoodCartRadioLebanese(counter, mealName) async {
    int desc = mealName.toString().startsWith('????????')
        ? naturalSlush.indexWhere((element) => element.value == radioValue16)
        : naturalDrinks.indexWhere((element) => element.value == radioValue15);
    int index = mealIDs.indexWhere((element) => element.id == mealID);
    myCart.add(FoodCart(
        quantity: counter,
        foodID: mealID,
        mealName: mealIDs[index].mealName,
        mealPrice: mealIDs[index].mealPrice,
        resName: mealIDs[index].resName,
        description: mealName.toString().startsWith('????????')
            ? naturalSlush[desc].title
            : naturalDrinks[desc].title));
    addPrice(double.parse(mealIDs[index].mealPrice) * counter);
    notifyListeners();
  }

  Future<void> addFoodCartTypes(price, desc, mealName) async {
    int index = myCart.indexWhere((element) =>
        element.description == desc &&
        element.mealPrice == price &&
        element.mealName == mealName);
    myCart[index].quantity++;
    addPrice(double.parse(price));
    notifyListeners();
  }

  Future<void> addFoodCart(String mealName, String price, desc) async {
    bool exists = myCart.any((element) => element.foodID == mealID);
    if (!exists)
      myCart.add(FoodCart(
          quantity: 1,
          foodID: mealID,
          mealName: mealName,
          mealPrice: price,
          resName: restaurantName,
          description: desc));
    else {
      int index = myCart.indexWhere((element) => element.foodID == mealID);
      myCart[index].quantity++;
    }
    addPrice(double.parse(price));
    notifyListeners();
  }

  Future<void> removeFoodCartTypes(price, desc, mealName) async {
    int index = myCart.indexWhere((element) =>
        element.description == desc &&
        element.mealPrice == price &&
        element.mealName == mealName);
    if (myCart[index].quantity == 1)
      myCart.removeAt(index);
    else
      myCart[index].quantity--;
    subtractPrice(double.parse(price));
    notifyListeners();
  }

  Future<void> removeFoodCart(price) async {
    int index = myCart.indexWhere((element) => element.foodID == mealID);
    if (myCart[index].quantity == 1)
      myCart.removeAt(index);
    else
      myCart[index].quantity--;
    subtractPrice(double.parse(price));
    notifyListeners();
  }

  Future<void> addToDB(String note) async {
    isLoading = true;
    var uuid = Uuid().v4();
    var user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('orders/${user!.uid}/myOrders')
        .doc(uuid)
        .set({
      'date': DateTime.now(),
      'total': total.toStringAsFixed(2),
      'delivery': deliveryPrice,
      'note': note,
      'length': myCart.length,
      'resName': myCart[0].resName,
      'details': {
        'area': checkOut['area'],
        'street': checkOut['street'],
        'phoneNum': checkOut['phoneNum'],
      },
      'meals': [
        for (int i = 0; i < myCart.length; i++)
          {
            'meal name': myCart[i].mealName,
            'meal price': myCart[i].mealPrice,
            'quantity': myCart[i].quantity,
            'description': myCart[i].description,
          }
      ],
    });
    await FirebaseFirestore.instance.collection('allOrders').doc(uuid).set({
      'date': DateTime.now(),
      'total': total.toStringAsFixed(2),
      'note': note,
      'isChecked': false,
      'resName': myCart[0].resName,
      'length': myCart.length,
      'details': {
        'latitude': lat,
        'longitude': long,
        'area': checkOut['area'],
        'street': checkOut['street'],
        'phoneNum': checkOut['phoneNum'],
        'name': authData['name'],
      },
      'meals': [
        for (int i = 0; i < myCart.length; i++)
          {
            'meal name': myCart[i].mealName,
            'meal price': myCart[i].mealPrice,
            'quantity': myCart[i].quantity,
            'description': myCart[i].description,
          }
      ],
    });
    isLoading = false;
    notifyListeners();
  }

  Future<void> reorder(
      total1, dp, note, length, resName, area1, street1, phoneNum) async {
    isLoading = true;
    var uuid = Uuid().v4();
    var user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('orders/${user!.uid}/myOrders')
        .doc(uuid)
        .set({
      'date': DateTime.now(),
      'total': total1.toString(),
      'delivery': dp.toString(),
      'note': note,
      'length': length,
      'resName': resName,
      'details': {
        'area': area1,
        'street': street1,
        'phoneNum': phoneNum,
      },
      'meals': [
        for (int i = 0; i < length; i++)
          {
            'meal name': myCart[i].mealName,
            'meal price': myCart[i].mealPrice,
            'quantity': myCart[i].quantity,
            'description': myCart[i].description,
          }
      ],
    });
    await FirebaseFirestore.instance.collection('allOrders').doc(uuid).set({
      'date': DateTime.now(),
      'total': total1,
      'note': note,
      'isChecked': false,
      'resName': resName,
      'length': length,
      'details': {
        'latitude': lat,
        'longitude': long,
        'area': area1,
        'street': street1,
        'phoneNum': phoneNum,
        'name': authData['name'],
      },
      'meals': [
        for (int i = 0; i < length; i++)
          {
            'meal name': myCart[i].mealName,
            'meal price': myCart[i].mealPrice,
            'quantity': myCart[i].quantity,
            'description': myCart[i].description,
          }
      ],
    });

    isLoading = false;
    notifyListeners();
  }

  getIndex(i) {
    var index = myCart.indexWhere((element) => element.foodID == i);
    return index;
  }

  bool existsInCart(id) {
    return myCart.any((element) => element.foodID == id);
  }

  //-----------------------admin----------------------------

  Future<void> fetchMealsShawarma(title) async {
    if (restaurantName != 'Snap Burger' && restaurantName != '???????????? ????????')
      await FirebaseFirestore.instance
          .collection('shawarma/$title/shawarma')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          bool exists = mealIDs.any((e) => e.id == element.id);
          if (!exists)
            mealIDs.add(Meals(
                resName: title,
                mealName: element.data()['meal name'],
                mealPrice: element.data()['meal price'],
                description: element.data()['description'],
                id: element.id));
        });
      });
    if (restaurantName == '??????????????') {
      await FirebaseFirestore.instance
          .collection('shawarma/$title/Chicken')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          bool exists = mealIDs.any((e) => e.id == element.id);
          if (!exists)
            mealIDs.add(Meals(
                mealName: element.data()['meal name'],
                mealPrice: element.data()['meal price'],
                description: element.data()['description'],
                id: element.id,
                resName: title));
        });
      });
      await FirebaseFirestore.instance
          .collection('shawarma/$title/Aldwairy')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          bool exists = mealIDs.any((e) => e.id == element.id);
          if (!exists)
            mealIDs.add(Meals(
                mealName: element.data()['meal name'],
                mealPrice: element.data()['meal price'],
                description: element.data()['description'],
                id: element.id,
                resName: title));
        });
      });
      await FirebaseFirestore.instance
          .collection('shawarma/$title/BreakFast')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          bool exists = mealIDs.any((e) => e.id == element.id);
          if (!exists)
            mealIDs.add(Meals(
                mealName: element.data()['meal name'],
                mealPrice: element.data()['meal price'],
                description: element.data()['description'],
                id: element.id,
                resName: title));
        });
      });
    }
    if (restaurantName == '?????? ??????') {
      await FirebaseFirestore.instance
          .collection('shawarma/$title/Falafel')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          bool exists = mealIDs.any((e) => e.id == element.id);
          if (!exists)
            mealIDs.add(Meals(
                mealName: element.data()['meal name'],
                mealPrice: element.data()['meal price'],
                description: element.data()['description'],
                id: element.id,
                resName: title));
        });
      });
      await FirebaseFirestore.instance
          .collection('shawarma/$title/Mo3ajanat')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          bool exists = mealIDs.any((e) => e.id == element.id);
          if (!exists)
            mealIDs.add(Meals(
                mealName: element.data()['meal name'],
                mealPrice: element.data()['meal price'],
                description: element.data()['description'],
                id: element.id,
                resName: title));
        });
      });
      await FirebaseFirestore.instance
          .collection('shawarma/$title/Hummus')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          bool exists = mealIDs.any((e) => e.id == element.id);
          if (!exists)
            mealIDs.add(Meals(
                mealName: element.data()['meal name'],
                mealPrice: element.data()['meal price'],
                description: element.data()['description'],
                id: element.id,
                resName: title));
        });
      });
    }
    if (restaurantName != '???????????? ????????' &&
        restaurantName != '??????????????' &&
        restaurantName != '?????? ??????')
      await FirebaseFirestore.instance
          .collection('shawarma/$title/snacks')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          bool exists = mealIDs.any((e) => e.id == element.id);
          if (!exists)
            mealIDs.add(Meals(
                mealName: element.data()['meal name'],
                mealPrice: element.data()['meal price'],
                description: element.data()['description'],
                id: element.id,
                resName: title));
        });
      });
    await FirebaseFirestore.instance
        .collection('shawarma/$title/others')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        bool exists = mealIDs.any((e) => e.id == element.id);
        if (!exists)
          mealIDs.add(Meals(
              mealName: element.data()['meal name'],
              mealPrice: element.data()['meal price'],
              description: element.data()['description'],
              id: element.id,
              resName: title));
      });
    });
    notifyListeners();
  }

  Future<void> fetchMealsPizza(title) async {
    await FirebaseFirestore.instance
        .collection('Pizza/$title/Pizza')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        bool exists = mealIDs.any((e) => e.id == element.id);
        if (!exists)
          mealIDs.add(Meals(
              resName: title,
              mealName: element.data()['meal name'],
              mealPrice: element.data()['meal price'],
              description: element.data()['description'],
              id: element.id));
      });
    });
    if (restaurantName == '?????????? ????????????')
      await FirebaseFirestore.instance
          .collection('Pizza/$title/broasted')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          bool exists = mealIDs.any((e) => e.id == element.id);
          if (!exists)
            mealIDs.add(Meals(
                mealName: element.data()['meal name'],
                mealPrice: element.data()['meal price'],
                description: element.data()['description'],
                id: element.id,
                resName: title));
        });
      });
    await FirebaseFirestore.instance
        .collection('Pizza/$title/others')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        bool exists = mealIDs.any((e) => e.id == element.id);
        if (!exists)
          mealIDs.add(Meals(
              mealName: element.data()['meal name'],
              mealPrice: element.data()['meal price'],
              description: element.data()['description'],
              id: element.id,
              resName: title));
      });
    });
    notifyListeners();
  }

  Future<void> fetchMealsMo3ajanat(title) async {
    if (restaurantName == '???????????? ??????') {
      await FirebaseFirestore.instance
          .collection('mainRes/$title/manakeesh')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          bool exists = mealIDs.any((e) => e.id == element.id);
          if (!exists)
            mealIDs.add(Meals(
                resName: title,
                mealName: element.data()['meal name'],
                mealPrice: element.data()['meal price'],
                description: element.data()['description'],
                id: element.id));
        });
      });
    }
    await FirebaseFirestore.instance
        .collection('mainRes/$title/Pizza')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        bool exists = mealIDs.any((e) => e.id == element.id);
        if (!exists)
          mealIDs.add(Meals(
              resName: title,
              mealName: element.data()['meal name'],
              mealPrice: element.data()['meal price'],
              description: element.data()['description'],
              id: element.id));
      });
    });
    if (restaurantName == '???????? ??????????')
      await FirebaseFirestore.instance
          .collection('mainRes/$title/mashrouh')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          bool exists = mealIDs.any((e) => e.id == element.id);
          if (!exists)
            mealIDs.add(Meals(
                mealName: element.data()['meal name'],
                mealPrice: element.data()['meal price'],
                description: element.data()['description'],
                id: element.id,
                resName: title));
        });
      });
    await FirebaseFirestore.instance
        .collection('mainRes/$title/others')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        bool exists = mealIDs.any((e) => e.id == element.id);
        if (!exists)
          mealIDs.add(Meals(
              mealName: element.data()['meal name'],
              mealPrice: element.data()['meal price'],
              description: element.data()['description'],
              id: element.id,
              resName: title));
      });
    });
    notifyListeners();
  }

  Future<void> fetchMealsRice(title) async {
    await FirebaseFirestore.instance
        .collection('rice/$title/riceTypes')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        bool exists = mealIDs.any((e) => e.id == element.id);
        if (!exists)
          mealIDs.add(Meals(
              resName: title,
              mealName: element.data()['meal name'],
              mealPrice: element.data()['meal price'],
              description: element.data()['description'],
              id: element.id));
      });
    });
    await FirebaseFirestore.instance
        .collection('rice/$title/rice')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        bool exists = mealIDs.any((e) => e.id == element.id);
        if (!exists)
          mealIDs.add(Meals(
              mealName: element.data()['meal name'],
              mealPrice: element.data()['meal price'],
              description: element.data()['description'],
              id: element.id,
              resName: title));
      });
    });
    await FirebaseFirestore.instance
        .collection('rice/$title/others')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        bool exists = mealIDs.any((e) => e.id == element.id);
        if (!exists)
          mealIDs.add(Meals(
              mealName: element.data()['meal name'],
              mealPrice: element.data()['meal price'],
              description: element.data()['description'],
              id: element.id,
              resName: title));
      });
    });
    notifyListeners();
  }

  Future<void> fetchMealsDrinks(title) async {
    if (restaurantName != '????????????' && restaurantName != '???????????? ????????????')
      await FirebaseFirestore.instance
          .collection('drinks/$title/meals')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          bool exists = mealIDs.any((e) => e.id == element.id);
          if (!exists)
            mealIDs.add(Meals(
                mealName: element.data()['meal name'],
                mealPrice: element.data()['meal price'],
                description: element.data()['description'],
                id: element.id,
                resName: title));
        });
      });
    else if (restaurantName == '????????????') {
      await FirebaseFirestore.instance
          .collection('drinks/$title/milk')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          bool exists = mealIDs.any((e) => e.id == element.id);
          if (!exists)
            mealIDs.add(Meals(
                mealName: element.data()['meal name'],
                mealPrice: element.data()['meal price'],
                description: element.data()['description'],
                id: element.id,
                resName: title));
        });
      });
      await FirebaseFirestore.instance
          .collection('drinks/$title/mixes')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          bool exists = mealIDs.any((e) => e.id == element.id);
          if (!exists)
            mealIDs.add(Meals(
                mealName: element.data()['meal name'],
                mealPrice: element.data()['meal price'],
                description: element.data()['description'],
                id: element.id,
                resName: title));
        });
      });
      await FirebaseFirestore.instance
          .collection('drinks/$title/hot drinks')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          bool exists = mealIDs.any((e) => e.id == element.id);
          if (!exists)
            mealIDs.add(Meals(
                mealName: element.data()['meal name'],
                mealPrice: element.data()['meal price'],
                description: element.data()['description'],
                id: element.id,
                resName: title));
        });
      });
    } else if (restaurantName == '???????????? ????????????') {
      await FirebaseFirestore.instance
          .collection('drinks/$title/milk')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          bool exists = mealIDs.any((e) => e.id == element.id);
          if (!exists)
            mealIDs.add(Meals(
                mealName: element.data()['meal name'],
                mealPrice: element.data()['meal price'],
                description: element.data()['description'],
                id: element.id,
                resName: title));
        });
      });
      await FirebaseFirestore.instance
          .collection('drinks/$title/natural cocktail')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          bool exists = mealIDs.any((e) => e.id == element.id);
          if (!exists)
            mealIDs.add(Meals(
                mealName: element.data()['meal name'],
                mealPrice: element.data()['meal price'],
                description: element.data()['description'],
                id: element.id,
                resName: title));
        });
      });
      await FirebaseFirestore.instance
          .collection('drinks/$title/natural drinks')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          bool exists = mealIDs.any((e) => e.id == element.id);
          if (!exists)
            mealIDs.add(Meals(
                mealName: element.data()['meal name'],
                mealPrice: element.data()['meal price'],
                description: element.data()['description'],
                id: element.id,
                resName: title));
        });
      });
      await FirebaseFirestore.instance
          .collection('drinks/$title/special cocktail')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          bool exists = mealIDs.any((e) => e.id == element.id);
          if (!exists)
            mealIDs.add(Meals(
                mealName: element.data()['meal name'],
                mealPrice: element.data()['meal price'],
                description: element.data()['description'],
                id: element.id,
                resName: title));
        });
      });
      await FirebaseFirestore.instance
          .collection('drinks/$title/natural slush')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          bool exists = mealIDs.any((e) => e.id == element.id);
          if (!exists)
            mealIDs.add(Meals(
                mealName: element.data()['meal name'],
                mealPrice: element.data()['meal price'],
                description: element.data()['description'],
                id: element.id,
                resName: title));
        });
      });
      await FirebaseFirestore.instance
          .collection('drinks/$title/fruits salads')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          bool exists = mealIDs.any((e) => e.id == element.id);
          if (!exists)
            mealIDs.add(Meals(
                mealName: element.data()['meal name'],
                mealPrice: element.data()['meal price'],
                description: element.data()['description'],
                id: element.id,
                resName: title));
        });
      });
      await FirebaseFirestore.instance
          .collection('drinks/$title/waffle')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          bool exists = mealIDs.any((e) => e.id == element.id);
          if (!exists)
            mealIDs.add(Meals(
                mealName: element.data()['meal name'],
                mealPrice: element.data()['meal price'],
                description: element.data()['description'],
                id: element.id,
                resName: title));
        });
      });
    }
    notifyListeners();
  }

  Future<void> fetchMealsMain(title) async {
    await FirebaseFirestore.instance
        .collection('mainRes/$title/meals')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        bool exists = mealIDs.any((e) => e.id == element.id);
        if (!exists)
          mealIDs.add(Meals(
              mealName: element.data()['meal name'],
              mealPrice: element.data()['meal price'],
              description: element.data()['description'],
              id: element.id,
              resName: title));
      });
    });
    notifyListeners();
  }

  Future<void> fetchMealsSweets(title) async {
    if (restaurantName == '??????????' || restaurantName == '?????????????? ????????????-??????????')
      await FirebaseFirestore.instance
          .collection('sweets/$title/gateau')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          bool exists = mealIDs.any((e) => e.id == element.id);
          if (!exists)
            mealIDs.add(Meals(
                mealName: element.data()['meal name'],
                mealPrice: element.data()['meal price'],
                description: element.data()['description'],
                id: element.id,
                resName: title));
        });
      });
    await FirebaseFirestore.instance
        .collection('sweets/$title/kunafeh')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        bool exists = mealIDs.any((e) => e.id == element.id);
        if (!exists)
          mealIDs.add(Meals(
              mealName: element.data()['meal name'],
              mealPrice: element.data()['meal price'],
              description: element.data()['description'],
              id: element.id,
              resName: title));
      });
    });
    if (restaurantName == '?????????????? ????????????-??????????') {
      await FirebaseFirestore.instance
          .collection('sweets/$title/snacks')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          bool exists = mealIDs.any((e) => e.id == element.id);
          if (!exists)
            mealIDs.add(Meals(
                mealName: element.data()['meal name'],
                mealPrice: element.data()['meal price'],
                description: element.data()['description'],
                id: element.id,
                resName: title));
        });
      });
      await FirebaseFirestore.instance
          .collection('sweets/$title/pizza')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          bool exists = mealIDs.any((e) => e.id == element.id);
          if (!exists)
            mealIDs.add(Meals(
                mealName: element.data()['meal name'],
                mealPrice: element.data()['meal price'],
                description: element.data()['description'],
                id: element.id,
                resName: title));
        });
      });
      await FirebaseFirestore.instance
          .collection('sweets/$title/rolls')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          bool exists = mealIDs.any((e) => e.id == element.id);
          if (!exists)
            mealIDs.add(Meals(
                mealName: element.data()['meal name'],
                mealPrice: element.data()['meal price'],
                description: element.data()['description'],
                id: element.id,
                resName: title));
        });
      });
      await FirebaseFirestore.instance
          .collection('sweets/$title/waffle')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          bool exists = mealIDs.any((e) => e.id == element.id);
          if (!exists)
            mealIDs.add(Meals(
                mealName: element.data()['meal name'],
                mealPrice: element.data()['meal price'],
                description: element.data()['description'],
                id: element.id,
                resName: title));
        });
      });
      await FirebaseFirestore.instance
          .collection('sweets/$title/ice cream')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          bool exists = mealIDs.any((e) => e.id == element.id);
          if (!exists)
            mealIDs.add(Meals(
                mealName: element.data()['meal name'],
                mealPrice: element.data()['meal price'],
                description: element.data()['description'],
                id: element.id,
                resName: title));
        });
      });
    }
    if (restaurantName != '?????????????? ????????????-??????????')
      await FirebaseFirestore.instance
          .collection('sweets/$title/cake')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          bool exists = mealIDs.any((e) => e.id == element.id);
          if (!exists)
            mealIDs.add(Meals(
                mealName: element.data()['meal name'],
                mealPrice: element.data()['meal price'],
                description: element.data()['description'],
                id: element.id,
                resName: title));
        });
      });
    await FirebaseFirestore.instance
        .collection('sweets/$title/others')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        bool exists = mealIDs.any((e) => e.id == element.id);
        if (!exists)
          mealIDs.add(Meals(
              mealName: element.data()['meal name'],
              mealPrice: element.data()['meal price'],
              description: element.data()['description'],
              id: element.id,
              resName: title));
      });
    });
    notifyListeners();
  }

  Future<void> sendToRestaurant() async {
    isLoading = true;
    await FirebaseFirestore.instance
        .collection('restaurants orders/${detailedCart[0].resName}/orders')
        .add({
      'name': details['name'],
      'date': DateTime.now(),
      'isChecked': false,
      'length': details['length'],
      'meals': [
        for (int i = 0; i < int.parse(details['length']!); i++)
          {
            'meal name': detailedCart[i].mealName,
            'meal price': detailedCart[i].mealPrice,
            'quantity': detailedCart[i].quantity,
            'description': detailedCart[i].description,
          }
      ],
      'note': details['note'],
      'total': details['total'],
    });
    isLoading = false;
    notifyListeners();
  }

  //------------------------auth----------------------
  authStatus authState = authStatus.Authenticated;
  Map<String, String> authData = {
    'email': '',
    'password': '',
    'name': '',
    'latitude': '',
    'longitude': '',
  };

  fetch() async {
    final userData = FirebaseAuth.instance.currentUser;
    if (userData != null)
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userData.uid)
          .get()
          .then((val) {
        authData['email'] = val.data()?['email'];
        authData['password'] = val.data()?['password'];
        authData['name'] = val.data()?['username'];
        authData['latitude'] = val.data()?['latitude'].toString() ?? "0";
        authData['longitude'] = val.data()?['longitude'].toString() ?? "0";
        notifyListeners();
      });
  }

//  ---------------------------location------------------------------------------

  var lat;

  var long;
  bool approved = false;

  sendLocationToDB(BuildContext ctx) async {
    isLoading = true;
    var user = FirebaseAuth.instance.currentUser;

    var serviceEnabled = await Location().serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await Location().requestService();
      if (!serviceEnabled)
        return Fluttertoast.showToast(
            msg: Provider.of<LanProvider>(ctx, listen: false)
                .texts('must location on'),
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 16.0);
    }

    var permission = await Location().hasPermission();
    if (permission == PermissionStatus.denied) {
      permission = await Location().requestPermission();
      if (permission != PermissionStatus.granted)
        return Fluttertoast.showToast(
            msg: Provider.of<LanProvider>(ctx, listen: false)
                .texts('must location on'),
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 16.0);
    }
    var location = await Location().getLocation();
    await FirebaseFirestore.instance.collection('users').doc(user!.uid).update({
      'latitude': location.latitude,
      'longitude': location.longitude,
    });
    lat = location.latitude;
    long = location.longitude;
    Fluttertoast.showToast(
        msg: Provider.of<LanProvider>(ctx, listen: false).texts('location'),
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0);
    isLoading = false;
    approved = true;
    notifyListeners();
  }

  goToMaps(double long, double lat) async {
    isLoading = true;
    String url = "https://www.google.com/maps/search/?api=1&query=$lat,$long";
    final String encodeUrl = Uri.encodeFull(url);
    // if (!await canLaunch(encodeUrl))
    await launch(encodeUrl);
    // else
    //   {
    //     print('could not launch url');
    //     throw 'could not launch url';
    //   }
    isLoading = false;
  }
}
