import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:techaway/components/FoodData.dart';

class FoodDataProvider with ChangeNotifier {
  List<FoodData> _foodDataList = [];
  List<FoodData> filteredFoodData = [];

  late CollectionReference ref;
  late QuerySnapshot querySnapshot;

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> foodStream() {
    return _db.collection('food').snapshots();
  }

  void filter(String name) {
    if (name.length > 0) {
      filteredFoodData = _foodDataList
          .where((element) => element.foodName.startsWith(name))
          .toList();
    } else {
      filteredFoodData = _foodDataList;
    }
    notifyListeners();
  }

  List<FoodData> get foodDataList => _foodDataList;

  FoodData getById(String id) {
    return _foodDataList.firstWhere((element) => element.id == id);
  }

  Future<void> fetchData() async {
    foodStream().listen((querySnapshot) {
      List<DocumentSnapshot> docs = querySnapshot.docs;
      List<FoodData> foodDataList = [];

      docs.forEach((doc) {
        String docId = doc.id;
        String foodName = doc['foodName'];
        num price =doc['price'];
        num stockLeft = doc['stocksLeft'];
        FoodData data = FoodData(id: docId, foodName: foodName, price: price, stockLeft: stockLeft);
        foodDataList.add(data);
      });

      _foodDataList = foodDataList;
      filteredFoodData = foodDataList;
      notifyListeners();
    });
  }



}
