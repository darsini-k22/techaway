import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:techaway/components/userCredentials/UserData.dart';

class UserDataProvider with ChangeNotifier {
  UserData _currentUserData = UserData(userId: "", userName: "", userEmail: "");
  String userName='';

  Future<bool> isFavorite(String foodId) async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('favorites')
        .where('favoriteFoodId', isEqualTo: foodId)
        .limit(1)
        .get();

    return snapshot.docs.isNotEmpty;
  }

  // Future<void> getUserName() async {
  //   try {
  //     DocumentSnapshot snapshot = await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(FirebaseAuth.instance.currentUser!.uid)
  //         .get();
  //     if (snapshot.exists) {
  //
  //       _currentUserData.userName= snapshot.get('userName');
  //     }
  //   } catch (e) {
  //     print(e);
  //
  //   }
  // }



  Future<void> register(String userName, String userEmail) async {
    _currentUserData = UserData(
        userId: FirebaseAuth.instance.currentUser!.uid,
        userEmail: userEmail,
        userName: userName);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({'userName': userName, 'userEmail': userEmail});
    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('userEmail', isEqualTo: userEmail)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      _currentUserData.userName = querySnapshot.docs.first.data()['userName'];
    }
    notifyListeners();
  }


  Future<String> getUsername() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      return '';
    }
    final userSnapshot =
    await FirebaseFirestore.instance.collection('users').doc(userId).get();
    if (!userSnapshot.exists) {
      return '';
    }
    final userData = userSnapshot.data();
    userName=userData!['userName'] as String;
    return userData!['userName'] as String;
  }


  UserData get currentUserData => _currentUserData;
}
