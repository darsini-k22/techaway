import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techaway/components/FoodData.dart';
import 'package:techaway/components/Providers/FoodIDataProvider.dart';
import 'package:techaway/components/homePage/foodDisplayContainer.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({
    super.key,
  });

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    final foodDataProvider = Provider.of<FoodDataProvider>(context);
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final maxWidth = constraints.maxWidth - 20;
          return Padding(
            padding: const EdgeInsets.only(top:10),
            child: SizedBox(
              width: maxWidth,
              child: TextField(
                decoration: const InputDecoration(
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(30.0))),
                  hintStyle: TextStyle(color: Colors.black),
                  fillColor: Colors.white,
                  focusColor: Colors.black,
                  hintText: 'Search for something tasty...',
                  prefixIcon: Icon(Icons.search),
                  prefixIconColor: Colors.black,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  ),
                ),
                onChanged: (value) {
                  DropDownPopup();
                  foodDataProvider.filter(value);

                },

              ),
            ),
          );
        });
  }
}

class DropDownPopup extends StatefulWidget {
  const DropDownPopup({Key? key}) : super(key: key);

  @override
  _DropDownPopupState createState() => _DropDownPopupState();
}

class _DropDownPopupState extends State<DropDownPopup> {
  String? selectedFood;

  @override
  Widget build(BuildContext context) {
    final foodDataProvider = Provider.of<FoodDataProvider>(context);

    return DropdownButton(
      value: selectedFood,
      items: [
        DropdownMenuItem(
          child: Text('Select a food'),
          value: null,
        ),
        for (FoodData foodData in foodDataProvider.filteredFoodData)
          DropdownMenuItem(
            child: Text(foodData.foodName),
            value: foodData.foodName,
          ),
      ],
      onChanged: (value) {
        setState(() {
          selectedFood = value;
        });
        if (value != null) {
          // Do something when a food item is selected
        }
      },
    );
  }
}

