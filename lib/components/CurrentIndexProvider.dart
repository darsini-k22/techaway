import 'package:flutter/material.dart';
import 'package:techaway/components/cartPage/CartPage.dart';
import 'package:techaway/components/ordersPage/OrdersPage.dart';
import 'package:techaway/main.dart';

import 'settingsPage/SettingsPage.dart';

class CurrentIndexProvider with ChangeNotifier {
  int _currentIndex = 0;
  List<Widget> _screens = [
    HomePage(),
    MyOrders(),
    MyCartPage(),
    SettingsPage()
  ];

  int get currentIndex => _currentIndex;
  List<Widget> get screens=>_screens;

  void setCurrentIndex(int index){
    _currentIndex=index;
  }
}