import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techaway/components/Providers/CartItemsProvider.dart';
import 'package:techaway/components/Providers/OrderDataProvider.dart';
import 'package:techaway/components/cartPage/CartData.dart';
import 'package:techaway/components/checkOutPage/CheckOutPage.dart';

class MyCartPage extends StatefulWidget {
  const MyCartPage({Key? key}) : super(key: key);

  @override
  State<MyCartPage> createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
  @override
  Widget build(BuildContext context) {
    final cartItemProvider = Provider.of<CartItemProvider>(context);
    final orderDataProvider = Provider.of<OrderDataProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
              'My Cart',
            ),
            SizedBox(width: 10,),
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.green),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal:8.0,vertical:6.0),
                  child: Text(cartItemProvider.cartData.length.toString(),
                      style: TextStyle(color: Colors.white,fontSize:17,fontWeight: FontWeight.w900)),
                ))
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 10),
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                        onTap: () {
                          cartItemProvider.removeAll();
                        },
                        child: Icon(Icons.cancel))),
              ),
              Visibility(
                visible: cartItemProvider.cartData.isNotEmpty,
                child: SizedBox(
                  height: 300,
                  child: Consumer<CartItemProvider>(
                    builder: (context, foodModel, child) {
                      return Consumer<CartItemProvider>(
                          builder: (context, cartItemProvider, child) {
                        return ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: cartItemProvider.cartData.length,
                            itemBuilder: (context, index) {
                              final data = cartItemProvider.cartData[index];
                              if (cartItemProvider.cartData.length != 0) {
                                return CartCard(
                                  data: data,
                                  path:
                                      "assets/images/${data.foodData.foodName}.png",
                                );
                              } else {
                                return Center(
                                  child: Text('No Items'),
                                );
                              }
                            });
                      });
                    },
                  ),
                ),
              ),
              Visibility(
                visible: cartItemProvider.cartData.isEmpty,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 100, horizontal: 40),
                  child: Center(
                      child: Text(
                          'No Food In Yout Cart 😕. Add Something To Fill Your Tummy With Yummy 😋 Foods ❗❗',
                          overflow: TextOverflow.visible,
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w700))),
                ),
              ),
              SizedBox(height: 52),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Order Summary",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w900))),
              ),
              SizedBox(height: 25),
              Flexible(
                fit: FlexFit.loose,
                flex: 1,
                child: Consumer<CartItemProvider>(
                    builder: (context, provider, child) {
                  final data = provider.cartData;
                  if (data.isNotEmpty) {
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final cartData = data[index];
                          //calculateGrandTotal(cartData.foodData.price*cartData.qty);
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    cartData.foodData.foodName +
                                        ' x ' +
                                        cartData.qty.toString(),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700)),
                                Text(
                                    'Rs. ${cartData.qty * cartData.foodData.price}'
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w800))
                              ],
                            ),
                          );
                        });
                  }

                  return Text('No Item',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w700));
                }),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Grand total",
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 20,
                            fontWeight: FontWeight.w700)),
                    SizedBox(),
                    Text("Rs. ${cartItemProvider.grandTotal}",
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 22,
                            fontWeight: FontWeight.w700))
                  ],
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  if (cartItemProvider.cartData.length != 0 &&
                      orderDataProvider.orderData.data.isEmpty) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CheckOutPage(),
                      ),
                    );
                  }
                  return null;
                },
                child: Container(
                  width: 350,
                  decoration: BoxDecoration(
                      color: cartItemProvider.cartData.isNotEmpty &&
                              orderDataProvider.orderData.data.isEmpty
                          ? Colors.green
                          : Colors.grey,
                      borderRadius: BorderRadius.circular(30)),
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Center(
                      child: Text(
                        'Check Out',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: orderDataProvider.orderData.data.isNotEmpty,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'An Order is been already placed❗ Try after the previous order is done',
                    style: TextStyle(color: Colors.red,fontWeight: FontWeight.w800),
                    overflow: TextOverflow.visible,
                  ),
                ),
              )
            ])),
      ),
    );
  }
}

class CartCard extends StatefulWidget {
  final CartData data;
  final String path;

  const CartCard({
    super.key,
    required this.data,
    required this.path,
  });

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  @override
  Widget build(BuildContext context) {
    final cartItemProvider = Provider.of<CartItemProvider>(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.green,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(
                  widget.path,
                  fit: BoxFit.cover,
                  width: 60.0,
                  height: 60.0,
                ),
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.data.foodData.foodName[0].toUpperCase()}${widget.data.foodData.foodName.substring(1).toLowerCase()}',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text('Price: ${widget.data.foodData.price}',
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                          fontFamily: 'Nunito',
                          color: Colors.grey.shade600)),
                  SizedBox(height: 8.0),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          cartItemProvider.decrement(widget.data.foodData);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.green[300],
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4.0),
                            child: Icon(
                              Icons.remove,
                              size: 20.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        widget.data.qty.toString(),
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.w800),
                      ),
                      SizedBox(width: 8.0),
                      GestureDetector(
                        onTap: () {
                          cartItemProvider.increment(widget.data.foodData);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.green[300],
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4.0),
                            child: Icon(Icons.add,
                                size: 20.0, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.0),
            GestureDetector(
              onTap: () {
                cartItemProvider.removeById(widget.data.foodData.id);
              },
              child: Icon(Icons.close, size: 24.0, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
