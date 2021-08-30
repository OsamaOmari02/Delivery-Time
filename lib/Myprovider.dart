import 'package:app/Myfavourites_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

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
  final String mealName;
  final String mealPrice;
  final String description;
  final String resName;

  Meals({ required this.resName,
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

  FoodCart(
      {required this.resName,
      required this.mealName,
      required this.mealPrice,
      required this.quantity,
      required this.foodID});
}

//-----------------------------------------------------------
class MyProvider with ChangeNotifier {
  bool isDark = false;

  getDarkMode() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      isDark = value.data()!['darkMode'] ? true : false;
      notifyListeners();
    });

    notifyListeners();
  }

  void setDarkMode(bool val) async {
    isDark = val;
    notifyListeners();
  }

  // void setDarkMode(bool val) async{
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   pref.setBool('darkMode', val);
  //   isDark = val;
  //   notifyListeners();
  // }
  // void getDarkMode() async{
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   isDark = pref.getBool('darkMode')!;
  //   notifyListeners();
  // }

  //----------------things---------------------
  bool isLoading = false;
  List<Meals> mealIDs = [];
  var mealID;
  var restaurantName;
  List imageFun = [
    'file/burger.jpg',
    'file/حمص.jpg',
    'file/حلويات.png',
  ];

  List<String> areas = <String>[
    'اختر المنطقة',
    'حي المستشفى',
    'حي الزهور',
    'حي الحسين',
    'الضاحيه',
    'حي الحياك',
  ];
  String area = 'اختر المنطقة';
  List<String> streets = <String>[
    '-',
    'شارع احمد',
    'شارع الزهور',
    'شارع الحسين',
    'الضاحيه شارع',
    'شارع الحياك',
  ];
  String street = '-';

  Map<String, String> checkOut = {
    'area': '',
    'street': '',
    'phoneNum': '',
  };

  double deliveryPrice = 1.00;

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
      notifyListeners();
    });
  }

  var iD;

  delete() async {
    isLoading = true;
    var user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('/address/${user!.uid}/addresses')
        .doc(iD)
        .delete();
    final addressIndex = loc.indexWhere((element) => element.id == iD);
    loc.removeAt(addressIndex);
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
      });
      myFavorites.add(Favorites(myFavoriteID: mealID));
    } else {
      await FirebaseFirestore.instance
          .collection('favorites/${user!.uid}/myFavorites')
          .doc(mealID)
          .delete();
      myFavorites.removeAt(exists);
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

  double total = 0.00;

  addPrice(price) {
    total += price;
    notifyListeners();
  }

  subtractPrice(price) {
    if (total != 0) total -= price;
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
              resName: restaurantName));
      });
    });
    notifyListeners();
  }

  Future<void> addFoodCart(String mealName, String price) async {
    bool exists = myCart.any((element) => element.foodID == mealID);
    if (!exists)
      myCart.add(FoodCart(
          quantity: 1,
          foodID: mealID,
          mealName: mealName,
          mealPrice: price,
          resName: restaurantName));
    else {
      int index = myCart.indexWhere((element) => element.foodID == mealID);
      myCart[index].quantity++;
    }
    for (int i = 0; i < myCart.length; i++)
      print("myCart foodID = ${myCart[i].foodID}\n"
          "meal name = ${myCart[i].mealName}\n"
          "quantity = ${myCart[i].quantity}\n"
          "restaurnat's name = ${myCart[i].resName}");
    notifyListeners();
  }

  Future<void> removeFoodCart() async {
    int index = myCart.indexWhere((element) => element.foodID == mealID);
    if (myCart[index].quantity == 1)
      myCart.removeAt(index);
    else
      myCart[index].quantity--;
    for (int i = 0; i < myCart.length; i++)
      print("myCart foodID = ${myCart[i].foodID}\n"
          "meal name = ${myCart[i].mealName}\n"
          "quantity = ${myCart[i].quantity}\n"
          "restaurnat's name = ${myCart[i].resName}");
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
    await FirebaseFirestore.instance
        .collection('shawarma/$title/shawarma')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        bool exists = mealIDs.any((e) => e.id == element.id);
        if (!exists)
          mealIDs.add(Meals(
              mealName: element.data()['meal name'],
              mealPrice: element.data()['meal price'],
              description: element.data()['description'],
              id: element.id, resName: title));
      });
    });
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
              id: element.id, resName: ''));
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
              id: element.id, resName: title));
      });
    });
    notifyListeners();
  }

  Future<void> fetchMealsHomos(title) async {
    await FirebaseFirestore.instance
        .collection('homos/$title/meals')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        bool exists = mealIDs.any((e) => e.id == element.id);
        if (!exists)
          mealIDs.add(Meals(
              mealName: element.data()['meal name'],
              mealPrice: element.data()['meal price'],
              description: element.data()['description'],
              id: element.id, resName: ''));
      });
    });
    notifyListeners();
  }

  Future<void> fetchMealsSweets(title) async {
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
              id: element.id, resName: title));
      });
    });
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
              id: element.id, resName: title));
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
              id: element.id, resName: title));
      });
    });
    notifyListeners();
  }

  Future<void> addMeal(
      String mealName, String price, String desc, type, tab) async {
    isLoading = true;
    var uuid = Uuid().v4();
    await FirebaseFirestore.instance
        .collection('$type/$restaurantName/$tab')
        .doc(uuid)
        .set({
      'meal name': mealName,
      'meal price': price,
      'description': desc,
    }).then((value) {
      mealIDs.add(Meals(
          id: uuid, mealPrice: price, mealName: mealName, description: desc, resName: restaurantName));
    });
    notifyListeners();
  }

  deleteMeal(type, tab) async {
    isLoading = true;
    final mealIndex = mealIDs.indexWhere((element) => element.id == mealID);
    await FirebaseFirestore.instance
        .collection('$type/$restaurantName/$tab')
        .doc(mealID)
        .delete();
    mealIDs.removeAt(mealIndex);
    notifyListeners();
  }

  editMeal(String mealName, price, String desc, type, tab) async {
    isLoading = true;
    final mealIndex = mealIDs.indexWhere((element) => element.id == mealID);
    mealIDs.removeAt(mealIndex);
    await FirebaseFirestore.instance
        .collection('$type/$restaurantName/$tab')
        .doc(mealID)
        .update({
      'meal name': mealName,
      'meal price': price,
      'description': desc,
    }).then((value) {
      mealIDs.add(Meals(
          mealName: mealName, mealPrice: price, id: mealID, description: desc, resName: restaurantName));
    });
    notifyListeners();
  }

  //------------------------auth----------------------
  authStatus authState = authStatus.Authenticated;
  Map<String, String> authData = {
    'email': '',
    'password': '',
    'phone': '',
    'name': '',
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
        authData['phone'] = val.data()?['phone'];
        authData['password'] = val.data()?['password'];
        authData['name'] = val.data()?['username'];
        notifyListeners();
      });
  }

//  ---------------------------location------------------------------------------

  double lat = 0;
  double long = 0;

  sendLocationToDB() async {
    isLoading = true;
    var user = FirebaseAuth.instance.currentUser;

    var serviceEnabled = await Location().serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await Location().requestService();
      if (!serviceEnabled) return;
    }

    var permission = await Location().hasPermission();
    if (permission == PermissionStatus.denied) {
      permission = await Location().requestPermission();
      if (permission != PermissionStatus.granted) return;
    }
    var location = await Location().getLocation();
    await FirebaseFirestore.instance.collection('users').doc(user!.uid).update({
      'latitude': location.latitude,
      'longitude': location.longitude,
    });
    isLoading = false;
    notifyListeners();
  }

  goToMaps(double long, double lat) async {
    String url = "https://www.google.com/maps/search/?api=1&query=$lat,$long";
    final String encodeUrl = Uri.encodeFull(url);
    // if (!await canLaunch(encodeUrl))
    await launch(encodeUrl);
    // else
    //   {
    //     print('could not launch url');
    //     throw 'could not launch url';
    //   }
  }
}
