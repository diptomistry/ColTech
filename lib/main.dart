import 'package:coltech/firebase_options.dart';
import 'package:coltech/register.dart';
import 'package:coltech/registerAs.dart';

import 'package:coltech/registerAsExpertise.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:coltech/userprofile.dart';
import 'package:coltech/reset_pass.dart';
import 'package:coltech/welcome.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';


import 'adminLogin.dart';
import 'expertprofile.dart';
import 'home.dart';
import 'login.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomeScreen(),
    routes: {
      'homescreen': (context) => HomeScreen(),
      'registerUser': (context) => MyRegister(),
      'login': (context) => MyLogin(),
      'welcome': (context) => Welcome(),
      'registeras':(context) => RegisterAs(),
      'reset': (context) => ResetPassword(),
      'admin': (context) => AdminLogin(),
      'registerasExpert':(context) => MyregisterEx(),
      'userprofile': (context) => UserProfile(),
      'expertprofile': (context) => ExpertProfile(),

    },
  ));
}



