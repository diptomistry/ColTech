import 'package:flutter/material.dart';

class AdminLogin extends StatefulWidget {
  @override
  _AdminLoginState createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final List<String> validEmails = ['diptomistry50@example.com', 'hrasel2002@example.com', 'mushiurmukul1@example.com'];
  final List<String> validPasswords = ['diptomistry', 'raselhossen', 'mushiurmukul'];

  String loginError = '';

  void _login() {
    String email = emailController.text;
    String password = passwordController.text;

    if (validEmails.contains(email) && validPasswords[validEmails.indexOf(email)] == password) {
      // Successful login, you can navigate to the admin panel or perform other actions here.
      setState(() {
        loginError = '';
      });
    } else {
      setState(() {
        loginError = 'Invalid email or password';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Login'),
        backgroundColor: Color(0xFF214062),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed:(){},
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0XFF214062), // Customize the button color
                  foregroundColor: Colors.white, // Customize the text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                loginError,
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
