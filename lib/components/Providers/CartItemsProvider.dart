import 'package:flutter/material.dart';
import 'package:techaway/components/FoodData.dart';
import 'package:techaway/components/cartPage/CartData.dart';

class CartItemProvider with ChangeNotifier {
  List<CartData> cartData=[];

  void addCartData(FoodData data){
    cartData.add(CartData(foodData: data));
    print(data);
    notifyListeners();
  }

  double get grandTotal {
    double total = 0;
    for (var item in cartData) {
      total += item.foodData.price * item.qty;
    }
    return total;
  }

  void removeCartData(FoodData data){
    cartData.removeWhere((element) => element.foodData.id==data.id);
    notifyListeners();
  }

  void removeAll(){
    cartData.clear();
    notifyListeners();
  }
  void removeById(String id){
    if(cartData.isNotEmpty){
      cartData.removeWhere((element) => element.foodData.id==id);
      notifyListeners();
    }
  }

  bool isInCart(FoodData data){
    try{
      CartData value=cartData.firstWhere((element) => element.foodData.id==data.id);
      return true;

    }catch(e){
      return false;
    }
  }


  void increment(FoodData data){
    cartData.firstWhere((element) => element.foodData.id==data.id).increment();
    notifyListeners();
  }

  void decrement(FoodData data){
    CartData cartdata=cartData.firstWhere((element) => element.foodData.id==data.id);
    if(cartdata.qty==1){
      removeCartData(data);
    }
    else{
      cartdata.decrement();
      notifyListeners();
    }

  }
}
