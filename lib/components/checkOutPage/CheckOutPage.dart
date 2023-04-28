import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techaway/components/CurrentIndexProvider.dart';
import 'package:techaway/main.dart';

import '../cartPage/CartPage.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({Key? key}) : super(key: key);

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  @override
  Widget build(BuildContext context) {
    final currentIndexProvider = Provider.of<CurrentIndexProvider>(context);
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
              'Check Out',
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
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Order Summary")),
                      ]),
                ),
                SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Zone 1 item total"),
                      Text("qty: 1"),
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
                      Text("qty: 1"),
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
                      Text("qty: 1"),
                      Text("Rs. 20")
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("Grand total"), Text("Rs. 60")],
                  ),
                ),
                SizedBox(height: 35),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Payment Method")),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("UPI"),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                        child: Image.asset(
                                            "assets/images/paytm.png")),
                                  ),
                                  SizedBox(
                                    width: 28,
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                        child: Image.asset(
                                            "assets/images/gpay.png")),
                                  )
                                ])
                          ],
                        ),
                      )),
                ),
                // SizedBox(height: 20),
                // Padding(
                //   padding: EdgeInsets.all(8),
                //   child: Container(
                //       decoration: BoxDecoration(
                //           color: Colors.grey.shade300,
                //           borderRadius: BorderRadius.circular(20)),
                //       child: Padding(
                //         padding: const EdgeInsets.all(20.0),
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             Text("Wallet Payment"),
                //             Row(
                //                 mainAxisAlignment:
                //                     MainAxisAlignment.spaceEvenly,
                //                 children: [
                //                   Container(child: Text("balance: Rs. 500")),
                //                 ])
                //           ],
                //         ),
                //       )),
                // ),
                SizedBox(
                  height: 60,
                ),
                GestureDetector(
                  onTap: () {

                    currentIndexProvider.setCurrentIndex(0);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyHomePage(),
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
                          'Confirm Payment',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
