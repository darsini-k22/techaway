import 'package:flutter/material.dart';

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
                  borderSide: BorderSide(color: Colors.green),
                  borderRadius: BorderRadius.all(Radius.circular(30.0))),
              hintStyle: TextStyle(color: Colors.green),
              fillColor: Colors.white,
              focusColor: Colors.black,
              hintText: 'Search for something tasty...',
              prefixIcon: Icon(Icons.search),
              prefixIconColor: Colors.green,
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green),
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
              ),
            ),
            onChanged: (value) {
              // Handle search query change
              // Perform search operations based on the entered value
            },
          ),
        ),
      );
    });
  }
}
