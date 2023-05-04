import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techaway/components/Providers/CurrentIndexProvider.dart';
import 'package:techaway/components/Providers/UserDataProvider.dart';
import 'package:techaway/components/userCredentials/UserLogin.dart';

class ProfilePage extends StatelessWidget {

  const ProfilePage({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userDataProvider = Provider.of<UserDataProvider>(context);
    final currentIndexProvider = Provider.of<CurrentIndexProvider>(context);
    final userId = FirebaseAuth.instance.currentUser?.uid;
    Stream<
        DocumentSnapshot<Map<String, dynamic>>> userStream = FirebaseFirestore
        .instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: userStream,
      builder: (BuildContext context,
          AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }
        final userName = snapshot.data?.get('userName');
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back,color: Colors.black,),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 32),
                Text(
                  'Profile',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 32),
                Text(
                  'Username:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
                ),
                Text(
                  "${userName}",
                  style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800),
                ),
                SizedBox(height: 16),
                Text(
                  'Email:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
                ),
                Text(
                  "${FirebaseAuth.instance.currentUser?.email}",
                  style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800),
                ),
                SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser.toString()).delete();
                    FirebaseAuth.instance.currentUser?.delete();
                    currentIndexProvider.currentIndex=0;
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginPage()));
                  },
                  child: Text('Delete Account'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                ),
              ],
            ),
          ),
        );;
      },
    );
  }
}