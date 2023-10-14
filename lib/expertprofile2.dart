import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ExpartProfile2 extends StatefulWidget {
  final String email;

  ExpartProfile2({required this.email});


  @override
  _ExpartProfile2State createState() => _ExpartProfile2State();
}

class _ExpartProfile2State extends State<ExpartProfile2> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late User _expert;
  late String _name='';
  late String _email='';
  late String _profession='';
  late String _skill='';

  @override
  void initState() {
    super.initState();
    _expert = _auth.currentUser!;


    // Search for the user's data based on the provided email
    _firestore
        .collection('experts')
        .where('Email', isEqualTo: widget.email)
        .get()
        .then((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        // Get the first document (assuming email is unique)
        final doc = querySnapshot.docs[0];
        setState(() {
          _name = doc.data()?['Name'] ?? '';
          _skill = doc.data()?['Skill'] ?? '';
          _profession = doc.data()?['Profession'] ?? '';
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as String;
    _email = args;
    _firestore
        .collection('experts')
        .where('Email', isEqualTo: args)
        .get()
        .then((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        // Get the first document (assuming email is unique)
        final doc = querySnapshot.docs[0];
        setState(() {
          _name = doc.data()?['Name'] ?? '';
          _email = doc.data()?['Email'] ?? '';
          _profession = doc.data()?['Profession'] ?? '';
          _skill = doc.data()?['Skill'] ?? '';
        });
      }
    });
    //print(args);
    //print('Email2: ${args}');

    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 220,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.blue,
                        Colors.lightBlue,
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 16,
                  right: 16,
                  top: 100,
                  child: GestureDetector(
                    onTap: () {
                      // Implement the image change logic here
                    },
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 70.0,
                          backgroundImage: AssetImage('assets/image1.png'),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              icon: Icon(Icons.camera_alt),
                              onPressed: () {
                                // Implement the image change logic here
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      'Name',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      _name,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Email',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      _email,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Profession',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      _profession,
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Skill',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      _skill,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
