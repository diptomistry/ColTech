import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coltech/profile.dart';
import 'package:coltech/welcome.dart';

class MyRegister extends StatefulWidget {
  @override
  _MyRegisterState createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _universityController = TextEditingController();
  TextEditingController _cgpaController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _universityController.dispose();
    _cgpaController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  var email, password;
  registration() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    try {
      final User? user = (await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;

      if (user != null) {
        // Send email verification
        await user.sendEmailVerification();

        // Navigate to email verification page

      }
    } catch (e) {
      print('Registration failed: $e');
    }
  }


  bool validateEmail(String email) {
    final RegExp emailRegex =
    RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$', caseSensitive: false);
    return emailRegex.hasMatch(email);
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/register.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0XFF0d65f8),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushNamed(context, 'login');
            },
          ),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.25,
                  left: 35,
                  right: 35,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          roundedTextField(
                            controller: _fullNameController,
                            hintText: 'Full Name',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your full name';
                              }
                              return null;
                            },
                          ),
                          roundedTextField(
                            controller: _emailController,
                            hintText: 'Email',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your email';
                              }
                              if (!validateEmail(value)) {
                                return 'Invalid email format';
                              }
                              email = value;
                              return null;
                            },
                          ),
                          roundedTextField(
                            controller: _universityController,
                            hintText: 'University',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your university name';
                              }
                              return null;
                            },
                          ),
                          roundedTextField(
                            controller: _cgpaController,
                            hintText: 'CGPA (optional)',
                          ),
                          roundedTextField(
                            controller: _passwordController,
                            hintText: 'Password',
                            obscureText: true,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a password';
                              }
                              // You can add password validation logic here if needed
                              password = value;
                              return null;
                            },
                          ),
                          roundedTextField(
                            controller: _confirmPasswordController,
                            hintText: 'Confirm Password',
                            obscureText: true,
                            validator: (value) {
                              if (value != _passwordController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16.0),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      registration();
                                      // Perform registration logic
                                      if (password.length >= 6) {
                                       // Navigator.pushNamed(context, 'welcome');
                                        Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) => EmailVerificationPage(),
                                          ),
                                        );
                                      }
                                    }
                                  },
                                  child: Text('Register'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0XFF0d65f8),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget roundedTextField({
    required TextEditingController controller,
    required String hintText,
    bool obscureText = false,
    FormFieldValidator<String>? validator,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
          errorText: controller.text.isNotEmpty && validator != null
              ? validator(controller.text)
              : null,
        ),
        validator: validator,
      ),
    );
  }

}

class EmailVerificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Email Verification'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Email Verification',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'A verification email has been sent to your email address. Please check your inbox and follow the instructions to verify your email.',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Navigate back to the login page
                Navigator.pushNamed(context, 'welcome');
              },
              child: Text('Go to Login'),
            ),
          ],
        ),
      ),
    );
  }
}




