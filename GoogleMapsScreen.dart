import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/Divider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/rxdart.dart';

import 'package:geoflutterfire/geoflutterfire.dart';

class GoogleMapsScreen extends StatefulWidget {
  static const String idscreen ="GoogleMapsScreen";

  @override
  _GoogleMapsScreenState createState() => _GoogleMapsScreenState();
}

class _GoogleMapsScreenState extends State<GoogleMapsScreen> {


  Completer<GoogleMapController> _controllerGoogleMap = Completer();
GoogleMapController newGoogleMapController;

GlobalKey<ScaffoldState> scaffoldKey=new GlobalKey<ScaffoldState>();

Position currentPosition;
var geoLocator =Geolocator ();
double bottomPaddingOfMap =0;

//function to get live latitude and longitude of live location
void locatePosition() async
{
  Position position= await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
currentPosition =position ;
LatLng latLatposition=LatLng( position.latitude   , position.longitude);
CameraPosition cameraPosition =new CameraPosition(target:latLatposition ,zoom: 14);
newGoogleMapController.animateCamera( CameraUpdate.newCameraPosition( cameraPosition ) );

//  Firestore firestore = Firestore.instance;
  Geoflutterfire geo = Geoflutterfire();

}

  Future<DocumentReference> _addGeoPoint() async {
    var pos = await position.getposition();
    GeoFirePoint point = geo.point(latitude: pos.latitude, longitude: pos.longitude);
    return firestore.collection('locations').add({
      'position': point.data,
      'name': 'Yay I can be queried!'
    });
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (
        title:Text ("Google Maps"),
      ),
      body: Stack(
        children: [
          GoogleMap (
padding: EdgeInsets.only(bottom: bottomPaddingOfMap ),
            mapType: MapType.normal ,
            myLocationButtonEnabled: true ,
            initialCameraPosition: _kGooglePlex ,
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,

            onMapCreated: (GoogleMapController controller)
            {

                 _controllerGoogleMap.complete(controller);
                  newGoogleMapController=controller;
                  setState((){
                    bottomPaddingOfMap =300.0;
                  });
                 locatePosition() ;


                  },

          ),

          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: Container (
              height: 320.0,
              decoration: BoxDecoration (
                color: Colors.white ,
                borderRadius: BorderRadius.only(topLeft: Radius.circular( 18.0),topRight: Radius.circular( 18.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black ,
                    blurRadius: 16.0,
                    spreadRadius: 0.5,
                    offset: Offset (0.7,0.7),
                  ) ,
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0) ,
                child: Column (
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height:6.0),
                    Text( "Hi There.",style: TextStyle(fontSize: 12.0)),
                    Text( "Where To?",style: TextStyle(fontSize: 20.0),),
                    SizedBox(height:20.0),
                    Container(

                      decoration: BoxDecoration (
                        color: Colors.white ,
                        borderRadius: BorderRadius.circular(5.0) ,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black54 ,
                            blurRadius: 6.0,
                            spreadRadius: 0.5,
                            offset: Offset (0.7,0.7),
                          ) ,
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Icon( Icons.search ,color: Colors.blueAccent , ),
                            SizedBox(width: 10.0),
                            Text("Search Drop Off"),

                          ],
                        ),
                      ),

                    ) ,
                    SizedBox(height: 24.0),
                    Row(
                      children: [
                        Icon(Icons.home ,color: Colors.grey,),
                        SizedBox(width: 12.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start ,
                          children: [
                            Text("Add Home."),
                            SizedBox(height: 4.0),
                            Text("Your Home Address",style: TextStyle (color: Colors.black54,fontSize: 12.0),),

                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    DividerWidget() ,
                    SizedBox(height: 16.0) ,

                    Row(
                      children: [
                        Icon(Icons.work ,color: Colors.grey,),
                        SizedBox(width: 12.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start ,
                          children: [
                            Text("Add Work."),
                            SizedBox(height: 4.0),
                            Text("Your Office Address",style: TextStyle (color: Colors.black54,fontSize: 12.0),),

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
      )


    ) ;
  }

}
