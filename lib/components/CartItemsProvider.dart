import 'package:flutter/material.dart';
import 'package:techaway/components/FoodData.dart';

class CartItemProvider with ChangeNotifier {
  List<FoodData> _foodData = [];

  void setFoodData(FoodData data) {
    // _added=true;
    // print(data.foodName);
    print('setFoodItem');
    print(data.added);
    _foodData.add(data);
    final foodData = _foodData.firstWhere((data) => data.foodName == data.foodName);
    if(foodData.added==false){
      foodData.added = true;
    }

    print('setFoodItem');
    print(data.added);
    print(_foodData);
    notifyListeners();
  }

  void incrementQty(String itemName) {
    final foodData = _foodData.firstWhere((data) => data.foodName == itemName);
    foodData.incrementQty();
    notifyListeners();
  }

  void setAdded(bool added, String itemName) {
    if (_foodData.isEmpty) {
      return; // or some other default behavior
    }
    print('setAdded:'+itemName);
    final foodData = _foodData.firstWhere((data) => data.foodName == itemName);
    if (_foodData.isEmpty) {
      foodData.added=false; // or some other default value
    }
    foodData.setAdded=added;
    notifyListeners();
  }


  bool getAdded(String itemName) {
    print('getAdded:'+itemName);
    if (_foodData.isEmpty) {
      return false; // or some other default value
    }
    final foodData = _foodData.firstWhere((data) => data.foodName == itemName);
    print(foodData.getAdded);
    return foodData.getAdded;
  }

  int? getQty(String itemName) {
    if (_foodData.isEmpty) {
      return null; // or some other default value
    }
    return _foodData.firstWhere((data) => data.foodName == itemName).qty;
  }

  void decrementQty(String itemName) {
    final foodData = _foodData.firstWhere((data) => data.foodName == itemName);
    foodData.decrementQty();
    notifyListeners();
  }

  List<FoodData> getFoodData() => _foodData;

  void removeItem(String foodName) {
    if (_foodData.isEmpty) {
      return; // or some other default behavior
    }
    print('removeItem');

    print(_foodData);
    final foodData = _foodData.firstWhere((data) => data.foodName == foodName);
    print(foodData.added);
    if(foodData.added==true){
      foodData.added = false;
      _foodData.removeWhere((item) => item.foodName == foodName);
    }
    print('removeItem');
    print(_foodData);
    notifyListeners();
  }
}
