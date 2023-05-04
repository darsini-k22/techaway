import 'package:techaway/components/FoodData.dart';

class CartData{
  FoodData _foodData;
  int _qty;

  CartData({
    required FoodData foodData,
    int qty=1,
  })  : _foodData=foodData,_qty=qty;

  FoodData get foodData=>_foodData;
  set id(FoodData foodData)=>_foodData=foodData;

  int get qty => _qty;

  void increment(){
    if(_foodData.stockLeft>=_qty) {
      _qty++;
    }

  }



  void decrement(){
    if(_qty!=0){
      _qty--;
    }
  }

}
