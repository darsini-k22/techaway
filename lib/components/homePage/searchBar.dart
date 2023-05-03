import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
              foodDataProvider.filter(value);
            },

          ),
        ),
      );
    });
  }
}

class GridViewPopup extends StatelessWidget {
  const GridViewPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final foodDataProvider = Provider.of<FoodDataProvider>(context);
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
                child: Flexible(
                    flex: 1,
                    fit: FlexFit.loose,
                    child: StreamBuilder<QuerySnapshot>(
                        stream: Provider.of<FoodDataProvider>(context).foodStream(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {

                            return GridView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 0.66,
                                ),
                                itemCount: foodDataProvider.filteredFoodData.length-5,
                                itemBuilder: (context, index) {
                                  return FoodDisplayContainer(
                                    data: foodDataProvider.filteredFoodData[index+5],
                                    path: "assets/images/${foodDataProvider.filteredFoodData[index+5].foodName}.png",
                                  );
                                });
                          } else if (snapshot.hasError) {
                            return Text("Error: ${snapshot.error}");
                          } else {
                            return CircularProgressIndicator();
                          }
                        }))
            );
          },
        );
      },
      child: Text('Open Popup'),
    );
  }
}
