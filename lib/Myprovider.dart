
import 'package:app/Myfavourites_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';


enum authStatus {Authenticating,unAuthenticated,Authenticated}

class Address {
  final String id;
  Address({required this.id,});
}

class Meals{
  final String id;
  final String mealName;
  final String mealPrice;

  Meals({required this.mealName,required this.mealPrice, required this.id});
}
class Favorites{
  final myFavoriteID;

  Favorites({required this.myFavoriteID});
}
//-----------------------------------------------------------
class MyProvider with ChangeNotifier {
  bool isDark = false;
  void darkMode(bool val) {
    isDark = val;
    notifyListeners();
  }
  bool isLoading = false;
  List<Meals> mealIDs = [];
  var mealID;
  // ---------------addresses----------------------
  List<Address> loc = [];

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
      loc.add(Address(id: value.id));
      notifyListeners();
    });
  }
  var iD;
  delete() async {
    isLoading = true;
    var user = FirebaseAuth.instance.currentUser;
    final addressIndex = loc.indexWhere((element) => element.id == iD);
    loc.removeAt(addressIndex);
    await FirebaseFirestore.instance.collection('/address/${user!.uid}/addresses')
        .doc(iD).delete();
    notifyListeners();
  }
    // --------------------------res-----------------------
    List imageFun = [
      'file/burger.jpg',
      'file/fahita.jpg',
      'file/shawarmah.jpg',
    ];
    var t = 0.0;
    addPrice(int price) {
      t += price;
      notifyListeners();
    }
    subtractPrice(int price) {
      if (t != 0)
        t -= price;
      notifyListeners();
    }
    List<Favorites> myFavorites = [];
  Future<void> fetchFav() async {
    var user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('favorites/${user!.uid}/myFavorites').get().then((value){
      value.docs.forEach((element) {
        mealIDs.add(Meals(mealName: element.data()['meal name'],
            mealPrice: element.data()['meal price'], id: element.id));
      });
    });
    notifyListeners();
  }

    toggleFavourite() async{
      var user = FirebaseAuth.instance.currentUser;
      final mealIndex = mealIDs.indexWhere((element) => element.id == mealID);
      final exists = myFavorites.indexWhere((element) => element.myFavoriteID == mealID);
      if (exists<0){
        await FirebaseFirestore.instance
            .collection('/favorites/${user!.uid}/myFavorites').doc(mealID).set({
          'meal':mealIDs[mealIndex].id,
          'meal name':mealIDs[mealIndex].mealName,
          'meal price':mealIDs[mealIndex].mealPrice,
        }).then((value) {
          myFavorites.add(Favorites(myFavoriteID: mealID));
        });
      } else {
        print("deleted");
         await FirebaseFirestore.instance
            .collection('favorites/${user!.uid}/myFavorites').doc(mealID).delete().then((value){
              myFavorites.removeAt(exists);
         });
      }
          for (int i=0;i<myFavorites.length;i++)
          print(myFavorites[i].myFavoriteID);
          print('===================');
          print("mealID: $mealID");
      // for (int i=0;i<mealIDs.length;i++)
      //   print(mealIDs[i].id);
      notifyListeners();
    }
    bool isMyFav(){
    return myFavorites.any((element) => element.myFavoriteID==mealID);
    }
    //-----------------------admin----------------------------

    Future<void> fetchMeals() async {
      await FirebaseFirestore.instance
          .collection('restaurants/grill house/shawarma').get().then((value){
            value.docs.forEach((element) {
              mealIDs.add(Meals(mealName: element.data()['meal name'],
                  mealPrice: element.data()['meal price'], id: element.id));
            });
      });
      await FirebaseFirestore.instance
          .collection('restaurants/grill house/snacks').get().then((value){
        value.docs.forEach((element) {
          mealIDs.add(Meals(mealName: element.data()['meal name'],
              mealPrice: element.data()['meal price'], id: element.id));
        });
      });
      await FirebaseFirestore.instance
          .collection('restaurants/grill house/others').get().then((value){
        value.docs.forEach((element) {
          mealIDs.add(Meals(mealName: element.data()['meal name'],
              mealPrice: element.data()['meal price'], id: element.id));
        });
      });
      notifyListeners();
    }
  Future<void> addMeal(String mealName, String price,type) async {
    isLoading = true;
    var uuid = Uuid().v4();
          await FirebaseFirestore.instance
              .collection('/restaurants/grill house/$type').doc(uuid).set
              ({
            'meal name':mealName,
            'meal price':price,
          }).then((value) {
            mealIDs.add(Meals(id: uuid, mealPrice: price, mealName: mealName));
          });
    notifyListeners();
  }

  deleteMeal(type) async {
    isLoading = true;
    final mealIndex = mealIDs.indexWhere((element) => element.id == mealID);
    await FirebaseFirestore.instance.collection('/restaurants/grill house/$type')
        .doc(mealID).delete();
    mealIDs.removeAt(mealIndex);
    notifyListeners();
  }

  editMeal(String mealName,price,type) async {
    isLoading = true;
    final mealIndex = mealIDs.indexWhere((element) => element.id == mealID);
    mealIDs.removeAt(mealIndex);
    await FirebaseFirestore.instance.collection('/restaurants/grill house/$type')
        .doc(mealID).update({
      'meal name':mealName,
      'meal price':price,
    }).then((value) {
      mealIDs.add(Meals(mealName: mealName, mealPrice: price, id: mealID));
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
        await FirebaseFirestore.instance.collection('users').doc(userData.uid)
            .get().then((val) {
          authData['email'] = val.data()?['email'];
          authData['phone'] = val.data()?['phone'];
          authData['password'] = val.data()?['password'];
          authData['name'] = val.data()?['username'];
          notifyListeners();
        });
    }

  //  ---------------------------------------------------------------------


  }
