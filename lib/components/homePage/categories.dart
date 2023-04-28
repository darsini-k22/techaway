import 'package:flutter/material.dart';
class Categories extends StatelessWidget {
  const Categories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: [
        individualCategories("assets/images/cake.png", "Meals"),
        individualCategories("assets/images/cake.png", "Breakfast"),
        individualCategories("assets/images/cake.png", "Lunch"),
        individualCategories("assets/images/cake.png", "Snacks"),
        individualCategories("assets/images/cake.png", "Meals"),
        individualCategories("assets/images/cake.png", "Meals"),
        individualCategories("assets/images/cake.png", "Meals"),
        individualCategories("assets/images/cake.png", "Meals"),
      ]),
    );
  }

  Padding individualCategories(path, title) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.orangeAccent,
            borderRadius: BorderRadius.circular(30.0)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
          child: Row(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(path),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(title),
            )
          ]),
        ),
      ),
    );
  }
}


