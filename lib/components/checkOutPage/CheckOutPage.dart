import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techaway/components/Providers/CartItemsProvider.dart';
import 'package:techaway/components/Providers/CurrentIndexProvider.dart';
import 'package:techaway/components/Providers/OrderDataProvider.dart';
import 'package:techaway/components/Providers/UserDataProvider.dart';
import 'package:techaway/main.dart';



class CheckOutPage extends StatefulWidget {
  const CheckOutPage({Key? key}) : super(key: key);

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  late bool payed = false;
  bool gpay=false;
  bool paytm=false;

  void makePayment() {
    setState(() {
      payed = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartItemProvider = Provider.of<CartItemProvider>(context);
    final currentIndexProvider = Provider.of<CurrentIndexProvider>(context);
    final orderDataProvider = Provider.of<OrderDataProvider>(context);
    final userDataProvider = Provider.of<UserDataProvider>(context);
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
            padding: EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text("Order Summary",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                ),
                Container(
                  height: 280,
                  child: Consumer<CartItemProvider>(
                      builder: (context, provider, child) {
                    final data = provider.cartData;
                    if (data.isNotEmpty) {
                      return ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            final cartData = data[index];
                            //calculateGrandTotal(cartData.foodData.price*cartData.qty);
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      cartData.foodData.foodName +
                                          ' x ' +
                                          cartData.qty.toString(),
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700)),
                                  Text(
                                      '${cartData.qty * cartData.foodData.price}'
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700))
                                ],
                              ),
                            );
                          });
                    }

                    return Text('No Item');
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
                              fontSize: 23,
                              fontWeight: FontWeight.w900,
                              color: Colors.green)),
                      Text("Rs. ${cartItemProvider.grandTotal}",
                          style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w900,
                              color: Colors.green))
                    ],
                  ),
                ),
                SizedBox(height: 35),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Payment Method",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w900))),
                ),
                SizedBox(height: 20),
                Padding(
                    padding: EdgeInsets.all(8),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "UPI",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (!payed) {
                            makePayment();
                            setState(() {
                              paytm=true;
                              gpay=false;
                            });
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: paytm?Colors.orange:Colors.green.shade300),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              fit: BoxFit.contain,
                              "assets/images/paytm.png",
                              height: 40,
                              width: 40,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      GestureDetector(
                        onTap: () {
                          if (!payed) {
                            makePayment();
                            setState(() {
                              gpay=true;
                              paytm=false;
                            });

                          }

                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: gpay?Colors.orange:Colors.green.shade300),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              fit: BoxFit.contain,
                              "assets/images/gpay.png",
                              height: 40,
                              width: 40,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Visibility(
                    visible: payed,
                    child: Text(
                      "Successfully Payed! Enjoy Your Food!",
                      style: TextStyle(
                          color: Colors.green.shade700,fontSize: 15, fontWeight: FontWeight.w800),
                    )),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      if (payed == true) {
                        currentIndexProvider.setCurrentIndex(0);
                        orderDataProvider.write(
                            cartItemProvider.cartData,FirebaseAuth.instance.currentUser!.uid);
                        orderDataProvider
                            .updateStocks(cartItemProvider.cartData);
                        cartItemProvider.cartData.clear();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyHomePage(),
                          ),
                        );
                      }
                      return null;
                    },
                    child: Container(
                      width: 350,
                      decoration: BoxDecoration(
                          color: payed ? Colors.green : Colors.grey,
                          borderRadius: BorderRadius.circular(25)),
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Center(
                          child: Text(
                            'Confirm Payment',
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
                )
              ],
            )),
      ),
    );
  }
}
