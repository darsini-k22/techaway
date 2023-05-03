import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techaway/components/cartPage/CartData.dart';

class OrderData{
  List<CartData> _data;
  num _grandTotal;
  Timestamp _timestamp;

  OrderData({
    required List<CartData> data,
    required num grandTotal,
    required Timestamp timestamp,
  })  : _data=data,_grandTotal = grandTotal,
        _timestamp = timestamp;

  Timestamp get timestamp => _timestamp;

  set timestamp(Timestamp value) {
    _timestamp = value;
  }

  num get grandTotal => _grandTotal;

  set grandTotal(num value) {
    _grandTotal = value;
  }

  List<CartData> get data => _data;

  set data(List<CartData> value) {
    _data = value;
  }
}