class FoodData {
  String _foodName;
  String _stockLeft;
  String _price;
  int? qty;
  bool added;

  FoodData(
      {required String foodName,
        required String price,
        required String stockLeft,this.qty=1,
        this.added = false,})
      : _foodName = foodName,
        _price = price,
        _stockLeft = stockLeft;

  String get foodName => _foodName;
  set foodName(String value) => _foodName = value;

  String get stockLeft => _stockLeft;
  set stockLeft(String value) => _stockLeft = value;

  String get price => _price;
  set price(String value) => _price = value;


}
