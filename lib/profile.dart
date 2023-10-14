import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  final User? user;
  final String? email;

  Profile({required this.user, required this.email});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _universityController = TextEditingController();
  TextEditingController _bioController = TextEditingController();

  String _currentImage = 'assets/image1.png'; // Initial profile image
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();

    // Set initial values for text fields
    _nameController.text = 'John Doe';
    _emailController.text = 'johndoe@example.com';
    _universityController.text = 'XYZ University';
    _bioController.text =
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit.';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.done : Icons.edit),
            onPressed: () {
              setState(() {
                _isEditing = !_isEditing;
              });
            },
          ),
        ],
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
                      setState(() {
                        _currentImage = _currentImage == 'assets/image1.png'
                            ? 'assets/image2.png'
                            : 'assets/image1.png';
                      });
                    },
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 70.0,
                          backgroundImage: AssetImage(_currentImage),
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
                                setState(() {
                                  _currentImage =
                                      _currentImage == 'assets/image1.png'
                                          ? 'assets/image2.png'
                                          : 'assets/image1.png';
                                });
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    _isEditing
                        ? TextField(
                            controller: _nameController,
                            decoration:
                                InputDecoration(hintText: 'Enter your name'),
                          )
                        : Text(
                            _nameController.text,
                            style: TextStyle(fontSize: 16),
                          ),
                    SizedBox(height: 20),
                    Text(
                      'Email',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    _isEditing
                        ? TextField(
                            controller: _emailController,
                            decoration:
                                InputDecoration(hintText: 'Enter your email'),
                          )
                        : Text(
                            _emailController.text,
                            style: TextStyle(fontSize: 16),
                          ),
                    SizedBox(height: 20),
                    Text(
                      'University',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    _isEditing
                        ? TextField(
                            controller: _universityController,
                            decoration: InputDecoration(
                                hintText: 'Enter your university'),
                          )
                        : Text(
                            _universityController.text,
                            style: TextStyle(fontSize: 16),
                          ),
                    SizedBox(height: 20),
                    Text(
                      'Bio',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    _isEditing
                        ? TextField(
                            controller: _bioController,
                            maxLines: 3,
                            decoration:
                                InputDecoration(hintText: 'Enter your bio'),
                          )
                        : Text(
                            _bioController.text,
                            style: TextStyle(fontSize: 16),
                          ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            _isEditing
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ElevatedButton(
                      onPressed: () {
                        // Save the changes here (update your backend or storage)
                        setState(() {
                          _isEditing = false;
                        });
                        // Show a snackbar or a toast indicating the changes have been saved.
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Profile updated successfully!')),
                        );
                      },
                      child: Text('Update'),
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
