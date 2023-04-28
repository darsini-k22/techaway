import 'package:flutter/material.dart';
import 'package:techaway/components/homePage/addButton.dart';

class FoodDisplayContainer extends StatelessWidget {
  final String path;
  final String? foodName;
  final String? price;
  final String? stocksLeft;

  const FoodDisplayContainer({
    Key? key,
    required this.path,
    this.foodName,
    this.price,
    this.stocksLeft,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Row(
            children: [
              Column(
                children: [
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.orangeAccent,
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(55, 25, 55, 25),
                        child: Image.asset(path),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Row(children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: text("Rs.$price", Alignment.centerLeft)),
                      SizedBox(width: 25),
                      Align(
                          alignment: Alignment.centerRight,
                          child: text(foodName!, Alignment.centerLeft))
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Row(children: [
                      Align(
                          alignment: Alignment.centerLeft, child: AddButton()),
                      SizedBox(width: 25),
                      Align(
                          alignment: Alignment.centerRight,
                          child:
                              text('$stocksLeft left', Alignment.centerRight))
                    ]),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Align text(String textString, Alignment alignment) =>
      Align(alignment: alignment, child: Text(textString));
}
