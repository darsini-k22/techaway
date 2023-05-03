import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onPressed;
  final HitTestBehavior behavior;


  const Button(
      {super.key,
      required this.text,
      required this.color,
      required this.onPressed,
      this.behavior = HitTestBehavior.deferToChild,});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: behavior,
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(30)),
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Text(text,style:TextStyle(color: Colors.white,fontFamily: 'Nunito',fontSize: 13,fontWeight: FontWeight.w800)),
        ),
      ),
    );
  }
}
