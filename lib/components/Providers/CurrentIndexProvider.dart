import 'package:flutter/material.dart';
import 'package:techaway/components/FavoritesPage.dart';
import 'package:techaway/components/cartPage/CartPage.dart';
import 'package:techaway/components/ordersPage/OrdersPage.dart';
import 'package:techaway/main.dart';

import '../settingsPage/SettingsPage.dart';

class CurrentIndexProvider with ChangeNotifier {
  int _currentIndex = 0;
  List<Widget> _screens = [
    HomePage(),
    MyOrders(),
    MyCartPage(),
    FavoritesPage(),
    SettingsPage()
  ];

  int get currentIndex => _currentIndex;

  set currentIndex(int value) {
    _currentIndex = value;
  }

  List<Widget> get screens=>_screens;

  void setCurrentIndex(int index){
    _currentIndex=index;
  }
}