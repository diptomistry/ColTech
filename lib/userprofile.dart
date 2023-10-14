import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late User _user;
  late String _name;
  late String _email;
  late String _profession;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser!;

    // Fetch user data from Firestore
    _firestore.collection('users').doc(_user.uid).get().then((doc) {
      if (doc.exists) {
        setState(() {
          _name = doc.data()?['Name'];
          _email = doc.data()?['Email'];
          _profession = doc.data()?['Profession'];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Name: $_name'),
            Text('Email: $_email'),
            Text('Profession: $_profession'),
            // Add more fields as needed
          ],
        ),
      ),
    );
  }
}
