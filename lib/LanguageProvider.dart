

import 'package:flutter/cupertino.dart';

class LanProvider with ChangeNotifier{
  bool isEn = true;

  Map<String,Object> arabic ={
    'Home':'الصفحة الرئيسية',
    'order ur food..':'اطلب اكلك واستمتع !',
    'choose ur..':'اختر مطعمك المفضل !',
    'welcome!':'مرحبا !',
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
    'tap two times':'اضغط مرتين',
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
    'phone number':'رقم الهاتف (مطلوب)',
    'add':'اضافه',
    'orders history':'طلباتي',
    'language':'اللغة',
    'dark mode':'الوضع الليلي',
    'call us':'إاتصل بنا',
    'rate app':'قيم التطبيق',
    'tab1':'شاورما',
    'tab2':'سناكات',
    'tab3':'غير ذلك',
    'food cart':'عربة الطعام',
    'total':'المجموع',
    'price':'السعر',
    'log out?':'هل تريد تسجيل الخروج؟',
    'clear everything?':'احذف كل شيء؟',
    'yes?':'نعم',
    'cancel?':'الغاء',
    'delete this address?':'هل تريد حذف هذا العنوان؟',
    'required':'مطلوب',
    'ur password isnt correct':'كلمة المرور غير صحيحه !',
    'empty field':'حقل فارغ !',
    'pass must be 6':'كلمة المرور يجب ان تكون على الاقل 6 حروف !',
    'passwords dont match':'كلمات المرور لا يتطابقان !',
  };
  Map<String,Object> english ={

  };

  changeLan(bool lan){
    isEn = lan;
    notifyListeners();
  }
  texts(String txt){
    if (isEn) return english[txt];
    return arabic[txt];
  }
}