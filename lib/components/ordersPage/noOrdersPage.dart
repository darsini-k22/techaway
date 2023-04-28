import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techaway/components/CurrentIndexProvider.dart';
import 'package:techaway/main.dart';

class noOrdersPage extends StatelessWidget {
  const noOrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentIndexProvider = Provider.of<CurrentIndexProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
            onPressed: () {
              currentIndexProvider.setCurrentIndex(0);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MyHomePage(),
                ),
              );
            },
          ),
        ),
        title: Row(
          children: [
            Text(
              'My Orders',
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Center(
            child: Text("No Orders Available"),
          ),
        ],
      ),
    );
  }
}

// SizedBox(
// width: 3,
// ),
// Container(
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(50),
// color: Colors.green),
// child: Padding(
// padding:
// const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
// child: Text("2",
// style: TextStyle(color: Colors.black, fontSize: 12)),
// ))
