import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController _emailController = TextEditingController();
  bool _isResetting = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
/*
  void _resetPassword() {
    // Implement your password reset logic here.
    // For the sake of this example, let's just print the email and simulate the reset process.
    String email = _emailController.text;
    print("Reset password for email: $email");

    // Simulate the password reset process with a delay of 2 seconds.
    setState(() {
      _isResetting = true;
    });
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isResetting = false;
        // Show a success dialog or navigate to a success page.
        // You can also show an error dialog/page if the reset fails.
      });
    });
  }

 */
  Future _resetPassword() async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text.trim());
      showDialog(context: context, builder: (context){
        return AlertDialog(
          content: Text('Password reset link sent.Check your email.'),
        );
      },
      );
    } on FirebaseAuthException catch(e) {
      print(e);
      showDialog(context: context, builder: (context) {
        return AlertDialog(
          content: Text(e.message.toString()),
        );
      },
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'UniExcellence',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFF214062),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                'assets/reset.png', // Replace this with your app logo
                height: 200,
                width: 200,
              ),
              SizedBox(height: 16),
              Text(
                'Enter your email and we will send you a password reset link',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[700],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isResetting ? null : _resetPassword,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF214062),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: _isResetting
                    ? SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
                    : Text(
                  'Send',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,

                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
