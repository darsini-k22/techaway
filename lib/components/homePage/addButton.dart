import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techaway/components/Providers/CartItemsProvider.dart';
import 'package:techaway/components/FoodData.dart';

class AddButton extends StatelessWidget {
  final FoodData data;
  const AddButton({Key? key,required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CartItemProvider>(
      builder: (context, cartItemProvider, child) {
        return GestureDetector(
          onTap: () {
            if (data.stockLeft != 0) {
              if (!cartItemProvider.isInCart(data)) {
                cartItemProvider.addCartData(data);
              } else {
                cartItemProvider.removeCartData(data);
              }
            }
          },
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: data.stockLeft != 0 ? Colors.green : Colors.grey,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      cartItemProvider.isInCart(data) ? Icons.check : Icons.add,
                      color: Colors.white,
                      size: 24,
                    ),
                    SizedBox(width: 8),
                    Text(
                      cartItemProvider.isInCart(data) ? '' : 'Add',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
