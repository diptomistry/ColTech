import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:uni_excellence/profile.dart';
import 'package:uni_excellence/reset_pass.dart';
import 'package:uni_excellence/welcome.dart';
import 'package:uni_excellence/register.dart';

import 'login.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyLogin(),
    routes: {
      'register': (context) => MyRegister(),
      'login': (context) => MyLogin(),
      'welcome': (context) => Welcome(),
      'reset': (context) => ResetPassword(),
      'MyProfile': (context) => FutureBuilder<User?>(
        future: FirebaseAuth.instance.authStateChanges().first,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Return a loading indicator or splash screen while waiting for user data
            return CircularProgressIndicator();
          } else {
            User? user = snapshot.data;
            String? email = user?.email;
            return Profile(user: user, email: email);
          }
        },
      ),
    },
  ));
}



