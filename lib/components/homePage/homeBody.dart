import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:techaway/components/homePage/foodDisplayContainer.dart';

class homeBody extends StatefulWidget {
  const homeBody({Key? key}) : super(key: key);

  @override
  State<homeBody> createState() => _homeBodyState();
}

class _homeBodyState extends State<homeBody> {
  final CollectionReference ref = FirebaseFirestore.instance.collection('food');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: ref.snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
        if (streamSnapshot.hasData) {
          return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  // const SearchBar(),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Best Sellers")),
                  ),
                  SizedBox(
                    height: 250,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 2,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot documentSnapshot =
                              streamSnapshot.data!.docs[index];

                          return FoodDisplayContainer(
                            data: [
                              documentSnapshot['foodName'],
                              documentSnapshot['price'],
                              documentSnapshot['stocksLeft']
                            ],
                            path: "assets/images/sandwitch.png",
                            foodName: documentSnapshot['foodName'],
                            price: documentSnapshot['price'],
                            stocksLeft: documentSnapshot['stocksLeft'],
                          );
                        }),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Try These Out")),
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.loose,
                    child: GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 3 / 4,
                        ),
                        itemCount: streamSnapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot documentSnapshot =
                              streamSnapshot.data!.docs[index];

                          return FoodDisplayContainer(
                            data: [
                              documentSnapshot['foodName'],
                              documentSnapshot['price'],
                              documentSnapshot['stocksLeft']
                            ],
                            path: "assets/images/sandwitch.png",
                            foodName: documentSnapshot['foodName'],
                            price: documentSnapshot['price'],
                            stocksLeft: documentSnapshot['stocksLeft'],
                          );
                        }),
                  ),
                ]),
              ));
        } else if (streamSnapshot.hasError) {
          print(streamSnapshot.error.toString());
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
