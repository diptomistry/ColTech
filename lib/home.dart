import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF214062),
        title: Text('Welcome to Coltech App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'login', arguments: 'client',);
              },
              style: ElevatedButton.styleFrom(
                fixedSize: Size(350, 30),
                backgroundColor: Color(0xFF214062),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: Text(
                'Continue as Client',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),
            SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'login',arguments: 'expertise',);
              },
              style: ElevatedButton.styleFrom(
                fixedSize: Size(350, 30),
                backgroundColor: Color(0xFF214062),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: Text(
                'Continue as Expertise',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),
            SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'login',arguments: 'admin',);
              },
              style: ElevatedButton.styleFrom(
                fixedSize: Size(350, 30),
                backgroundColor: Color(0xFF214062),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: Text(
                'Continue as Admin',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
