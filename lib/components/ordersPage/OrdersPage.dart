import 'dart:async';

import 'package:flutter/material.dart';
import 'package:techaway/components/ordersPage/noOrdersPage.dart';
import 'package:techaway/components/ordersPage/button.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  int _totalSecondsRemaining = 2700;
  Timer? _timer;
  int flag = 3;

  void buttonPressed() {
    setState(() {
      flag--;
    });
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _totalSecondsRemaining--;
      });
      if (_totalSecondsRemaining == 0) {
        _timer?.cancel();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => noOrdersPage()));
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int minutes = _totalSecondsRemaining ~/ 60;
    int seconds = _totalSecondsRemaining % 60;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Row(
          children:[
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
      body: ordersBody(minutes, seconds, buttonPressed),
    );
  }

  Padding ordersBody(int min, int sec, VoidCallback buttonPressed) {
    int minutes = min;
    int seconds = sec;
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(children: [

            const SizedBox(
              height: 20,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Zone 1'),
            ),
            const SizedBox(
              height: 10,
            ),
            Table(
              border: const TableBorder(
                top: BorderSide(color: Colors.black),
                bottom: BorderSide(color: Colors.black),
              ),
              children: [
                billRow("Items", "Quantity", "Price"),
                billRow("Sandwitch", "2", "110.0"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 200,
                      child: const Text(
                        "*Conformation button should be pressed only by the staffs of the canteen!",
                        overflow: TextOverflow.visible,
                        style: TextStyle(fontSize: 14),
                        maxLines: 3,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Button(
                            text: "Confirm Order",
                            color: Colors.green,
                            onPressed: () {
                              buttonPressed();
                              if (flag == 0) {
                                _timer?.cancel();
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const noOrdersPage()));
                              }
                            })),
                  ],
                ),
                const Text("Totel:"),
                const Text("110")
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Zone 2'),
            ),
            const SizedBox(
              height: 10,
            ),
            Table(
              border: const TableBorder(
                top: BorderSide(color: Colors.black),
                bottom: BorderSide(color: Colors.black),
              ),
              children: [
                billRow("Sandwitch", "2", "110.0"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 200,
                      child: const Text(
                        "*Conformation button should be pressed only by the staffs of the canteen!",
                        overflow: TextOverflow.visible,
                        style: TextStyle(fontSize: 14),
                        maxLines: 3,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Button(
                            text: "Confirm Order",
                            color: Colors.green,
                            onPressed: () {
                              buttonPressed();
                              if (flag == 0) {
                                _timer?.cancel();
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const noOrdersPage()));
                              }
                            })),
                  ],
                ),
                const Text("Totel:"),
                const Text("110"),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Zone 3'),
            ),
            const SizedBox(
              height: 10,
            ),
            Table(
              border: const TableBorder(
                top: BorderSide(color: Colors.black),
                bottom: BorderSide(color: Colors.black),
              ),
              children: [
                billRow("Sandwitch", "2", "110.0"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 200,
                      child: const Text(
                        "*Conformation button should be pressed only by the staffs of the canteen!",
                        overflow: TextOverflow.visible,
                        style: TextStyle(fontSize: 14),
                        maxLines: 3,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Button(
                            text: "Confirm Order",
                            color: Colors.green,
                            onPressed: () {
                              buttonPressed();
                              if (flag == 0) {
                                _timer?.cancel();
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => noOrdersPage()));
                              }
                            })),
                  ],
                ),
                const Text("Totel:"),
                const Text("110")
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Grand Total"),
                  SizedBox(
                    width: 10,
                  ),
                  Text("160")
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.orange),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text("Time Left"),
                      Text('$minutes:${seconds.toString().padLeft(2, '0')}')
                    ],
                  ),
                ),
              ),
            )
          ])),
    );
  }
}

TableRow billRow(String t1, String t2, String t3) {
  return TableRow(
    children: [
      TableCell(
        child: Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: Center(child: Text(t1)),
        ),
      ),
      TableCell(
        child: Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: Center(child: Text(t2)),
        ),
      ),
      TableCell(
        child: Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: Center(child: Text(t3)),
        ),
      ),
    ],
  );
}
