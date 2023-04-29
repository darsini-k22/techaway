import 'package:flutter/material.dart';
import 'package:techaway/components/FoodData.dart';

class CartItemProvider with ChangeNotifier {
  List<FoodData> _foodData=[];

  void setFoodData(FoodData data){
    // _added=true;
    // print(data.foodName);
   _foodData.add(data);
   // print(_foodData.last.foodName);
   notifyListeners();
  }
  void incrementQty(String itemName) {
    final foodData = _foodData.firstWhere((data) => data.foodName == itemName);
    if (foodData.qty != null && foodData != null) {
      foodData.qty = foodData.qty! + 1;
    }
    notifyListeners();
  }


  void setAdded(bool added,String itemName){
    print(itemName);
    _foodData.firstWhere((data) => data.foodName == itemName).added=added;
  }

  bool getAdded(String itemName){
    print(itemName);
    return _foodData.firstWhere((data) => data.foodName == itemName).added;
  }

  int? getQty(String itemName){
    return _foodData.firstWhere((data) => data.foodName == itemName).qty;
  }


    void decrementQty(String itemName) {
      final foodData = _foodData.firstWhere((data) =>
      data.foodName == itemName);
      if (foodData.qty != null && foodData.qty! >0 && foodData != null) {

        foodData.qty = foodData.qty! - 1;
      }
      notifyListeners();
    }


    List<FoodData> getFoodData() => _foodData;

    void removeItem(FoodData data) {
      // _added=false;
      // print(data.foodName);
      _foodData.removeWhere((item) => item.foodName == data.foodName);

      notifyListeners();
    }
  }