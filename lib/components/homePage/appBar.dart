import 'package:flutter/material.dart';

PreferredSize appBar() {
  return PreferredSize(
    preferredSize: const Size.fromHeight(280.0),
    child: AppBar(
      title: const Align(
        alignment: Alignment.center,
        child: Text('My App'),
      ),
      flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.deepOrange.shade500, Colors.amber.shade700],
            ),
          ),
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Positioned(
                left: 0,
                child: Image.asset(
                  "assets/images/chief.png",
                  width: 200.0,
                  height: 200.0,
                ),
              ),
            ],
          )),
    ),
  );
}
