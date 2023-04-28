import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  const AddButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onTap: () {
          print("add button tapped");
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.green, borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
            child: Row(children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50)),
                    child: Icon(Icons.add, color: Colors.green)),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text("Add"),
              )
            ]),
          ),
        ),
      ),
    );
  }
}