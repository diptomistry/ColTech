import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ExpertProfile extends StatefulWidget {
  @override
  _ExpertProfileState createState() => _ExpertProfileState();
}

class _ExpertProfileState extends State<ExpertProfile> {
  String fullName = '';
  String email = '';
  String profession = '';
  String skill = '';

  @override
  void initState() {
    super.initState();
    // Fetch expert data from Firestore
    FirebaseFirestore.instance.collection('experts').doc('your_expert_document_id').get().then((doc) {
      if (doc.exists) {
        setState(() {
          fullName = doc.data()?['Full Name'] ?? '';
          email = doc.data()?['Email'] ?? '';
          profession = doc.data()?['Profession'] ?? '';
          skill = doc.data()?['Skill'] ?? '';
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expert Profile'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            radius: 80,
            backgroundImage: AssetImage('assets/image1.png'), // Set the profile picture image
          ),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  fullName,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  profession,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Text(
                  email,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  skill,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                // Add more fields as needed
              ],
            ),
          ),
        ],
      ),
    );
  }
}
