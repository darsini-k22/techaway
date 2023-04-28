import 'package:flutter/material.dart';
import 'package:techaway/components/checkOutPage/CheckOutPage.dart';

class MyCartPage extends StatefulWidget {
  const MyCartPage({Key? key}) : super(key: key);

  @override
  State<MyCartPage> createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
  @override
  Widget build(BuildContext context) {
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
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 10),
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("Zone 1"),
                ),
              ),
              CartCard(
                path: "assets/images/sandwitch.png",
                itemName: "sandwitch",
                itemPrice: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("Zone 2"),
                ),
              ),
              CartCard(
                path: "assets/images/sandwitch.png",
                itemName: "sandwitch",
                itemPrice: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("Zone 3"),
                ),
              ),
              CartCard(
                path: "assets/images/sandwitch.png",
                itemName: "sandwitch",
                itemPrice: 20,
              ),
              SizedBox(height: 28),
              Divider(
                thickness: 1,
                color: Colors.black,
              ),
              SizedBox(height: 28),
              Text("Order Summary"),
              SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Zone 1 item total"),
                    SizedBox(),
                    Text("Rs. 20")
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Zone 2 item total"),
                    SizedBox(),
                    Text("Rs. 20")
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Zone 3 item total"),
                    SizedBox(),
                    Text("Rs. 20")
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("Grand total"), SizedBox(), Text("Rs. 60")],
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CheckOutPage(),
                    ),
                  );
                },
                child: Container(
                  width: 350,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(30)),
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Center(
                      child: Text(
                        'Check Out',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              )
            ])),
      ),
    );
  }
}

class CartCard extends StatefulWidget {
  final String path;
  final String itemName;
  final double itemPrice;

  const CartCard(
      {super.key,
      required this.path,
      required this.itemName,
      required this.itemPrice});

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  late int _qty = 1;

  void incrementQty() {
    setState(() {
      _qty++;
    });
  }

  void decrementQty() {
    setState(() {
      _qty--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _qty > 0,
      child: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(20)),
          child: Row(children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
                child: Image.asset(widget.path),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Column(
              children: [
                Text(
                  "Sandwitch",
                  style: TextStyle(color: Colors.red.shade700),
                ),
                SizedBox(
                  height: 18,
                ),
                Text('Rs ' + widget.itemPrice.toString(),
                    style: TextStyle(color: Colors.red.shade700))
              ],
            ),
            SizedBox(
              width: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 70),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            decrementQty();
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.brown,
                                  borderRadius: BorderRadius.circular(50)),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              )),
                        ),
                        SizedBox(width: 10),
                        Text(_qty.toString(),
                            style: TextStyle(color: Colors.red.shade700)),
                        SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            if (_qty < 10) {
                              incrementQty();
                            }
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.brown,
                                  borderRadius: BorderRadius.circular(50)),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              )),
                        ),
                      ])
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
