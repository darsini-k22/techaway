import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techaway/components/FoodData.dart';
import 'package:techaway/components/Providers/FoodIDataProvider.dart';
import 'package:techaway/components/Providers/UserDataProvider.dart';
import 'package:techaway/components/homePage/addButton.dart';

class FoodDisplayContainer extends StatelessWidget {
  final String path;
  final FoodData data;

  const FoodDisplayContainer({
    Key? key,
    required this.data,
    required this.path,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final foodDataProvider = Provider.of<FoodDataProvider>(context);
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(width: 1, color: Colors.grey),
      ),
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 120,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        path,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade700,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: Text(
                        'Rs.${data.price}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            Flexible(
              child: Text(
                '${data.foodName[0].toUpperCase()}${data.foodName.substring(1).toLowerCase()}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Nunito',
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [AddButton(data: data), FavoriteButton(foodId: data.id,)],
            ),
            Visibility(
                visible: foodDataProvider.getById(data.id).stockLeft == 0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      child: Text(
                    "No stock left",
                    overflow: TextOverflow.visible,
                    maxLines: 2,
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  )),
                ))
          ],
        ),
      ),
    );
  }
}

class FoodDisplayContainerHorizontal extends StatelessWidget {
  final String path;
  final FoodData data;

  const FoodDisplayContainerHorizontal({
    Key? key,
    required this.data,
    required this.path,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final foodDataProvider = Provider.of<FoodDataProvider>(context);
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(width: 1, color: Colors.grey),
      ),
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          width: 300,
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 120,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          path,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                        decoration: BoxDecoration(
                          color: Colors.orange.shade700,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        child: Text(
                          'Rs.${data.price}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Flexible(
                child: Text(
                  '${data.foodName[0].toUpperCase()}${data.foodName.substring(1).toLowerCase()}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Nunito',
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [AddButton(data: data), FavoriteButton(foodId:data.id)],
              ),
              Visibility(
                  visible: foodDataProvider.getById(data.id).stockLeft == 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        child: Text(
                      "No stock left",
                      overflow: TextOverflow.visible,
                      maxLines: 2,
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 17,
                          fontWeight: FontWeight.w700),
                    )),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}



class FavoriteButton extends StatefulWidget {
  final String foodId;


  FavoriteButton({
    required this.foodId,
  });

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _getFavoriteState();
  }

  Future<bool> _getFavoriteState() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return false;
    }


    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('favorites')
        .doc(widget.foodId)
        .get();

    setState(() {
      _isFavorite = doc.exists;
    });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _getFavoriteState(),
      initialData: false,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if(snapshot.hasData){
          return IconButton(
            icon: _isFavorite
                ? Icon(Icons.favorite, color: Colors.red)
                : Icon(Icons.favorite_border),
            onPressed: () async {
              final User? user = FirebaseAuth.instance.currentUser;
              if (user == null) {
                // Handle user not signed in
                return;
              }

              final favoritesRef = FirebaseFirestore.instance
                  .collection('users')
                  .doc(user.uid)
                  .collection('favorites');

              if (_isFavorite) {
                // Remove from favorites
                await favoritesRef.doc(widget.foodId).delete();
                setState(() {
                  _isFavorite = false;
                });
              } else {
                // Add to favorites
                await favoritesRef.doc(widget.foodId).set({});
                setState(() {
                  _isFavorite = true;
                });
              }

            },
          );
        }
        return CircularProgressIndicator();

      },
    );
  }
}