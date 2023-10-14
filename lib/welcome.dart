import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'UniExcellence',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushNamed(context, 'login');
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/welcome.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.58),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start, // Align rows to the top
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to My Profile screen
                          Navigator.pushNamed(context, 'MyProfile');
                        },
                        child: Text(
                          'My Profile',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all<Size>(
                            Size(double.infinity, 60.0),
                          ),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(color: Colors.black, width: 2.0),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent), // Change button color
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 36.0), // Add some spacing between the rows
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to Dashboard screen
                        },
                        child: Text(
                          'Dashboard',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all<Size>(
                            Size(double.infinity, 60.0),
                          ),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(color: Colors.black, width: 2.0),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.black54), // Change button color
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
