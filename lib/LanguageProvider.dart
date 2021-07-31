

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LanProvider with ChangeNotifier{
  bool isEn = true;

  Map<String,Object> arabic ={
    'order ur food..':'اطلب اكلك واستمتع !',
    'choose ur..':'اختر مطعمك المفضل !',
    'ok':"إغلاق",
    'welcome':'مرحبا',
    'Drawer1':'الصفحة الرئيسية',
    'Drawer2':'حسابي',
    'Drawer3':'المفضلة',
    'Drawer4':'عناوين التوصيل',
    'Drawer5':'طلباتي',
    'Drawer6':'الإعدادات',
    'Drawer7':'تسجيل الخروج',
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
    'new address':'عنوان جديد',
    'area':'المنطقه (مطلوب)',
    'street':'الشارع (مطلوب)',
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
    'clear everything?':'احذف كل شيء؟',
    'yes?':'نعم',
    'cancel?':'الغاء',
    'delete this address?':'هل تريد حذف هذا العنوان؟',
    'ur password isnt correct':'كلمة المرور غير صحيحه !',
    'empty field':'حقل فارغ !',
    'pass must be 6':'كلمة المرور يجب ان تكون على الاقل 6 حروف !',
    'passwords dont match':'كلمات المرور لا يتطابقان !',
    'delete this meal?':'هل تريد حذف هذه الوجبه ؟',
    'edit meal':'تغيير الوجبة',
    'meal name':'اسم الوجبة',
    'meal price':'سعر الوجبة',
    'add meal':'اضافة وجبة جديدة',
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
    'Drawer7':'Log out',
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
    'new address':'New Address',
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
    'passwords dont match':'The passwords do not match !',
    'delete this meal?':'Are you sure you want to delete this meal ?',
    'edit meal':'Edit Meal',
    'meal name':'Meal Name',
    'meal price':'Meal Price',
    'add meal':'Add Meal',
  };

  void changeLan(bool lan){
    isEn = lan;
    notifyListeners();
  }
  texts(String txt){
    if (isEn) return english[txt];
    return arabic[txt];
  }
}