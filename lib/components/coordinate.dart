import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
 import 'dart:async';
 
 
import 'package:device_imei/device_imei.dart';
 
// import 'package:get_location_addres/get_imei.dart';
import 'package:permission_handler/permission_handler.dart';
 
 

class Coordinate1 extends StatefulWidget {

  

  const Coordinate1({super.key});

  @override
  State<Coordinate1> createState() => _Coordinate1State();
}

class _Coordinate1State extends State<Coordinate1> {


@override
  void initState() {
  
    super.initState();
 
   _gethasil();
    

  
  // Camera2();
    
   //tag2
   //isloading?_gethasil():Center(child: CircularProgressIndicator(),);
  }

//Google maps
 

 // String _platformVersion = 'Unknown';

  

  String? deviceImei;
  String? type;
  String message = "Please allow permission request!";
  DeviceInfo? deviceInfo;
  bool getPermission = false;


    double latitudeawal=0;
    double longitudeawal=0;
  


 _gethasil() async{
   Position position = await _getGeoLocationPosition();
              location ='Lat: ${position.latitude} , Long: ${position.longitude}';
             // isloading?GetAddressFromLatLong(position):const Center(child: CircularProgressIndicator(),);   
         
    setState(() {
          latitudeawal=position.latitude;
          longitudeawal=position.longitude;
    });     

    
    
          GetAddressFromLatLong(position);

 }

  
//  final snakbar=SnackBar(content:Text('Detail '+latitudeawal.toString()+"  ,  "+longitudeawal.toString()));
//      ScaffoldMessenger.of(context).showSnackBar(snakbar);


  
   
  String location ='Null, Press Button';
  String Address = 'search';
  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }




// You can also directly ask permission about its status.
if (await Permission.location.isRestricted) {
  // The OS restricts access, for example, because of parental controls.
}

//additionaly phone permisssion
 var status = await Permission.phone.status;

  if (status.isDenied) {
   await Permission.phone.request().isGranted;
  } 
 


    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> GetAddressFromLatLong(Position position)async {
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    Address = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    setState(()  {
    });
  }


  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}