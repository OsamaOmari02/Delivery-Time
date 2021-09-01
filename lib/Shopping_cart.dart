import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'LanguageProvider.dart';
import 'Myprovider.dart';

class Shopping extends StatefulWidget {
  @override
  _ShoppingState createState() => _ShoppingState();
}

class _ShoppingState extends State<Shopping> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    var lanProvider = Provider.of<LanProvider>(context);
    var user = FirebaseAuth.instance.currentUser;
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

    bottomSheet() {
      return Directionality(
        textDirection: lanProvider.isEn ? TextDirection.ltr : TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(lanProvider.texts('choose address'),
               ),
            backgroundColor: Theme.of(context).canvasColor,
            elevation: 1,
            actions: [
              IconButton(
                icon: Icon(Icons.add,color: Colors.blue,),
                onPressed: () => Navigator.of(context).pushNamed('addAddress'),
              ),
            ],
          ),
          body: ListView.builder(
            itemCount: provider.loc.length,
            itemBuilder: (BuildContext context, int index) {
              if (provider.loc.isEmpty)
                return Center(
                  child: TextButton(
                      onPressed: () =>
                          Navigator.of(context).pushNamed('addAddress'),
                      child: Text(lanProvider.texts('new address'),
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ))),
                );
              return Card(
                elevation: 0.5,
                child: ListTile(
                  onTap: () {
                    setState(() {
                      provider.checkOut['area'] = provider.loc[index].area;
                      provider.checkOut['street'] = provider.loc[index].street;
                      provider.checkOut['phoneNum'] = provider.loc[index].phoneNum;
                    });
                    Navigator.of(context).pushNamed('checkOut');
                  },
                  title: Text(provider.loc[index].area),
                  subtitle: Text(lanProvider.texts('street:') +
                      provider.loc[index].street +
                      "\n" +
                      lanProvider.texts('phone:') +
                      provider.loc[index].phoneNum),
                  isThreeLine: true,
                ),
              );
            },
          ),
        ),
      );
    }

    return Directionality(
        textDirection: lanProvider.isEn ? TextDirection.ltr : TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              lanProvider.texts('food cart'),
              style: const TextStyle(fontSize: 20),
            ),
            actions: provider.myCart.isEmpty
                ? null
                : [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext ctx) {
                              return AlertDialog(
                                title: Text(
                                  lanProvider.texts('clear everything?'),
                                  style: const TextStyle(fontSize: 23),
                                ),
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 7),
                                elevation: 24,
                                content: Container(
                                  height: 46,
                                  child: const Divider(),
                                  alignment: Alignment.topCenter,
                                ),
                                actions: [
                                  InkWell(
                                    child: Text(
                                      lanProvider.texts('yes?'),
                                      style: const TextStyle(
                                          fontSize: 19, color: Colors.red),
                                    ),
                                    onTap: () {
                                      provider.myCartClear();
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  const SizedBox(width: 11),
                                  InkWell(
                                      child: Text(lanProvider.texts('cancel?'),
                                          style: const TextStyle(fontSize: 19)),
                                      onTap: () => Navigator.of(context).pop()),
                                ],
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ),
                  ],
          ),
          body: provider.myCart.length == 0
              ? Center(
                  child: Text(
                  lanProvider.texts('empty cart'),
                  style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                ))
              : ListView.builder(
                  itemCount: provider.myCart.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 3,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const SizedBox(height: 20),
                                  Container(
                                    padding: const EdgeInsets.only(left: 10),
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      provider.myCart[index].mealName,
                                      style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w800),
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
                                            provider.myCart[index].mealPrice +
                                            " " +
                                            lanProvider.texts('jd'),
                                        style: const TextStyle(
                                            fontSize: 16, color: Colors.pink),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.remove,
                                  color: Colors.red,
                                ),
                                onPressed: () async {
                                  try {
                                    setState(() {
                                      provider.mealID =
                                          provider.myCart[index].foodID;
                                    });
                                    provider.subtractPrice(double.parse(
                                        provider.myCart[index].mealPrice));
                                    provider.removeFoodCart();
                                  } catch (e) {
                                    dialog(
                                        lanProvider.texts('Error occurred !'));
                                    print(e);
                                  }
                                },
                              ),
                              Text(provider.myCart[index].quantity.toString()),
                              IconButton(
                                icon: const Icon(
                                  Icons.add,
                                  color: Colors.green,
                                ),
                                onPressed: () async {
                                  try {
                                    setState(() {
                                      provider.mealID =
                                          provider.myCart[index].foodID;
                                    });
                                    provider.addFoodCart(
                                        provider.myCart[index].mealName,
                                        provider.myCart[index].mealPrice);
                                    provider.addPrice(double.parse(
                                        provider.myCart[index].mealPrice));
                                  } catch (e) {
                                    dialog(
                                        lanProvider.texts('Error occurred !'));
                                    print(e);
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
          bottomNavigationBar: Container(
            height: 100,
            child: Column(children: [
              if (provider.myCart.isNotEmpty) Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(lanProvider.texts('cart total :'),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  Text(provider.total.toString() + " ",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      )),
                  Text(lanProvider.texts('jd'),
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
                   if (provider.myCart.isNotEmpty)
                       provider.isLoading?
                         Center(child: CircularProgressIndicator(),)
                         :
                         TextButton(
                             onPressed: () async {
                               if (provider.long == 0 && provider.lat == 0) {
                                 try {
                                   setState(() {
                                     provider.isLoading = true;
                                   });
                                   await provider.sendLocationToDB();
                                   setState(() {
                                     provider.isLoading = false;
                                   });
                                   Fluttertoast.showToast(
                                       msg: lanProvider.texts('location'),
                                       toastLength: Toast.LENGTH_SHORT,
                                       backgroundColor: Colors.grey,
                                       textColor: Colors.white,
                                       fontSize: 16.0);
                                   print('done');
                                 } catch (e) {
                                   setState(() {
                                     provider.isLoading = false;
                                   });
                                   Fluttertoast.showToast(
                                       msg: lanProvider.texts('Error occurred !'),
                                       toastLength: Toast.LENGTH_SHORT,
                                       backgroundColor: Colors.red,
                                       textColor: Colors.white,
                                       fontSize: 16.0);
                                   print(e);
                                 }
                               }
                               showModalBottomSheet(
                                   context: context, builder: (_) => bottomSheet());
                             },
                             child: Text(lanProvider.texts('Next'),
                                 style: TextStyle(
                                   fontSize: 17,
                                   fontWeight: FontWeight.bold,
                                 ))),

            ]),
          ),
        ));
  }
}

//StreamBuilder<QuerySnapshot>(
//           stream: FirebaseFirestore.instance
//               .collection('orders/${user!.uid}/myOrders')
//               .snapshots(),
//           builder: (ctx, snapshot) {
//             if (snapshot.connectionState==ConnectionState.waiting)
//                Center(child: const CircularProgressIndicator());
//             if (!snapshot.hasData)
//               return Center(child: Text("Food cart is empty!"));
//             return Scrollbar(
//               child: ListView.builder(
//                 itemCount: snapshot.data!.docs.length,
//                 itemBuilder: (context, int index) {
//                   var resData = snapshot.data!.docs;
//                   return Card(
//                     child: Row(
//                       children: <Widget>[
//                         const SizedBox(width: 15),
//                         Expanded(
//                           flex: 2,
//                           child: Container(
//                             child:
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: <Widget>[
//                                     const SizedBox(height: 20),
//                                     Container(
//                                       padding: const EdgeInsets.only(left: 10),
//                                       alignment: Alignment.topLeft,
//                                       child: Text(
//                                         resData[index]['meal name'],
//                                         style: const TextStyle(
//                                             fontSize: 17,
//                                             fontWeight: FontWeight.w800),
//                                       ),
//                                     ),
//                                     Container(
//                                       padding: const EdgeInsets.only(left: 10),
//                                       alignment: Alignment.bottomLeft,
//                                       margin: const EdgeInsets.only(top: 17),
//                                       child: Padding(
//                                         padding: const EdgeInsets.symmetric(
//                                             vertical: 7),
//                                         child: Text(
//                                           lanProvider.texts('price') +
//                                               " " +
//                                               resData[index]['meal price'] +
//                                               " " +
//                                               lanProvider.texts('jd'),
//                                           style: const TextStyle(
//                                               fontSize: 16, color: Colors.pink),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                             ),
//                           ),
//                         ),
//                         Row(
//                           children: [
//                             _itemCount != 0
//                                 ? IconButton(
//                                     icon: const Icon(
//                                       Icons.remove,
//                                       color: Colors.red,
//                                     ),
//                                     onPressed: () async{
//                                       try{
//                                         setState(() {
//                                           provider.mealID = resData[index].id;
//                                           _itemCount--;
//                                         });
//                                         provider.subtractPrice(int.parse(
//                                             resData[index]['meal price']));
//                                         provider.addFoodCart(resData[index]['meal name'],
//                                             resData[index]['meal price']);
//                                       } on FirebaseException catch (e){
//                                         dialog(e.message);
//                                         setState(() {
//                                           provider.isLoading=false;
//                                           _itemCount++;
//                                         });
//                                         print(e);
//                                       } catch (e){
//                                         dialog(lanProvider.texts('Error occurred !'));
//                                         setState(() {
//                                           provider.isLoading=false;
//                                           _itemCount++;
//                                         });
//                                         print(e);
//                                       }
//                                     },
//                                   )
//                                 : Container(),
//                             Text(_itemCount.toString()),
//                             IconButton(
//                                 icon: const Icon(
//                                   Icons.add,
//                                   color: Colors.green,
//                                 ),
//                                 onPressed: () async{
//                                   try{
//                                     setState(() {
//                                       provider.mealID = resData[index].id;
//                                       _itemCount++;
//                                     });
//                                     provider.addPrice(int.parse(
//                                         resData[index]['meal price']));
//                                     provider.addFoodCart(resData[index]['meal name'],
//                                         resData[index]['meal price']);
//                                   } on FirebaseException catch (e){
//                                     dialog(e.message);
//                                     setState(() {
//                                       provider.isLoading=false;
//                                       _itemCount--;
//                                     });
//                                     print(e);
//                                   } catch (e){
//                                     dialog(lanProvider.texts('Error occurred !'));
//                                     setState(() {
//                                       provider.isLoading=false;
//                                       _itemCount--;
//                                     });
//                                     print(e);
//                                   }
//                                 },
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             );
//           },
//         ),
//       ),
