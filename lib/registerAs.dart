import 'package:flutter/material.dart';

class RegisterAs extends StatefulWidget {
  @override
  _RegisterAsState createState() => _RegisterAsState();
}

class _RegisterAsState extends State<RegisterAs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF214062),
        title: Text('User Roles'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'registerUser');
              },
              style: ElevatedButton.styleFrom(
                fixedSize:Size(350, 30),
                backgroundColor: Color(0xFF214062), // Background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0), // Rounded corners
                ),
                //padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0), // Padding
              ),
              child: Text(
                'Register as Client',
                style: TextStyle(
                  color: Colors.white, // Text color
                  fontSize: 16.0, // Text size
                ),
              ),
            ),
            SizedBox(height: 30.0), // Space between buttons
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'registerasExpert');
              },
              style: ElevatedButton.styleFrom(
                fixedSize:Size(350, 30),
                backgroundColor: Color(0xFF214062), // Background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0), // Rounded corners
                ),
                //padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0), // Padding
              ),
              child: Text(
                'Register as Expertise',
                style: TextStyle(
                  color: Colors.white, // Text color
                  fontSize: 16.0, // Text size
                ),
              ),
            ),
            SizedBox(height: 30.0), // Space between buttons
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'admin');
              },
              style: ElevatedButton.styleFrom(
                fixedSize:Size(350, 30),
                backgroundColor: Color(0xFF214062), // Background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0), // Rounded corners
                ),
                //padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0), // Padding
              ),
              child: Text(
                'Login as Admin',
                style: TextStyle(
                  color: Colors.white, // Text color
                  fontSize: 16.0, // Text size
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
