
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


// enum AuthMode { LogIn, SignUp }
enum authStatus {Authenticating,unAuthenticated,Authenticated}

class Address {
  final String id;
  Address({
    required this.id,
  });

}

class MyProvider with ChangeNotifier {
  bool isDark = false;
  void darkMode(bool val) {
    isDark = val;
    notifyListeners();
  }
  bool isLoading = false;
  // ---------------addresses----------------------
  List<Address> loc = [];

  Future<void> add(String area, String street, String phone) async {
    var user = FirebaseAuth.instance.currentUser;
    isLoading = true;
    notifyListeners();
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

    bool isFavourite = false;
    toggleFavourite() {
      isFavourite = !isFavourite;
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


  }