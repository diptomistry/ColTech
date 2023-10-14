import 'package:coltech/firebase_options.dart';
import 'package:coltech/users/userHomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:coltech/profile.dart';
import 'package:coltech/reset_pass.dart';
import 'package:coltech/welcome.dart';
import 'package:coltech/register.dart';

import 'HomeNavigationBaruser.dart';
import 'login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: UserNav(),
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
