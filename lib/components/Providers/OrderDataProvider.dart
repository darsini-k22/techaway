// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:techaway/components/FoodData.dart';
// import 'package:techaway/components/cartPage/CartData.dart';
// import 'package:techaway/components/ordersPage/OrderData.dart';
//
// class OrderDataProvider with ChangeNotifier {
//   final CollectionReference ordersCollection =
//       FirebaseFirestore.instance.collection('orders');
//   final CollectionReference foodCollection =
//       FirebaseFirestore.instance.collection('food');
//
//
//   // List<OrderData> orderList = [];
//   late OrderData _orderData =
//       OrderData(data: [], grandTotal: 0, timestamp: Timestamp.now());
//   late List<FoodData> foodList=[];
//
//   Future<void> write(List<CartData> cartData,String userId) async {
//     final Map<String, dynamic> cartDataMap = {};
//     print('userId${userId}');
//
//     cartData.forEach((data) {
//       cartDataMap[data.foodData.id] = {
//         'foodName': data.foodData.foodName,
//         'price': data.foodData.price,
//         'qty': data.qty,
//       };
//     });
//     num grandTotal = 0;
//     cartData.forEach((element) {
//       grandTotal += element.qty * element.foodData.price;
//     });
//
//     Timestamp timestamp = Timestamp.now();
//
//     List<CartData> tempCartData = [];
//     cartData.forEach((element) {
//       tempCartData.add(element);
//     });
//
//     _orderData.data = tempCartData;
//     _orderData.grandTotal = grandTotal;
//     _orderData.timestamp = timestamp;
//
//     FirebaseFirestore.instance.collection('orders').doc(FirebaseAuth.instance.currentUser!.uid).set({
//       'order': cartDataMap,
//       'grandTotal': grandTotal,
//       'timestamp': timestamp
//     });
//
//
//     notifyListeners();
//   }
//
//
//   Future<List<FoodData>> getOrderListByUserId() async {
//     final snapshot = await FirebaseFirestore.instance
//         .collection('user')
//         .doc(FirebaseAuth.instance.currentUser!.uid)
//         .collection('order')
//         .get();
//     final List<FoodData> orderList = snapshot.docs
//         .map((doc) => FoodData(
//         id: doc.id,
//         foodName: doc['foodName'],
//         price: doc['price'],
//         stockLeft: doc['stockLeft']))
//         .toList();
//     orderList.forEach((element) {
//       foodList.add(element);
//     });
//     return orderList;
//   }
//
//
//
//   OrderData get orderData => _orderData;
//
//
//   set orderData(OrderData value) {
//     _orderData = value;
//   }
//
//   num grandTotal() {
//     if (orderData == null) {
//       return 0;
//     }
//     return orderData.grandTotal;
//   }
//
//   void removeOrder(){
//     if(_orderData.data.isEmpty){
//       return;
//     }
//     _orderData=OrderData(data: [], grandTotal: 0, timestamp: Timestamp.now());
//     notifyListeners();
//   }
//
//   Future<void> updateStocks(List<CartData> cartData) async {
//     cartData.forEach((data) {
//       foodCollection
//           .doc(data.foodData.id)
//           .set({
//             'foodName': data.foodData.foodName,
//             'stocksLeft': (data.foodData.stockLeft - data.qty),
//             'price': data.foodData.price,
//           })
//           .then((value) => print('Stocks updated'))
//           .catchError((error) => print('Failed to update stocks: $error'));
//     });
//     notifyListeners();
//   }
//
//
//
//
//
// }


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:techaway/components/cartPage/CartData.dart';
import 'package:techaway/components/ordersPage/OrderData.dart';

class OrderDataProvider with ChangeNotifier {
  final CollectionReference ordersCollection =
  FirebaseFirestore.instance.collection('orders');
  final CollectionReference foodCollection =
  FirebaseFirestore.instance.collection('food');


  // List<OrderData> orderList = [];
  late OrderData _orderData =
  OrderData(data: [], grandTotal: 0, timestamp: Timestamp.now());

  Future<void> write(List<CartData> cartData,String userId) async {
    final Map<String, dynamic> cartDataMap = {};
    print('userId${userId}');

    cartData.forEach((data) {
      cartDataMap[data.foodData.id] = {
        'foodName': data.foodData.foodName,
        'price': data.foodData.price,
        'qty': data.qty,
      };
    });
    num grandTotal = 0;
    cartData.forEach((element) {
      grandTotal += element.qty * element.foodData.price;
    });

    Timestamp timestamp = Timestamp.now();

    List<CartData> tempCartData = [];
    cartData.forEach((element) {
      tempCartData.add(element);
    });

    _orderData.data = tempCartData;
    _orderData.grandTotal = grandTotal;
    _orderData.timestamp = timestamp;

    FirebaseFirestore.instance.collection('orders').doc(FirebaseAuth.instance.currentUser!.uid).set({
      'order': cartDataMap,
      'grandTotal': grandTotal,
      'timestamp': timestamp
    });


    notifyListeners();
  }

  OrderData get orderData => _orderData;


  set orderData(OrderData value) {
    _orderData = value;
  }

  num grandTotal() {
    if (orderData == null) {
      return 0;
    }
    return orderData.grandTotal;
  }

  void removeOrder(){
    if(_orderData.data.isEmpty){
      return;
    }
    _orderData=OrderData(data: [], grandTotal: 0, timestamp: Timestamp.now());
    notifyListeners();
  }
  Stream<QuerySnapshot> orderStream() {
    return FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('order').snapshots();
  }

  Future<void> updateStocks(List<CartData> cartData) async {
    cartData.forEach((data) {
      foodCollection
          .doc(data.foodData.id)
          .set({
        'foodName': data.foodData.foodName,
        'stocksLeft': (data.foodData.stockLeft - data.qty),
        'price': data.foodData.price,
      })
          .then((value) => print('Stocks updated'))
          .catchError((error) => print('Failed to update stocks: $error'));
    });
    notifyListeners();
  }
}

