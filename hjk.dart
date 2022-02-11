//FILE FOR FACEBOOK LOGOUT FUNCTION


import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter/cupertino.dart';


import 'Home.dart';
import 'main.dart';
class hjk extends StatefulWidget {
  @override
  _hjkState createState() => _hjkState();
}

class _hjkState extends State<hjk> {
  @override
  Widget build(BuildContext context) {
    FirebaseAuth _auth = FirebaseAuth.instance;
    return Scaffold(
      appBar: AppBar(),
      body:

      Center (
        child: Container(
//   padding: EdgeInsets.fromLTRB( 70, 350, 50, 50),
            child: RaisedButton (
              shape: RoundedRectangleBorder (borderRadius: BorderRadius.circular(20.0) ),
              color:Colors.black,
              child: Text('logout from Facebook'),
              textColor: Colors.white ,
              padding: EdgeInsets.symmetric(vertical: 13.0,horizontal: 110.0),
              onPressed: (){
                _auth.signOut();
                Navigator.pushNamed(context , 'Home');

              },
            )

        ),
      ),



    ) ;
  }
}
