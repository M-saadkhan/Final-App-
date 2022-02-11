import 'dart:io';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:test_app/lib/Tabs/homedrawer.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String imagelink;
  FirebaseAuth _auth = FirebaseAuth.instance;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  TextEditingController _namecontroller = TextEditingController();
  TextEditingController _lastnamecontroller = TextEditingController();
  TextEditingController _phonenumbercontroller = TextEditingController();

  register(String email, String password) async {
    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();
      try {
        UserCredential result = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        User user = result.user;

        return user;
      } catch (e) {
        print(e.toString());
        print('error while registering');
      }
    }
  }

  DatabaseReference _databaseReference =
  FirebaseDatabase.instance.reference().child('DataBase');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int i=0;

  // ignore: non_constant_identifier_names
  String Choose_value = '';
  // ignore: non_constant_identifier_names
  List ListItem = ["A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"];
  File _image;

  Future getimage(ImageSource source) async {
    final image = await ImagePicker().getImage(
      source: source,
    );
    setState(() {
      _image = File(image.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          title: Text(
            'Register',
            style: TextStyle(
              fontSize: 40,
            ),
          ),
          backgroundColor: Colors.green,
          centerTitle: true,
        ),
      ),
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
                  clipBehavior: Clip.none,
                  fit: StackFit.loose,
                  children: <Widget>[

                    SafeArea(
                      child: SingleChildScrollView(
                        child: Form(
                          key: _formkey,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Center(
                                  child: Stack(children: [
                                    _image != null
                                        ? CircleAvatar(
                                      radius: 80,
                                      backgroundImage:
                                      FileImage(File(_image.path)),
                                    )
                                        : CircleAvatar(
                                      radius: 80,
                                      backgroundColor: Colors.green,
                                      child: ClipOval(
                                        child: Icon(
                                          Icons.person,
                                          size: 100,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                        left: 100,
                                        bottom: 0,
                                        child:InkWell(
                                          onTap: (){
                                            showModalBottomSheet(context: context, builder: (builder)=>bottomSheet());                                        },
                                          child: Icon(

                                            Icons.add_a_photo,
                                            color: Colors.teal,
                                            size: 29,
                                          ),






                                        )
                                    ),
                                  ]),
                                ),

                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: TextFormField(
                                    controller: _namecontroller,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'invalid';
                                      } else
                                        return null;
                                    },
                                    onSaved: (value) {},
                                    decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                      hintText: 'Enter',
                                      labelText: 'First Name',
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: TextFormField(
                                    controller: _lastnamecontroller,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'invalid';
                                      } else
                                        return null;
                                    },
                                    onSaved: (value) {},
                                    decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                      hintText: 'Enter',
                                      labelText: 'Last Name',
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: TextFormField(
                                    controller: _emailcontroller,
                                    validator: (value) {
                                      if (value.isEmpty ||
                                          !value.contains('@')) {
                                        return 'invalid';
                                      } else
                                        return null;
                                    },
                                    onSaved: (value) {},
                                    decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                      hintText: 'Enter',
                                      labelText: 'Email',
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: TextFormField(
                                    obscureText: true,
                                    controller: _passwordcontroller,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'invalid';
                                      } else
                                        return null;
                                    },
                                    onSaved: (value) {},
                                    decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                      hintText: 'Enter',
                                      labelText: 'Password',
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: TextFormField(
                                    obscureText: true,
                                    validator: (value) {
                                      if (value.isEmpty ||
                                          value != _passwordcontroller.text) {
                                        return 'invalid';
                                      } else
                                        return null;
                                    },
                                    onSaved: (value) {},
                                    decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                      hintText: 'Re-enter',
                                      labelText: 'Re-enter',
                                    ),
                                  ),
                                ),
                                //                         Row(children: [
                                //                             // Container(
                                //                             //
                                //                             // padding: const EdgeInsets.only(left: 10,top:10),
                                //                             //
                                //                             // child:SizedBox(
                                //                             //   child:Text('Date of birth',
                                //                             //   style: TextStyle(fontSize: 15),
                                //                             //   ),
                                //                             //   height: 20,
                                //                             // ),
                                //                             // ),
                                //                             // ]
                                //                             // ),
                                //                             //
                                //                             // Row(
                                //                             //
                                //                             //     children: [
                                //                             //       Container(
                                //                             //
                                //                             //         padding: const EdgeInsets.only(bottom: 10),
                                //                             //
                                //                             //         child: FlatButton(
                                //                             //
                                //                             //           onPressed: (){
                                //                             //             _selectDate(context);
                                //                             //             },
                                //                             //           child: Text("${selectedDate.toUtc()}".split(' ')[0],
                                //                             //             style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                                //                             //           ),
                                //                             //         ),
                                //                             //       ),
                                //                             //     ]
                                //                             // ),
                                //
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Row(
                                    children: [
                                      Text('Blood Group'),
                                      DropdownButton(
                                        hint: Text(
                                          '    $Choose_value',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        icon: Icon(
                                          Icons.arrow_downward,
                                        ),
                                        onChanged: (newvalue) {
                                          setState(() {
                                            //  Text('  click here ');
                                            Choose_value = newvalue;
                                          });
                                        },
                                        items: ListItem.map((valueitem) {
                                          return DropdownMenuItem(
                                              value: valueitem,
                                              child: Text(valueitem));
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: TextFormField(
                                    controller: _phonenumbercontroller,
                                    validator: (value) {
                                      if (value.isEmpty || value.length < 11) {
                                        return 'invalid';
                                      } else
                                        return null;
                                    },
                                    decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                      hintText: 'Enter',
                                      labelText: 'Phone number',
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),

                                Container(
                                    padding: EdgeInsets.all(10),
                                    child: RaisedButton(
                                        color: Colors.green,
                                        splashColor: Colors.lightGreen,
                                        padding: EdgeInsets.only(
                                            left: 100, right: 100),
                                        child: Text('Register'),
                                        onPressed: () async {
                                          print('HELLOO');
                                          register(_emailcontroller.text,
                                              _passwordcontroller.text);

                                          Navigator.pushNamed(context, 'Login');
                                          uploadfile().whenComplete(() {
                                            saveInfo();
                                          });



                                        })),
                              ]),
                        ),
                      ),
                    ),
                  ]),
            ),
          ]),
    );
  }
  Widget bottomSheet()
  {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin:  EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
          children:<Widget>[
            Text("Choose Profile Photo",
              style: TextStyle(
                fontSize: 20,
                color: Colors.green,
              ),

            ),
            SizedBox(
              height:20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton.icon(onPressed: (){
                  getimage(ImageSource.camera);

                },
                    icon: Icon(Icons.camera_alt,color: Colors.green), label: Text('Camera',style: TextStyle(
                        color: Colors.green),)),
                FlatButton.icon(onPressed: (){                                              getimage(ImageSource.gallery);
                },
                    icon: Icon(Icons.image,color: Colors.green,), label: Text('Gallery',style: TextStyle(
                        color: Colors.green
                    ),)),
              ],
            )

          ]
      ),

    );
  }

  Future uploadfile() async {

    final User user = _auth.currentUser;
    final uid = user.uid;
    Reference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('uploads/$uid');
    UploadTask uploadTask = firebaseStorageRef.putFile(_image);
    while(uploadTask==null)
    {
      CircularProgressIndicator();
    }
    TaskSnapshot taskSnapshot = await uploadTask;
    taskSnapshot.ref.getDownloadURL().then((value) {

      setState(() {
        imagelink=value ;
      });

      print('URL ISSSSSS $imagelink');
    });


  }

  void saveInfo()  {

    final User user = _auth.currentUser;
    final uid = user.uid;
    String fname = _namecontroller.text;
    String lname = _lastnamecontroller.text;
    String email = _emailcontroller.text;
    String phoneno = _phonenumbercontroller.text;
    String password = _passwordcontroller.text;
    print('url====> $imagelink');
    Map<String, String> Info = {
      'Email': email,
      'Password': password,
      'First name': fname,
      'last name': lname,
      'phone number': phoneno,
      'blood type': Choose_value,
      'Image url':imagelink
    };
    _databaseReference.child(uid).set(Info);

  }
}