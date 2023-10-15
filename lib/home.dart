import 'package:flutter/material.dart';
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
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
                // Handle the action for "Continue as Client"
                Navigator.pushNamed(context, 'login', arguments: 'client');
              },
              style: ElevatedButton.styleFrom(
                fixedSize: Size(350, 60),
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
                _showRoleSelectionDialog(context);
              },
              style: ElevatedButton.styleFrom(
                fixedSize: Size(250, 30), // Increase the height for the big button
                backgroundColor: Color(0xFF214062),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: Text(
                'Are you an Expert or Admin?', // Update the text
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10.0, // Increase the font size
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showRoleSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose Your Role'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text('Expert'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, 'login',arguments: 'expertise',);
                },
              ),
              ListTile(
                title: Text('Admin'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, 'admin');
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
