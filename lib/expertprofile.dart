//
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class ExpertProfile extends StatefulWidget {
//   @override
//   _ExpertProfileState createState() => _ExpertProfileState();
// }
//
// class _ExpertProfileState extends State<ExpertProfile> {
//   String fullName = '';
//   String email = '';
//   String profession = '';
//   String skill = '';
//
//   @override
//   void initState() {
//     super.initState();
//    // _user = _auth.currentUser!;
//     // Fetch expert data from Firestore
//     FirebaseFirestore.instance.collection('experts').doc('your_expert_document_id').get().then((doc) {
//       if (doc.exists) {
//         setState(() {
//           fullName = doc.data()?['Full Name'] ?? '';
//           email = doc.data()?['Email'] ?? '';
//           profession = doc.data()?['Profession'] ?? '';
//           skill = doc.data()?['Skill'] ?? '';
//         });
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Expert Profile'),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           CircleAvatar(
//             radius: 80,
//             backgroundImage: AssetImage('assets/image1.png'), // Set the profile picture image
//           ),
//           SizedBox(height: 20),
//           Align(
//             alignment: Alignment.centerLeft,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Text(
//                   fullName,
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text(
//                   profession,
//                   style: TextStyle(
//                     fontSize: 18,
//                   ),
//                 ),
//                 Text(
//                   email,
//                   style: TextStyle(
//                     fontSize: 16,
//                   ),
//                 ),
//                 Text(
//                   skill,
//                   style: TextStyle(
//                     fontSize: 16,
//                   ),
//                 ),
//                 // Add more fields as needed
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ExpertProfile extends StatefulWidget {
  @override
  _ExpertProfileState createState() => _ExpertProfileState();
}

class _ExpertProfileState extends State<ExpertProfile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late User _expert;
  late String _name;
  late String _email;
  late String _profession;
  late String _skill;

  @override
  void initState() {
    super.initState();
    _expert = _auth.currentUser!;

    // Fetch user data from Firestore
    _firestore.collection('experts').doc(_expert.uid).get().then((doc) {
      if (doc.exists) {
        setState(() {
          _name = doc.data()?['Name'];
          _email = doc.data()?['Email'];
          _skill = doc.data()?['Skill'];
          _profession = doc.data()?['Profession'];
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
      body: Center(
        child: Column(
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
                    _name,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    _profession,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    _skill,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    _email,
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
      ),
    );
  }
}


