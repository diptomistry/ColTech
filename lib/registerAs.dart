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
          backgroundColor: Color(0XFF0d65f8),
          title: Text('User Roles'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Implement registration logic for clients
                  print('Registered as Client');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0d65f8), // Background color
                ),
                child: Text('Register as Client',

                ),

              ),
              ElevatedButton(
                onPressed: () {
                  // Implement login logic for expertise
                  print('Registered in as Expertise');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0d65f8), // Background color
                ),
                child: Text(
                    'Register as Expertise',

                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Implement login logic for admin
                  print('Registered in as Admin');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0d65f8), // Background color
                ),
                child: Text(
                    'Register as Admin',
                  ),
              ),
            ],
          ),
        ),
      );

  }
}
