import 'package:flutter/material.dart';
import 'package:flutter_app/GoogleMapsScreen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:page_transition/page_transition.dart';

import '../Home.dart';
//import 'package:test_app/Tabs/Tabs.dart';
//import 'Package:test_app/Tabs/sponsorAchild.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();

}

class _LoginState extends State<Login> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email, _password;
  bool _isUserEmailVerified;
  login() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        UserCredential result = await _auth.signInWithEmailAndPassword(
            email: _email, password: _password);
        User user = result.user;
        if (user.emailVerified==true) {
          setState(() {
            _isUserEmailVerified = user.emailVerified;
          });
        }

        user == null && _isUserEmailVerified == false ?
        CircularProgressIndicator() :
        Navigator.push(context, PageTransition(child: GoogleMapsScreen()));
        // ignore: missing_return
      }
      catch (e){
        print('error');
        // showError(String errorMessage)
        // {
        //   showDialog(context: context, builder: (BuildContext context)
        //   {
        //     return AlertDialog(
        //       title: Text('Error'),
        //       content: Text(errorMessage),
        //       actions:
        //       <Widget>[
        //         // ignore: deprecated_member_use
        //         FlatButton(onPressed:(){ Navigator.of(context).pop();}, child: Text('ok'))
        //       ],
        //     );
        //   }
        //   );
        // }
      }
    }
  }

  // checkAuthentication() async {
  //   _auth.authStateChanges().listen((user) {
  //     if (user != null) {
  //       Navigator.push(
  //           context, MaterialPageRoute(builder: (context) => Tabs()));
  //     }
  //   });
  //   // @override
  //   // void initState() {
  //   //   super.initState();
  //   //   this.checkAuthentication();
  //   // }
  // }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        //alignment: Alignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              height: _size.height,
              width: _size.width,
              color: Colors.white,
              child: Stack(
                  fit: StackFit.loose,
                  overflow: Overflow.visible,
                  children: <Widget>[


                    Container(
                      child: SafeArea(
                        child: FlatButton.icon(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            FontAwesomeIcons.arrowLeft,

                            //color: ColorFilter.mode(Colors.black.withOpacity(0.3),BlendMode.dstATop)
                          ),
                          label: Text(''),
                        ),
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty || !value.contains('@')) {
                                    return 'invalid email';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  return _email = value;
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Enter email',
                                  labelText: 'Email',
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty || value.length < 8) {
                                    return 'invalid password';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  return _password = value;
                                },
                                obscureText: true,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Enter Password',
                                  labelText: 'Password',
                                ),
                              ),
                            ),
                            // ignore: deprecated_member_use
                            RaisedButton(
                                color: Colors.green,
                                padding: EdgeInsets.only(left: 100, right: 100),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40)),
                                textColor: Colors.white,
                                child: AnimatedContainer(
                                  color: Colors.green,
                                  duration: Duration(milliseconds: 900),
                                  child: Text(' LOGIN '),
                                ),
                                onPressed: () async {
                                  login();


                                  print('$_email');
                                }),
                          ]),
                    ),
                  ]),
            ),
          ]),
    );
  }
}