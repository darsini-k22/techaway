import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techaway/components/CartItemsProvider.dart';
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
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              SizedBox(
                height: 250,
                child: Consumer<CartItemProvider>(
                  builder: (context, foodModel, child) {
                    return Consumer<CartItemProvider>(
                    builder: (context, cartItemProvider, child) {
                      return  ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: cartItemProvider.getFoodData().length,
                          itemBuilder: (context, index) {
                            final data = cartItemProvider.getFoodData()[index];

                            if (cartItemProvider.getFoodData().length != null && data.added) {
                              return CartCard(
                                provider: cartItemProvider,
                                path: "assets/images/sandwitch.png",
                                itemName: data.foodName,
                                itemPrice: data.price,
                                added: true,
                              );
                            } else {
                              return Center(
                                child: Text('No Items'),
                              );
                            }
                          });}
                    );
                  },
                ),
              ),
              SizedBox(height: 52),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Order Summary")),
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
  final String itemPrice;
  final CartItemProvider provider;
  final bool added;

  const CartCard(
      {super.key,
      required this.path,
      required this.itemName,
        required this.provider,
      required this.itemPrice,required this.added});

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {

  @override
  Widget build(BuildContext context) {
    int? qty=widget.provider.getQty(widget.itemName);
    if (qty != null) {
      qty=qty;
    } else {
      qty=1;
    }
    return Visibility(
      visible: qty > 0 && widget.added ,
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
                  widget.itemName,
                  style: TextStyle(color: Colors.red.shade700),
                ),
                SizedBox(
                  height: 18,
                ),
                Text('Rs ' + widget.itemPrice ,
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
                            widget.provider.decrementQty(widget.itemName);
                            if(qty==0){
                              widget.provider.setAdded(false, widget.itemName);
                            }
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
                        Text(qty.toString(),
                            style: TextStyle(color: Colors.red.shade700)),
                        SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                              widget.provider.incrementQty(widget.itemName);
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
