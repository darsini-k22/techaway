
class FoodData {
  String _id;
  String _foodName;
  num _stockLeft;
  num _price;

  FoodData({
    required String id,
    required String foodName,
    required num price,
    required num stockLeft,
  })  : _id=id,_foodName = foodName,
        _price = price,
        _stockLeft = stockLeft;

  String get id=>_id;
  set id(String id)=>_id=id;

  String get foodName => _foodName;
  set foodName(String value) => _foodName = value;

  num get stockLeft => _stockLeft;
  set stockLeft(num value) => _stockLeft = value;

  num get price => _price;
  set price(num value) => _price = value;




}
