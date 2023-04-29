import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techaway/components/CartItemsProvider.dart';
import 'package:techaway/components/FoodData.dart';

class AddButton extends StatefulWidget {
  final List<String> data;

  const AddButton({super.key, required this.data});

  @override
  State<AddButton> createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  late bool flag = false;

  void added() {
    setState(() {
      flag = !flag;
    });
  }


  @override
  Widget build(BuildContext context) {
    final cartItemProvider = Provider.of<CartItemProvider>(context);
    if(cartItemProvider.getAdded(widget.data[0])==false && cartItemProvider.getAdded(widget.data[0])!=null){
      setState(() {
        flag=false;
      });
    }

    return Align(
      alignment: Alignment.centerLeft,
      child: Consumer<CartItemProvider>(
        builder: (context, cartItemProvider, child){
        return GestureDetector(
          onTap: () {
            added();
            FoodData foodData = FoodData(
              foodName: widget.data![0],
              price: widget.data![2],
              stockLeft: widget.data![1],
            );
            if (flag) {
              cartItemProvider.setFoodData(foodData);
            } else {
              cartItemProvider.removeItem(widget.data[0]);
            }
          },
          child: Container(
            decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(20)
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
              child: Row(children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50)
                    ),
                    child: Icon(
                      flag ? Icons.check : Icons.add,
                      color: Colors.green,
                    ),
                  ),
                ),
                Visibility(
                  visible: !flag,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text("Add"),
                  ),
                )
              ]),
            ),
          ),
        );}
      ),
    );
  }
}
