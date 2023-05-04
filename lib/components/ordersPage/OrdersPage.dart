import 'dart:async';


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techaway/components/Providers/OrderDataProvider.dart';
import 'package:techaway/components/ordersPage/button.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  int _totalSecondsRemaining = 2700;
  Timer? _timer;
  bool flag = true;
  bool noOrder = true;

  void buttonPressed() {
    setState(() {
      flag = !flag;
    });
  }

  void noOrderText() {
    setState(() {
      noOrder != noOrder;
    });
  }

  @override
  void initState() {
    super.initState();
    final orderDataProvider =
    Provider.of<OrderDataProvider>(context, listen: false);
    if (orderDataProvider.orderData.data.isNotEmpty) {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          _totalSecondsRemaining--;
        });
        if (_totalSecondsRemaining == 0) {
          orderDataProvider.removeOrder();
          buttonPressed();
          noOrderText();
          _timer?.cancel();
        }
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final orderDataProvider = Provider.of<OrderDataProvider>(context);

    int minutes = _totalSecondsRemaining ~/ 60;
    int seconds = _totalSecondsRemaining % 60;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Row(
          children: [
            Text(
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
              'My Orders',
            ),
          ],
        ),
        automaticallyImplyLeading: true,
      ),
      body: ordersBody(minutes, seconds, buttonPressed, orderDataProvider),
    );
  }

  Padding ordersBody(int min, int sec, VoidCallback buttonPressed,
      OrderDataProvider orderDataProvider) {
    int minutes = min;
    int seconds = sec;
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              const SizedBox(
                height: 20,
              ),
              Table(
                children: [
                  billRow(
                      "Items",
                      "Quantity",
                      "Price",
                      TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 23,
                          fontFamily: 'Nunito',
                          color: Colors.red.shade900))
                ],
              ),
              Visibility(
                  visible: noOrder && orderDataProvider.orderData.data.isEmpty,
                  child: Padding(
                    padding: EdgeInsets.only(top: 70.0),
                    child: Center(
                      child: Text(
                          'No Orders Placed 😕. Order Something Tasty 😃❗',
                          overflow: TextOverflow.visible,
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 14,
                              fontFamily: 'Nunito')),
                    ),
                  )),
              SizedBox(
                height: 350,
                child: Consumer<OrderDataProvider>(
                  builder: (context, value, child) {
                    return ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: orderDataProvider.orderData.data.length,
                        itemBuilder: (context, index) {
                          final data = orderDataProvider.orderData.data[index];
                          return Table(
                            children: [
                              billRow(
                                  '${data.foodData.foodName[0].toUpperCase()}${data.foodData.foodName.substring(1).toLowerCase()}',
                                  data.qty.toString(),
                                  (data.foodData.price * data.qty).toString(),
                                  TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700))
                            ],
                          );
                        });
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Button(
                              text: "Confirm Order",
                              color: orderDataProvider.orderData.data.isNotEmpty
                                  ? Colors.green
                                  : Colors.grey,
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    // Create the dialog box widget
                                    return AlertDialog(shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(32.0))),
                                      backgroundColor: Colors.orange.shade300,
                                      title: Text(
                                        'Conform The Order',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w800),
                                      ),
                                      content: Text(
                                        'Are you sure to take this order?',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w800),
                                      ),
                                      actions: <Widget>[
                                        // Create a button widget to close the dialog box
                                        TextButton(
                                          style: ButtonStyle(shape:MaterialStateProperty.all<RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(25.0),
                                            ),),
                                              backgroundColor:
                                              MaterialStateProperty.all<
                                                  Color>(Colors.green)),
                                          child: Text(
                                            'Confirm',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w800),
                                          ),
                                          onPressed: () {
                                            noOrderText();
                                            buttonPressed();
                                            if (flag == false) {
                                              orderDataProvider.removeOrder();
                                              _timer?.cancel();
                                              print(
                                                  orderDataProvider.orderData);
                                              // set no order text visible
                                            }
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          style: ButtonStyle(shape:MaterialStateProperty.all<RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(25.0),
                                            ),),
                                              backgroundColor:
                                              MaterialStateProperty.all<
                                                  Color>(Colors.red)),
                                          child: Text(
                                            'Cancel',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w800),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              })),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: 200,
                        child: Text(
                          "*Conformation button should be pressed only by the staffs of the canteen!",
                          overflow: TextOverflow.visible,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.yellow.shade800,
                              fontWeight: FontWeight.w800),
                          maxLines: 3,
                        ),
                      ),
                    ],
                  ),
                  Text("Grand Total:",
                      style: TextStyle(
                          color: Colors.green.shade900,
                          fontFamily: 'Nunito',
                          fontSize: 20,
                          fontWeight: FontWeight.w800)),
                  Text('${orderDataProvider.grandTotal()}',
                      style: TextStyle(
                          color: Colors.green.shade900,
                          fontFamily: 'Nunito',
                          fontSize: 23,
                          fontWeight: FontWeight.w800))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 20,
              ),
              Visibility(
                visible: orderDataProvider.orderData.data.isNotEmpty,
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.orange),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Text("Time Left",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white)),
                          Text('$minutes:${seconds.toString().padLeft(2, '0')}',
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white))
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ]),
          )),
    );
  }
}

TableRow billRow(String t1, String t2, String t3, TextStyle style) {
  return TableRow(
    children: [
      TableCell(
        child: Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: Center(child: Text(t1, style: style)),
        ),
      ),
      TableCell(
        child: Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: Center(child: Text(t2, style: style)),
        ),
      ),
      TableCell(
        child: Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: Center(child: Text(t3, style: style)),
        ),
      ),
    ],
  );
}