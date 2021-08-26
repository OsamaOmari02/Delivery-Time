

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanProvider with ChangeNotifier{

  bool isEn = true;


  Map<String,Object> arabic ={
    'order ur food..':'اطلب اكلك واستمتع !',
    'choose ur..':'اختر مطعمك المفضل !',
    'ok':"حسنا",
    'welcome':'مرحبا',
    'Drawer1':'الصفحة الرئيسية',
    'Drawer2':'حسابي',
    'Drawer3':'المفضلة',
    'Drawer4':'عناوين التوصيل',
    'Drawer5':'طلباتي',
    'Drawer6':'الإعدادات',
    'Drawer7':'حول التطبيق',
    'Drawer8':'تسجيل الخروج',
    'my account':'حسابي',
    'my email':'البريد الالكتروني',
    'my name':'اسمي',
    'my password':'تغيير كلمة المرور',
    'change email':'تغيير البريد الالكتروني',
    'save&exit':'احفظ واخرج',
    'pass':'كلمة المرور',
    'email':'البريد الالكتروني',
    'change name':'تغيير الاسم',
    'name':'اسمي',
    'current pass':'كلمة المرور الحالية',
    'new pass':'كلمة المرور الجديدة',
    'confirm pass':'تأكيد كلمة المرور',
    'my favorites':'المفضلة',
    'my addresses':'عناوين التوصيل',
    'new address':'اضف عنوان جديد',
    'area':'المنطقه (مطلوب)',
    'street':'الشارع',
    'street:':'الشارع: ',
    'phone number':'رقم الهاتف (مطلوب)',
    'phone:':'رقم الهاتف: ',
    'add':'اضافه',
    'save':'احفظ',
    'orders history':'طلباتي',
    'language':'اللغة',
    'dark mode':'الوضع الليلي',
    'call us':'إتصل بنا',
    'rate app':'قيم التطبيق',
    'required':'مطلوب',
    'tab1':'شاورما',
    'tab2':'سناكات',
    'tab3':'غير ذلك',
    'food cart':'سله الطعام',
    'total':'المجموع',
    'jd':'د.أ',
    'price':'السعر:',
    'log out?':'هل تريد تسجيل الخروج؟',
    'clear everything?':'احذف كل شيء ؟',
    'yes?':'نعم',
    'cancel?':'الغاء',
    'delete this address?':'هل تريد حذف هذا العنوان ؟',
    'ur password isnt correct':'! كلمة المرور غير صحيحه',
    'empty field':'! حقل فارغ ',
    'pass must be 6':'كلمة المرور يجب ان تكون على الاقل 6 حروف ',
    'passwords dont match':'كلمات المرور لا يتطابقان ',
    'new pass must be':' كلمة السر الجديدة يجب ان تكون مختلفة عن كلمة السر القديمة',
    'delete this meal?':'هل تريد حذف هذه الوجبة؟',
    'edit meal':'تغيير الوجبة',
    'meal name':'اسم الوجبة',
    'meal price':'سعر الوجبة',
    'add meal':'اضافة وجبة جديدة',
    'add text':'اضافة الى',
    'about':'حول التطبيق',
    'hello':'مرحبا, شكراً لإستخدامكم تطبيقنا.',
    'If you face':'اذا واجهتم مشاكل خلال استخدامكم التطبيق الرجاء التواصل معنا',
    'Error occurred !':'! حدث خطأ',
    'something went wrong !':'! حدث خطأ',
    'no meals were added to favorites':'لا يوجد وجبات مفضلة',
    'desc':'الوصف',
    'Pass Updated':'تم تحديث كلمة السر بنجاح',
    'Email Updated Successfully':'تم تحديث بريدك الالكتروني بنجاح',
    'Name Updated Successfully':'تم تحديث اسمك بنجاح',
    'badly formatted':'! بريد الكتروني خاطئ',
    'new email must diff':'بريدك الجديد يجب ان يكون مختلف عن بريدك الحالي',
    'new name must diff':'اسمك الجديد يجب ان يكون مختلف عن اسمك الحالي',
    "Address Deleted":'تم حذف العنوان',
    'Address Added':'تم اضافة عنوان جديد',
    'delete':'احذف',
    'Meal Added':'تم اضافة الوجبة',
    'Meal Deleted':'تم حذف الوجبة',
    'location':'لقد حصلنا على موقعك بنجاح',
    'Choose your area':'يجب اختيار المنطقة',
    'invalid':'غير صالح',
  };
  Map<String,Object> english ={
    'order ur food..':'Order your food now and enjoy !',
    'choose ur..':'Choose your favorite restaurant !',
    'welcome':'Welcome',
    'ok':"OK",
    'Drawer1':'Home',
    'Drawer2':'Account',
    'Drawer3':'Favorites',
    'Drawer4':'Addresses',
    'Drawer5':'History',
    'Drawer6':'Settings',
    'Drawer7':'About',
    'Drawer8':'Log out',
    'my account':'My Account',
    'my email':'My Email',
    'my name':'My Name',
    'my password':'My Password',
    'change email':'Change Email',
    'save&exit':'Save & exit',
    'pass':'Password',
    'email':'E-mail',
    'change name':'Change Name',
    'name':'Name',
    'current pass':'Current Password',
    'new pass':'New password',
    'confirm pass':'Confirm Password',
    'my favorites':'My Favorites',
    'my addresses':'My Addresses',
    'new address':'Add A New Address',
    'required':'Required',
    'area':'Area (required)',
    'street':'Street (required)',
    'street:':'street: ',
    'phone number':'Phone Number (required)',
    'phone:':'Mobile: ',
    'add':'Add',
    'save':'Save',
    'orders history':'Orders History',
    'language':'Language',
    'dark mode':'Dark Mode',
    'call us':'Call Us',
    'rate app':'Rate This Application',
    'tab1':'Shawarma',
    'tab2':'Snacks',
    'tab3':'Others',
    'food cart':'Food Cart',
    'total':'Total',
    'jd':'JD',
    'price':'Price:',
    'log out?':'Are you sure you want to log out ?',
    'clear everything?':'Clear everything ?',
    'yes?':'Yes',
    'cancel?':'Cancel',
    'delete this address?':'Are you sure you want to delete this address ?',
    'ur password isnt correct':'Your password is not correct !',
    'empty field':'Empty field !',
    'pass must be 6':'Password must be at least 6 characters !',
    'new pass must be':'New password must be different than old password',
    'passwords dont match':'The passwords do not match !',
    'delete this meal?':'Are you sure you want to delete this meal ?',
    'edit meal':'Edit Meal',
    'meal name':'Meal Name',
    'meal price':'Meal Price',
    'add meal':'Add Meal',
    'add text':'Add To',
    'about':'About The Application',
    'hello':'Hello, thanks for using our app.',
    'If you face':'If you face any problem let us know please and thank you !',
    'Error occurred !':'Error occurred !',
    'something went wrong !':'something went wrong !',
    'no meals were added to favorites':'no meals were added to favorites',
    'desc':'Description',
    'Pass Updated':'Password Updated Successfully',
    'Email Updated Successfully':'Email Updated Successfully',
    'Name Updated Successfully':'Name Updated Successfully',
    'badly formatted':'The email address is badly formatted.',
    'new email must diff':'Your new email must be different than your current email',
    'new name must diff':'Your new name must be different than your current name',
    "Address Deleted":'Address Deleted',
    'Address Added':'Address Added',
    'delete':'Delete',
    'Meal Added':'Meal Added',
    'Meal Deleted':'Meal Deleted',
    'location':'We have got your location successfully',
    'Choose your area':'Choose your area',
    'invalid':'invalid',
  };

  texts(String txt){
    if (isEn) return english[txt];
    return arabic[txt];
  }
  void getLanguage() async{
    await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get().then((value) {
      isEn =  value.data()!['Language']?true:false;
    });
    notifyListeners();

  }
  void setLanguage(bool val){
    isEn = val;
    notifyListeners();
    print(FirebaseAuth.instance.currentUser!.uid);
  }
  // void setDarkMode(bool lan) async{
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   pref.setBool('language', lan);
  //   isEn = lan;
  //   notifyListeners();
  // }
  // void getLanguage() async{
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   isEn = pref.getBool('language')!;
  //   notifyListeners();
  // }
}