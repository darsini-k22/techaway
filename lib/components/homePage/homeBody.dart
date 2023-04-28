import 'dart:async';
import 'dart:ffi';

import 'package:firebase_database/firebase_database.dart';
import 'package:techaway/components/FoodData.dart';
import 'package:flutter/material.dart';
import 'package:techaway/components/homePage/foodDisplayContainer.dart';
import 'package:techaway/components/homePage/searchBar.dart';

class homeBody extends StatefulWidget {
  const homeBody({Key? key}) : super(key: key);

  @override
  State<homeBody> createState() => _homeBodyState();
}

class _homeBodyState extends State<homeBody> {
  final ref = FirebaseDatabase.instance.reference();
  List<FoodData> foodData = [];

  void getData(){
    ref.once().then((DataSnapshot snapshot) {
      print('Data : ${snapshot.value}');
    } as FutureOr Function(DatabaseEvent value));
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   DatabaseReference foodDataRef= FirebaseDatabase.instance.reference().child('food');
  //   foodDataRef.once().then((DataSnapshot? snapshot) {
  //     foodData.clear();
  //     var keys = snapshot?.key;
  //     var values = snapshot?.value;
  //
  //     if (keys != null && values != null) {
  //       for (var key in keys) {
  //         FoodData data = new FoodData(values[key]['foodName'], values[key]['stockLeft'], values[key]['price']);
  //         foodData.add(data);
  //       }
  //
  //     }
  //
  //   } as FutureOr Function(DatabaseEvent value));
  // }
  @override
  Widget build(BuildContext context) {
    final foodref = ref.child('food');
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(children: [
              const SearchBar(),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Best Sellers")),
              ),
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(children: [
                    // FoodDisplayContainer(
                    //   path: "assets/images/sandwitch.png",
                    //   foodName: _foodName[0] ?? "",
                    //   price: _price,
                    //   stocksLeft: _stockLeft,
                    // ),
                  ])),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Try These Out")),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            getData();
                          },
                          child: Text('click'))
                      // FoodDisplayContainer(
                      //   path: "assets/images/sandwitch.png",
                      //   foodName: _foodName,
                      //   price: _price,
                      //   stocksLeft: _stockLeft,
                      // ),
                    ],
                  ),
                  Row(
                    children: [
                      // FoodDisplayContainer(
                      //   path: "assets/images/sandwitch.png",
                      //   foodName: _foodName,
                      //   price: _price,
                      //   stocksLeft: _stockLeft,
                      // ),
                    ],
                  ),
                  // Row(
                  //   children:[
                  //     FoodDisplayContainer(
                  //       path: "assets/images/sandwitch.png",
                  //       foodName: _foodName,
                  //       price: _price,
                  //       stocksLeft: _stockLeft,
                  //     ),
                  //   ],
                  // ),
                ],
              )
            ]),
          ));
    });
  }
}
