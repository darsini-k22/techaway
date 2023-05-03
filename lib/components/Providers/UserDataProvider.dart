import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:techaway/components/userCredentials/UserData.dart';

class UserDataProvider with ChangeNotifier {
  UserData _currentUserData = UserData(userId: "", userName: "", userEmail: "");

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
  Future<String> getUsername() async {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    _currentUserData.userName=doc.get('username');
    return doc.get('username');

  }



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

  Future<void> login(String userEmail) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('userEmail', isEqualTo: userEmail)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        _currentUserData.userName = querySnapshot.docs.first.data()['userName'];
      }
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  UserData get currentUserData => _currentUserData;
}
