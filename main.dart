import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/GoogleMapsScreen.dart';
import 'package:flutter_app/authentication/Register.dart';
import 'package:flutter_app/authentication/login.dart';
import 'package:flutter_app/Home.dart';
import 'package:flutter_app/login_Facebook.dart';

import 'GoogleMapsScreen.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized() ;
  await Firebase.initializeApp();
  runApp(
      MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Home(),
      //    initialRoute: GoogleMapsScreen.idscreen,
          routes: {
            'Home': (context) => Home(),
            'Login': (context) => Login(),
            'Register': (context) => Register(),
            'login_Facebook': (context) => LoginWithFacebook(),


          }
      )
  );
}



