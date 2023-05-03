import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techaway/components/Providers/FoodIDataProvider.dart';
import 'package:techaway/components/homePage/foodDisplayContainer.dart';


class homeBody extends StatefulWidget {
  const homeBody({Key? key}) : super(key: key);

  @override
  State<homeBody> createState() => _homeBodyState();
}

class _homeBodyState extends State<homeBody> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<FoodDataProvider>(context, listen: false).fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final foodDataProvider = Provider.of<FoodDataProvider>(context);

    return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const Padding(
              padding: EdgeInsets.all(13.0),
              child: Align(
                  alignment: Alignment.centerLeft, child: Text("Best Sellers",style:TextStyle(fontSize: 23,fontWeight: FontWeight.w800))),
            ),
            SizedBox(
                height: 280,
                child: StreamBuilder<QuerySnapshot>(
                    stream: Provider.of<FoodDataProvider>(context).foodStream(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: foodDataProvider.filteredFoodData.length-10,
                            itemBuilder: (context, index) {
                              return FoodDisplayContainerHorizontal(
                                data: foodDataProvider.filteredFoodData[index],
                                path: "assets/images/${foodDataProvider.filteredFoodData[index].foodName}.png",
                              );
                            });
                      } else if (snapshot.hasError) {
                        return Text("Error: ${snapshot.error}");
                      } else {
                        return CircularProgressIndicator();
                      }
                    })),
            Padding(
              padding: EdgeInsets.all(13.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Try These Out",style:TextStyle(fontSize: 23,fontWeight: FontWeight.w800))),
            ),
            Flexible(
                flex: 1,
                fit: FlexFit.loose,
                child: StreamBuilder<QuerySnapshot>(
                    stream: Provider.of<FoodDataProvider>(context).foodStream(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {

                        return GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 0.66,
                            ),
                            itemCount: foodDataProvider.filteredFoodData.length-5,
                            itemBuilder: (context, index) {
                              return FoodDisplayContainer(
                                data: foodDataProvider.filteredFoodData[index+5],
                                path: "assets/images/${foodDataProvider.filteredFoodData[index+5].foodName}.png",
                              );
                            });
                      } else if (snapshot.hasError) {
                        return Text("Error: ${snapshot.error}");
                      } else {
                        return CircularProgressIndicator();
                      }
                    }))
          ]),
        ));

  }
}



