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
    'file/مكسات.jpg',
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
    TypesClass(title: 'سلامي '),
    TypesClass(title: 'ببروني '),
    TypesClass(title: 'دجاج '),
    TypesClass(title: 'خضار '),
    TypesClass(title: 'مرغريتا '),
    TypesClass(title: 'زنجر '),
    TypesClass(title: 'هوت دوغ '),
  ];

  List<TypesClass> pizzaTypes1 = <TypesClass>[
    TypesClass(title: 'سلامي'),
    TypesClass(title: 'ببروني'),
    TypesClass(title: 'دجاج'),
    TypesClass(title: 'خضار'),
    TypesClass(title: 'مرغريتا'),
    TypesClass(title: 'لحم بقري مدخن'),
    TypesClass(title: 'تيركي'),
    TypesClass(title: 'سجق حلبي'),
    TypesClass(title: 'زنجر حار'),
    TypesClass(title: 'زنجر حلو'),
    TypesClass(title: 'الفريدو'),
  ];

  List<Types2Class> pizzaTypes2 = <Types2Class>[
    Types2Class(title: 'خضار  ', value: 0),
    Types2Class(title: 'نقانق  ', value: 1),
    Types2Class(title: 'دجاج  ', value: 2),
    Types2Class(title: 'مدخن  ', value: 3),
    Types2Class(title: 'مرغريتا  ', value: 4),
    Types2Class(title: 'ببروني  ', value: 5),
    Types2Class(title: 'بابريكا  ', value: 6),
    Types2Class(title: 'سوبر سوبريم  ', value: 7),
    Types2Class(title: 'دجاج مع خضار  ', value: 8),
    Types2Class(title: 'سجق حلبي  ', value: 9),
  ];

  List<Types2Class> mo3ajanat1 = <Types2Class>[
    Types2Class(title: 'جبنة بيضاء', value: 0),
    Types2Class(title: 'صفيحة لحمة', value: 1),
    Types2Class(title: 'زعتر', value: 2),
    Types2Class(title: 'زيتون', value: 3),
    Types2Class(title: 'سبانخ', value: 4),
    Types2Class(title: 'بطاطا', value: 5),
    Types2Class(title: 'محمرة', value: 6),
    Types2Class(title: 'زعتر مع محمرة', value: 7),
  ];
  List<Types2Class> mo3ajanat2 = <Types2Class>[
    Types2Class(title: 'قشقوان', value: 0),
    Types2Class(title: 'زيتون وقشقوان', value: 1),
    Types2Class(title: 'محمرة وقشقوان', value: 2),
    Types2Class(title: 'زعتر وقشقوان', value: 3),
    Types2Class(title: 'سنيورة وقشقوان', value: 4),
    Types2Class(title: 'نقانق وقشقوان', value: 5),
    Types2Class(title: 'بطاطا وقشقوان', value: 6),
    Types2Class(title: 'سجق حلبي', value: 7),
    Types2Class(title: 'مكس اجبان', value: 8),
    Types2Class(title: 'جبنة وزعتر', value: 9),
    Types2Class(title: 'جبنة صفراء كبير', value: 10),
  ];
  List<Types2Class> mo3ajanat3 = <Types2Class>[
    Types2Class(title: 'بيتزا', value: 0),
    Types2Class(title: 'لحمة بعلبكية', value: 1),
    Types2Class(title: 'جبنة', value: 2),
    Types2Class(title: 'محمرة وقشقوان', value: 3),
    Types2Class(title: 'نقانق وقشقوان', value: 4),
    Types2Class(title: 'زيتون وقشقوان', value: 5),
    Types2Class(title: 'جبنة صفراء', value: 6),
    Types2Class(title: 'زعتر', value: 7),
    Types2Class(title: 'بطاطا', value: 8),
  ];

  List<Types2Class> riceTypes = <Types2Class>[
    Types2Class(title: 'زربيان', value: 0),
    Types2Class(title: 'مندي', value: 1),
    Types2Class(title: 'مظبي', value: 2),
    Types2Class(title: 'برياني', value: 3),
    Types2Class(title: 'مضغوط', value: 4),
  ];

  List<Types2Class> riceTypes1 = <Types2Class>[
    Types2Class(title: 'زربيان', value: 0),
    Types2Class(title: 'مندي', value: 1),
    Types2Class(title: 'مدفون', value: 2),
    Types2Class(title: 'برياني', value: 3),
    Types2Class(title: 'مضغوط', value: 4),
    Types2Class(title: 'زرب', value: 5),
  ];

  List<Types2Class> cakeTypes = <Types2Class>[
    Types2Class(title: 'فانيلا', value: 0),
    Types2Class(title: 'فراولة  ', value: 1),
    Types2Class(title: 'نوتيلا  ', value: 2),
  ];

  List<Types2Class> milkTypes = <Types2Class>[
    Types2Class(title: 'لوتس', value: 0),
    Types2Class(title: 'سنكرز', value: 1),
    Types2Class(title: 'نوتيلا', value: 2),
    Types2Class(title: 'اوريو', value: 3),
    Types2Class(title: 'عربي', value: 4),
    Types2Class(title: 'تشيز كيك', value: 5),
    Types2Class(title: 'كت كات', value: 6),
    Types2Class(title: 'فراولة', value: 7),
    Types2Class(title: 'سيريلاك', value: 8),
  ];

  List<Types2Class> iceCreamTypes = <Types2Class>[
    Types2Class(title: 'لوتس ', value: 0),
    Types2Class(title: 'سنكرز ', value: 1),
    Types2Class(title: 'اوريو ', value: 2),
    Types2Class(title: 'عربي ', value: 3),
    Types2Class(title: 'تشيز كيك ', value: 4),
    Types2Class(title: 'كت كات ', value: 5),
    Types2Class(title: 'فراولة ', value: 6),
    Types2Class(title: 'شوكولاته ', value: 7),
    Types2Class(title: 'فانيلا ', value: 8),
  ];

  List<Types2Class> hotTypes = <Types2Class>[
    Types2Class(title: 'حلوه', value: 0),
    Types2Class(title: 'وسط', value: 1),
    Types2Class(title: 'ساده', value: 2),
  ];

  List<Types2Class> saloonTypes1 = <Types2Class>[
    Types2Class(title: 'شوكولاتة', value: 0),
    Types2Class(title: 'فانيلا', value: 1),
    Types2Class(title: 'رد فيلفيت', value: 2),
    Types2Class(title: 'فواكة', value: 3),
  ];

  List<Types2Class> saloonTypes2 = <Types2Class>[
    Types2Class(title: 'شوكولاتة ', value: 0),
    Types2Class(title: 'فانيلا ', value: 1),
    Types2Class(title: 'بابلي', value: 2),
    Types2Class(title: 'فواكة ', value: 3),
  ];

  List<Types2Class> iceCreamTypes2 = <Types2Class>[
    Types2Class(title: 'بوظه عربي', value: 0),
    Types2Class(title: 'فراولة', value: 1),
    Types2Class(title: 'شوكولاته', value: 2),
    Types2Class(title: 'اوريو', value: 3),
    Types2Class(title: 'تشيز كيك', value: 4),
    Types2Class(title: 'فواكه', value: 5),
    Types2Class(title: 'كراميل', value: 6),
  ];

  List<Types2Class> pizzaTypes3 = <Types2Class>[
    Types2Class(title: 'دجاج', value: 0),
    Types2Class(title: 'لحمة', value: 1),
    Types2Class(title: 'خضار', value: 2),
    Types2Class(title: 'تيركي', value: 3),
    Types2Class(title: 'مارغريت', value: 4),
    Types2Class(title: 'نقانق', value: 5),
    Types2Class(title: 'سنيورة', value: 6),
  ];

  List<Types2Class> mo3ajanat4 = <Types2Class>[
    Types2Class(title: 'جبنة بيضاء', value: 0),
    Types2Class(title: 'جبنة صفراء', value: 1),
    Types2Class(title: 'لحمة', value: 2),
    Types2Class(title: 'سنيورة بالجبنة', value: 3),
    Types2Class(title: 'بيتزا صغير', value: 4),
    Types2Class(title: 'سبانخ', value: 5),
    Types2Class(title: 'نقانق', value: 6),
    Types2Class(title: 'كبة', value: 7),
  ];

  List<Types2Class> naturalDrinks = <Types2Class>[
    Types2Class(title: 'كيوي', value: 0),
    Types2Class(title: 'جزر', value: 1),
    Types2Class(title: 'ليمون', value: 2),
    Types2Class(title: 'جريب فروت', value: 3),
    Types2Class(title: 'بندورة', value: 4),
    Types2Class(title: 'برتقال', value: 5),
    Types2Class(title: 'اناناس', value: 6),
    Types2Class(title: 'فراوله', value: 7),
    Types2Class(title: 'مانجا', value: 8),
    Types2Class(title: 'تفاح', value: 9),
  ];

  List<Types2Class> naturalSlush = <Types2Class>[
    Types2Class(title: ' برتقال', value: 0),
    Types2Class(title: 'ليمون ', value: 1),
    Types2Class(title: 'فراولة ', value: 2),
    Types2Class(title: 'جوافة ', value: 3),
  ];

  List<Types2Class> iceCreamTypes3 = <Types2Class>[
    Types2Class(title: 'توتي فروتي ', value: 0),
    Types2Class(title: 'شوكولاته مو ', value: 1),
    Types2Class(title: 'ستروبري شيك ', value: 2),
    Types2Class(title: 'بنانا سبليت ', value: 3),
    Types2Class(title: 'بنانا بيري ', value: 4),
    Types2Class(title: 'بنانا شوكليت ', value: 5),
  ];

  List<Types2Class> milkShakeTypes = <Types2Class>[
    Types2Class(title: 'عربي  ', value: 0),
    Types2Class(title: 'فانيلا  ', value: 1),
    Types2Class(title: 'فراولة  ', value: 2),
    Types2Class(title: 'اوريو  ', value: 3),
    Types2Class(title: 'شوكولاته  ', value: 4),
  ];

  //-------------------------
  List<String> areas = <String>[
    '---اختر المنطقة---',
    'حي الحسين',
    'حي الحسين الغربي',
    'حي الضباط',
    'حي الزهور',
    'حي الأمير حمزة',
    'حي الحسبان',
    'شويكة الشرقية',
    'شويكة الغربية',
    'السوق',
    'اول الضاحية',
    'نص الضاحية',
    'آخر الضاحية',
    'حي المعانية',
    'حي الفدين',
    'حي المستشفى',
    'حي نوارة',
    'حي الحياك',
    'الحي الجنوبي',
    'الإسكان العسكري',
    'شارع المهندسين',
    'إسكان الفقراء',
    'حي كلثوم',
    'حي الكويتية',
    'الحرفية',
    'الصناعية',
    'المستشفى الامريكي',
    'اول شارع المنشية',
    'حي المقام',
    'المدفعية 12',
    'القاعدة الجوية',
    'الثغرة',
    'الزعتري',
    'الباعج',
    'صبحا وصبحية',
    'الحمرا',
    'المنصورة',
    'الغدير الابيض',
    'الغدير الاخضر',
    'المطلة',
    'سما السرحان',
    'مغير السرحان',
    'جابر السرحان',
    'صوامع الدفاع المدني',
    'حوشا',
    'المنشية',
    'رحاب',
    'طيب اسم',
    'دير ورق',
    'بويضة الحوامده',
    'بويضة العليمات',
    'رباع السرحان',
    'بلعما',
    'الدجنية',
    'حمامة العليمات',
    'حمامة العموش',
    'زبيدية',
    'حيان المشرف',
  ];
  String area = '---اختر المنطقة---';

  double deliveryPrice = 1.00;

  deliveryPriceOnArea() {
    if (checkOut['area'] == "حي الحسين" ||
        checkOut['area'] == "الحي الجنوبي" ||
        checkOut['area'] == "حي الضباط" ||
        checkOut['area'] == "حي الزهور" ||
        checkOut['area'] == "حي المستشفى" ||
        checkOut['area'] == "السوق" ||
        checkOut['area'] == "حي المعانية" ||
        checkOut['area'] == "إسكان الفقراء")
      deliveryPrice = 1.00;
    else if (checkOut['area'] == "شويكة الشرقية" ||
        checkOut['area'] == "اول الضاحية" ||
        checkOut['area'] == "حي الفدين" ||
        checkOut['area'] == "حي الحسبان" ||
        checkOut['area'] == "شارع المهندسين" ||
        checkOut['area'] == "الإسكان العسكري")
      deliveryPrice = 1.25;
    else if (checkOut['area'] == "شويكة الغربية" ||
        checkOut['area'] == "نص الضاحية" ||
        checkOut['area'] == "حي المقام" ||
        checkOut['area'] == "حي الحسين الغربي" ||
        checkOut['area'] == "حي الأمير حمزة" ||
        checkOut['area'] == "حي الحياك" ||
        checkOut['area'] == "الصناعية" ||
        checkOut['area'] == "المدفعية 12" ||
        checkOut['area'] == "القاعدة الجوية" ||
        checkOut['area'] == "الحرفية" ||
        checkOut['area'] == "حي نوارة" ||
        checkOut['area'] == "صوامع الدفاع المدني" ||
        checkOut['area'] == "مستشفى سارة" ||
        checkOut['area'] == "المستشفى الامريكي" ||
        checkOut['area'] == "مستشفى النسائية" ||
        checkOut['area'] == "حي الكويتية" ||
        checkOut['area'] == "اول شارع المنشية" ||
        checkOut['area'] == "حي كلثوم")
      deliveryPrice = 1.50;
    else if (checkOut['area'] == "بير عقلة" ||
        checkOut['area'] == "آخر الضاحية" ||
        checkOut['area'] == "الغدير الاخضر" ||
        checkOut['area'] == "بويضة الحوامده")
      deliveryPrice = 2.00;
    else if (checkOut['area'] == "الثغرة" || checkOut['area'] == "طيب اسم")
      deliveryPrice = 2.50;
    else if (checkOut['area'] == "الزعتري" ||
        checkOut['area'] == "المطلة" ||
        checkOut['area'] == "المنشية")
      deliveryPrice = 3.00;
    else if (checkOut['area'] == "الباعج" || checkOut['area'] == "رحاب")
      deliveryPrice = 3.50;
    else if (checkOut['area'] == "المنصورة" ||
        checkOut['area'] == "بويضة العليمات" ||
        checkOut['area'] == "حيان المشرف" ||
        checkOut['area'] == "زبيدية")
      deliveryPrice = 4.00;
    else if (checkOut['area'] == "دير ورق" ||
        checkOut['area'] == "رباع السرحان")
      deliveryPrice = 4.50;
    else if (checkOut['area'] == "الحمرا" ||
        checkOut['area'] == "سما السرحان" ||
        checkOut['area'] == "مغير السرحان")
      deliveryPrice = 5.00;
    else if (checkOut['area'] == "حمامة العليمات")
      deliveryPrice = 5.50;
    else if (checkOut['area'] == "حوشا" ||
        checkOut['area'] == "جابر السرحان" ||
        checkOut['area'] == "حمامة العموش")
      deliveryPrice = 6.00;
    else if (checkOut['area'] == "الدجنية")
      deliveryPrice = 6.50;
    else if (checkOut['area'] == "الغدير الابيض" || checkOut['area'] == "بلعما")
      deliveryPrice = 7.00;
    else if (checkOut['area'] == "صبحا وصبحية") deliveryPrice = 9.00;
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
    if (restaurantName == 'بيتزا المفرق')
      for (int i = 0; i < pizzaTypes.length; i++) {
        if (pizzaTypes[i].value) desc += pizzaTypes[i].title + ' , ';
      }
    else if (restaurantName == 'بيتزا اونلاين')
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
    int desc = restaurantName == 'قايد حضر موت'
        ? riceTypes.indexWhere((element) => element.value == radioValue)
        : restaurantName == 'بوابة حضر موت'
            ? riceTypes1.indexWhere((element) => element.value == radioValue1)
            : cakeTypes.indexWhere((element) => element.value == radioValue2);
    int index = mealIDs.indexWhere((element) => element.id == mealID);
    myCart.add(FoodCart(
        quantity: counter,
        foodID: mealID,
        mealName: mealIDs[index].mealName,
        mealPrice: mealIDs[index].mealPrice,
        resName: mealIDs[index].resName,
        description: restaurantName == 'قايد حضر موت'
            ? riceTypes[desc].title
            : restaurantName == 'بوابة حضر موت'
                ? riceTypes1[desc].title
                : cakeTypes[desc].title));
    addPrice(double.parse(mealIDs[index].mealPrice) * counter);
    notifyListeners();
  }

  Future<void> addFoodCartRadioMilk(counter, mealName) async {
    int desc = mealName.toString().startsWith('ايس كريم')
        ? iceCreamTypes3.indexWhere((element) => element.value == radioValue17)
        : mealName.toString() == 'ميلك شيك سبيشال' ||
                mealName.toString() == 'ميلك شيك عادي'
            ? milkShakeTypes
                .indexWhere((element) => element.value == radioValue18)
            : mealName.toString().startsWith('بوظة')
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
        description: mealName.toString().startsWith('ايس كريم')
            ? iceCreamTypes3[desc].title
            : mealName.toString() == 'ميلك شيك سبيشال' ||
                    mealName.toString() == 'ميلك شيك عادي'
                ? milkShakeTypes[desc].title
                : mealName.toString().startsWith('بوظة')
                    ? iceCreamTypes[desc].title
                    : milkTypes[desc].title));
    addPrice(double.parse(mealIDs[index].mealPrice) * counter);
    notifyListeners();
  }

  Future<void> addFoodCartRadioSaloon(counter, mealName) async {
    int desc = restaurantName == 'الصالون الأخضر-شويكة' &&
            (mealName.toString() == 'بوظة مشكل 1 كيلو' ||
                mealName.toString() == 'بوظة مشكل 1/2 كيلو' ||
                mealName.toString() == 'علبة بوظة حجم صغير' ||
                mealName.toString() == 'علبة بوظة حجم كبير')
        ? iceCreamTypes2.indexWhere((element) => element.value == radioValue12)
        : mealName.toString() == 'قالب جاتو صغير' ||
                mealName.toString() == 'قالب جاتو كبير' ||
                mealName.toString() == 'قالب جاتو محشي صغير'
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
        description: restaurantName == 'الصالون الأخضر-شويكة' &&
                (mealName.toString() == 'بوظة مشكل 1 كيلو' ||
                    mealName.toString() == 'بوظة مشكل 1/2 كيلو' ||
                    mealName.toString() == 'علبة بوظة حجم صغير' ||
                    mealName.toString() == 'علبة بوظة حجم كبير')
            ? iceCreamTypes2[desc].title
            : mealName.toString() == 'قالب جاتو صغير' ||
                    mealName.toString() == 'قالب جاتو كبير' ||
                    mealName.toString() == 'قالب جاتو محشي صغير'
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
    int desc = mealName.toString().startsWith('بيتزا')
        ? pizzaTypes2.indexWhere((element) => element.value == radioValue3)
        : mealName == 'معجنات صغير'
            ? mo3ajanat1.indexWhere((element) => element.value == radioValue4)
            : mealName == 'معجنات كبير'
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
        description: mealName.toString().startsWith('بيتزا')
            ? pizzaTypes2[desc].title
            : mealName == 'معجنات صغير'
                ? mo3ajanat1[desc].title
                : mealName == 'معجنات كبير'
                    ? mo3ajanat2[desc].title
                    : mo3ajanat3[desc].title));
    addPrice(double.parse(mealIDs[index].mealPrice) * counter);
    notifyListeners();
  }

  Future<void> addFoodCartRadioMo3ajanat1(counter, mealName) async {
    int desc = mealName.toString() == 'بيتزا'
        ? pizzaTypes3.indexWhere((element) => element.value == radioValue13)
        : mo3ajanat4.indexWhere((element) => element.value == radioValue14);
    int index = mealIDs.indexWhere((element) => element.id == mealID);
    myCart.add(FoodCart(
        quantity: counter,
        foodID: mealID,
        mealName: mealIDs[index].mealName,
        mealPrice: mealIDs[index].mealPrice,
        resName: mealIDs[index].resName,
        description: mealName.toString() == 'بيتزا'
            ? pizzaTypes3[desc].title
            : mo3ajanat4[desc].title));
    addPrice(double.parse(mealIDs[index].mealPrice) * counter);
    notifyListeners();
  }

  Future<void> addFoodCartRadioLebanese(counter, mealName) async {
    int desc = mealName.toString().startsWith('سلاش')
        ? naturalSlush.indexWhere((element) => element.value == radioValue16)
        : naturalDrinks.indexWhere((element) => element.value == radioValue15);
    int index = mealIDs.indexWhere((element) => element.id == mealID);
    myCart.add(FoodCart(
        quantity: counter,
        foodID: mealID,
        mealName: mealIDs[index].mealName,
        mealPrice: mealIDs[index].mealPrice,
        resName: mealIDs[index].resName,
        description: mealName.toString().startsWith('سلاش')
            ? naturalSlush[desc].title
            : naturalDrinks[desc].title));
    addPrice(double.parse(mealIDs[index].mealPrice) * counter);
    notifyListeners();
  }

  Future<void> addFoodCartTypes(price, desc,mealName) async {
    int index = myCart.indexWhere(
        (element) => element.description == desc && element.mealPrice == price&&
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

  Future<void> removeFoodCartTypes(price, desc,mealName) async {
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
  String tabIndex = "";

  Future<void> fetchMealsShawarma(title) async {
    if (restaurantName != 'Snap Burger' && restaurantName != 'شاورما هنية')
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
    if (restaurantName == 'الدويري') {
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
    if (restaurantName == 'هون وبس') {
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
    if (restaurantName != 'شاورما هنية' &&
        restaurantName != 'الدويري' &&
        restaurantName != 'هون وبس')
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
    if (restaurantName == 'بيتزا المفرق')
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
    if (restaurantName == 'معجنات ورد') {
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
    if (restaurantName == 'ارزه لبنان')
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

  // Future<void> fetchMealsHomos(title) async {
  //   await FirebaseFirestore.instance
  //       .collection('homos/$title/meals')
  //       .get()
  //       .then((value) {
  //     value.docs.forEach((element) {
  //       bool exists = mealIDs.any((e) => e.id == element.id);
  //       if (!exists)
  //         mealIDs.add(Meals(
  //             mealName: element.data()['meal name'],
  //             mealPrice: element.data()['meal price'],
  //             description: element.data()['description'],
  //             id: element.id,
  //             resName: title));
  //     });
  //   });
  //   notifyListeners();
  // }

  Future<void> fetchMealsDrinks(title) async {
    if (restaurantName != 'الحفرة' && restaurantName != 'لبناني الشمال')
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
    else if (restaurantName == 'الحفرة') {
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
    } else if (restaurantName == 'لبناني الشمال') {
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
    if (restaurantName == 'نفيسة' || restaurantName == 'الصالون الأخضر-شويكة')
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
    if (restaurantName == 'الصالون الأخضر-شويكة') {
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
    if (restaurantName != 'الصالون الأخضر-شويكة')
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
