import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  //void initState(){    ***program to disable keyboard***
  //  super.initState() ;
  //  FocusScope.of(context).requestFocus(FocusNode());
  //}
  @override
  Widget build(BuildContext context) {

    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      
      body:SafeArea (
        
        child: Stack(

          fit:StackFit.loose,

          children:<Widget>[

            Container(
             // height: 685,
             // width: 415,
              height: _size.height,
              width:_size.width,

              color:Colors.white,
              padding: EdgeInsets.fromLTRB( 0, 12, 0, 0),
              child: Text('HeLLO \nThere.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 50.0,
                  fontFamily: 'OtomanopeeOne',
                  color: Colors.red ,

                ),
              ),


            ),

            Center(
            //  child: Positioned( never use positioned with center ,row , column
              //  top:50.0,
                child: Container(

                    padding: EdgeInsets.all(100),
                    //    height:850.0,
                    //   width:850.0,
                    // Padding(padding: EdgeInsets.fromLTRB( 10.0, 20.0, 30.0, 0.0),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration (
                        image: DecorationImage (
                          image: AssetImage('assets/eagle1.png'),
                          fit: BoxFit.contain ,
                        )
                    )
                ),
             // ),
            ) ,

//***to get rid of render flow error using singlechildscrollview***

            SingleChildScrollView(

              child: Column(
                //  padding: EdgeInsets.fromLTRB( 50, 50, 50, 50),
                  mainAxisAlignment: MainAxisAlignment.center ,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

SizedBox(height:50),
                    Container(
                        padding: EdgeInsets.only( top:350 ),
                        child: RaisedButton (
                          shape: RoundedRectangleBorder (borderRadius: BorderRadius.circular(20.0) ),
                          color:Colors.black  ,
                          child:Text('LOGIN'),
                          textColor:Colors.white ,
                          padding: EdgeInsets.symmetric(vertical: 13.0,horizontal: 110.0),
                          onPressed: (){
                            Navigator.pushNamed(context , 'Login');
                          },
                        )
                    ),
SizedBox(height: 60),
                    Container(
                      //   padding: EdgeInsets.fromLTRB( 70, 350, 50, 50),
                        child: RaisedButton (
                          shape: RoundedRectangleBorder (borderRadius: BorderRadius.circular(20.0) ),
                          color:Colors.black,
                          child: Text('login with Facebook'),
                          textColor: Colors.white ,
                          padding: EdgeInsets.symmetric(vertical: 13.0,horizontal: 110.0),
                          onPressed: (){
                            Navigator.pushNamed(context , 'login_Facebook');
                          },
                        )

                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center ,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: Text('if new click here to get',
                            style:  TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red,

                            ),

                          ),

                        ),
                        Container(
                          child: FlatButton(
                            onPressed : (){
                              Navigator.pushNamed(context , 'Register');
                            },
                            child: Text('Register',
                              style:  TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black ,
                                backgroundColor: Colors.white,

                              ),

                            ),
                          ),
                        ),
                      ],

                    ),

                  ]
              ),
            )  ,


          ],
        ),
      ),

    );
  }
}