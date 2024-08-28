import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
 
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
 import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:device_imei/device_imei.dart';
 
// import 'package:get_location_addres/get_imei.dart';
import 'package:permission_handler/permission_handler.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:flutter_share/flutter_share.dart';
//import 'package:documents_picker/documents_picker.dart';
import 'package:esys_flutter_share_plus/esys_flutter_share_plus.dart';
import 'dart:math'; 
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';
 
 
    import 'package:http/http.dart' as http;
     import 'dart:convert';
 
  
 //awal
 
  
class Homepage2 extends StatefulWidget {
  final double? latx;
  final double? longx;
  final String? gambar; 
  final String? imeino; 
 
  

  const Homepage2({Key? key,required this.latx,required this.longx,required this.gambar,required this.imeino}) : super(key: key);
  @override
  _HomepageState2 createState() => _HomepageState2(latx: latx,longx: longx,gambar: gambar,imeino:imeino);
}
class _HomepageState2 extends State<Homepage2> {
     
  bool isloading = false;

  final double? latx;
  final double? longx;
  final String? gambar; 
  final String? imeino; 
 
  
   _HomepageState2({required this.latx,required this.longx,required this.gambar,required this.imeino });
   
//t0

   //late Position _currentPosition=Position(longitude: 0, latitude: 0, timestamp: DateTime(1972), accuracy: 0, altitude: 0, altitudeAccuracy: 0, heading: 0, headingAccuracy: 0, speed: 0, speedAccuracy: 0);
   late Position _currentPosition;
   late Position _currentPosition2;

   //late final String apiEndpoint;
   


  @override
  void initState() {
  
    super.initState();
 
   //_getImei();
   GetAddressFromLatLong(latx!, longx!);
    
  
  }

 
  

 

  String? deviceImei;
  String? type;
  String message = "Please allow permission request!";
  DeviceInfo? deviceInfo;
  bool getPermission = false;
  final Uri _url = Uri.parse('https://flutter.dev'); 
   
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  
  
 

  

 
 

 
     
 
 

      
 
 
 

    
 
      

 

 


  String location ='Null, Press Button';
  String Address = 'search';
 
 
 

 Future<bool> ShareAction2() async {
     _shareImageFromUrl(imeino!,gambar!);
    await new Future.delayed(const Duration(seconds: 2));
    return true;
  }
    

  Future<void> GetAddressFromLatLong(double latx,double longx) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(latx, longx);
    print(placemarks);
    Placemark place = placemarks[0];
    Address = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    setState(()  {
    });
  }
 

 Future<void> _shareImageFromUrl(String imeino,String gamber) async {
    try {
      var request = await HttpClient().getUrl(Uri.parse(
          'https://irawan.angsoft.info/tests/flutter/map1/images/'+imeino+'/'+gamber));
      var response = await request.close();
      Uint8List bytes = await consolidateHttpClientResponseBytes(response);
      await Share.file('ESYS AMLOG', 'amlog.jpg', bytes, 'image/jpg');
    } catch (e) {
      print('error: $e');
    }
  }

 


  @override
  Widget build(BuildContext context) {

 

  

    return 
    Scaffold(
      //backgroundColor: Colors.transparent,
       appBar: AppBar(
          title: const Text('Parking Spot History',style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.blueAccent,

// actions: [
//             IconButton(onPressed: () {
//               Navigator.push(context, MaterialPageRoute(builder: (context) => History1(),));
//             }, icon: Icon(Icons.access_alarm,size: 30,))
//           ],

        ),
      body:SingleChildScrollView(
      child: 
      
      Container(
        
         height: MediaQuery.of(context).size.height/1.14,
        decoration: BoxDecoration(
       //   color: Colors.amber,
          // image:DecorationImage(
          //   image: AssetImage('assets/images/back2.jpg'),
          //   fit:BoxFit.cover,
          //   ),

        ),
        child:
        Column(
          
          children: [
  

//bikinbox flexible
              
          
                
               Flexible(
                flex:5,
                fit: FlexFit.loose,
                child: Container(
                 padding: EdgeInsets.all(5),
                // height: MediaQuery.of(context).size.height/3,
                  width: double.infinity,
                  margin: EdgeInsets.all(10),
                   decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(10),
          
                   ),
                   child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      
                      Container(

                 
 
                      
                      // child: image==null?Center(child: Text("No Image")):Image.file(File(image!.path)),
                      child:Column(


children: [

 //getAmbildata(),

],

                      )
                     





                      ),
                      //t4
                     
                    ]
                       
                    
                   
                   )

                )
                
                ),

Flexible(
  flex: 2,
  child: 
Container(
 
  margin: EdgeInsets.all(10),
decoration: BoxDecoration(
  color: Colors.black12,
  border: Border.all(style: BorderStyle.solid),
  borderRadius: BorderRadius.circular(7),  
  image: DecorationImage(
    image: AssetImage('assets/images/back5b.jpg'),
    fit: BoxFit.cover,
    
    )
  
),


child: Row(
 
 mainAxisAlignment:MainAxisAlignment.center,
children: [

Column(
  children: [

    IconButton(
      disabledColor: Colors.grey,
      onPressed: () {
       
        
      }, 
      
      icon: Icon(Icons.camera_enhance_rounded),iconSize: 30,),

      
    IconButton(
      onPressed: () {


   
 showDialog(context: context, 
        builder: (context) {
         return  AlertDialog(
            content: Image.network('https://irawan.angsoft.info/tests/flutter/map1/images/'+imeino!+"/"+gambar!),
          );
        },);


       
        
      }, 
      
      icon: Icon(Icons.center_focus_strong),iconSize: 30,),
           
      
    IconButton(
      onPressed: ( ) {
     
  EasyLoading.show(status: "Opening");
             ShareAction2();
       EasyLoading.dismiss();
         // _shareImageFromUrl(imeino!,gambar!);

      }, 
      
      icon: Icon(Icons.share_rounded),iconSize: 30,),
 
  ],
),

//for camera
Column(
  mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.center,
children: [
  Container(
    height: MediaQuery.of(context).size.height/5,
     width:  MediaQuery.of(context).size.height/5,
    clipBehavior: Clip.antiAlias,
    decoration: BoxDecoration(
       color:Colors.blueGrey,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(style: BorderStyle.solid,color: Colors.white,width: 5),
      boxShadow: [
        BoxShadow(
          offset: Offset(3, 3),
          spreadRadius: 1,
          blurRadius: 1

        ),

        BoxShadow(
          offset: Offset(2, 2),
          spreadRadius: 1,
          blurRadius: 1

        ),

      ],

        
    ),
   child:    Image.network(fit: BoxFit.cover,height:100,width: 50,'https://irawan.angsoft.info/tests/flutter/map1/images/'+imeino!+"/"+gambar!),
  )
],
),
 
 
 
],



),

)
)
              

 
            
          ],
        ),
      ),
      ),  
       
    );
  }

//t5

//   Widget getAmbildata(){
// return Container(
//    decoration: BoxDecoration(
//     image: DecorationImage(
//       image: AssetImage('assets/images/back5b.jpg'),
//       fit: BoxFit.cover,
//       )
//    ),

//  child: Column(
// children: [
//  Container(
//    height: MediaQuery.of(context).size.height/3.0,
//   child: 
//  GoogleMap(
           
//           initialCameraPosition: CameraPosition(    
    
//            target:LatLng(latx!, longx!),
//            zoom: 14,
            
//           ),
//         //  myLocationEnabled: true,
              
//           markers: {
//     Marker(
//       markerId: MarkerId("source"),
//       position: LatLng(latx!, longx!) ,
//     ),
//           }
//         )
//  ),



//                 Container(
//                  //   height: MediaQuery.of(context).size.height /6,
//                 padding: EdgeInsets.all(5),
//                 margin: EdgeInsets.all(10),
//                 decoration: BoxDecoration(
                  
//                     color: Colors.amberAccent,
//                  gradient: LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                   colors: [Colors.white,Colors.blueAccent]
//                  ),
//                  borderRadius: BorderRadius.circular(10),
//                  border: Border.all(style: BorderStyle.solid,color: Colors.black12,width: 1,),
//                  boxShadow: [
                  
//                  const  BoxShadow(
//                   offset: Offset(3, 3),
//                   blurRadius: 3,
//                   spreadRadius: 3

//                  ),
//                  const  BoxShadow(
//                   color: Colors.white,
//                   offset: Offset(2, 2),
//                   blurRadius: 2,
//                   spreadRadius: 2

//                  )

//                  ]
                

//                 ),
           
                 
//                   child: Column(
// mainAxisAlignment: MainAxisAlignment.center,
//                       children: [

// //layar1
 
//   Container(
//       // height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
//   height: 80,
//    child: Scrollbar(
//      thumbVisibility: true,
 
//                   thickness: 10, //width of scrollbar
//                   radius: Radius.circular(20), //corner radius of scrollbar
//                   scrollbarOrientation: ScrollbarOrientation.left,

//     child: SingleChildScrollView(
 
//     scrollDirection: Axis.vertical,
//      child:Column(
//   mainAxisAlignment: MainAxisAlignment.center,
//   children: [
 

//             SizedBox(height: 5,),
//             Text("Lat: "+latx!.toString()+ " , Long: "+longx!.toString(),style: TextStyle(color: Colors.black,fontSize: 16),),
//             SizedBox(height: 5,),
            
//             SizedBox(height: 5,),
//             Text('${Address}',textAlign: TextAlign.center,),
// ]
// ),
//    ),
   
   
//    ),
  
//   )
  

                    

 
//                       ],

//                   ),
                

         
                  
               
                
                  
//               //for gmap

//                ),

// //button

// SizedBox(height: 5,),
// Row(
//  mainAxisAlignment: MainAxisAlignment.center,
//   children: [
  
 
//      ElevatedButton(onPressed: 
//     () {
//     //_launchUrl;
 
//        //  get_urltest();
//       // get_urltest();
      
//     IntentUtils.launchGoogleMaps(latx!,longx!);
//     }, 
//     child: Row(
//       children: [
//         Icon(Icons.directions),
//         SizedBox(width: 10,),
//         Text("Go To ",style:TextStyle(fontSize: 10,fontWeight: FontWeight.bold),)
//       ],
//     ))
//   ],
// )
// ]


// //t7
//  ),

// );
  
//   }


  // Widget getAmbilpeta(){
   
  //      double? lat11=_currentPosition?.latitude;
  //     double? lat22=_currentPosition?.longitude;

  //  return Column(
  //   children: [
       
  // Text("Tele "+lat11.toString()+" ' "+lat22.toString()),

  //   Expanded(child: 


    
  //    GoogleMap(
           
  //         initialCameraPosition: CameraPosition(    
  //        //   target: _kInitialPosition,       
  //      //target:_LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
  //      target:
  //      LatLng(_currentPosition2.latitude, _currentPosition2.longitude),
  //     // target:LatLng(lat1??0, lat2??0),
  //         zoom: 14,
  //         ),
  //       )
    
  //   )
   
  //   ,
  //   ],
    
    
  //  );

  // }
}






class MyApp_imei extends StatefulWidget {
 

  @override
  State<MyApp_imei> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp_imei> {
  String _platformVersion = 'Unknown';
  String? deviceImei;
  String? type;
  String message = "Please allow permission request!";
  DeviceInfo? deviceInfo;
  bool getPermission = false;
  bool isloading = false;
  final _deviceImeiPlugin = DeviceImei();

  @override
  void initState() {
    super.initState();
   // initPlatformState();
   // _setPlatformType();
    _getImei();
  }

  _setPlatformType() {
    if (Platform.isAndroid) {
      setState(() {
        type = 'Android';
      });
    } else if (Platform.isIOS) {
      setState(() {
        type = 'iOS';
      });
    } else {
      setState(() {
        type = 'other';
      });
    }
  }

  _getImei() async {
    
    var permission = await Permission.phone.status;

    DeviceInfo? dInfo = await _deviceImeiPlugin.getDeviceInfo();

    if (dInfo != null) {
      setState(() {
        deviceInfo = dInfo;
      });
    }

    if (Platform.isAndroid) {
      if (permission.isGranted) {
        String? imei = await _deviceImeiPlugin.getDeviceImei();
        if (imei != null) {
          setState(() {
            getPermission = true;
            deviceImei = imei;
          });
        }
      } else {
        PermissionStatus status = await Permission.phone.request();
        if (status == PermissionStatus.granted) {
          setState(() {
            getPermission = false;
          });
          _getImei();
        } else {
          setState(() {
            getPermission = false;
            message = "Permission not granted, please allow permission";
          });
        }
      }
    } else {
      String? imei = await _deviceImeiPlugin.getDeviceImei();
      if (imei != null) {
        setState(() {
          getPermission = true;
          deviceImei = imei;
        });
      }
    }
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _deviceImeiPlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
          
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Running on: $_platformVersion\n'),
              const Divider(),
              Text("ID : ${deviceInfo?.deviceId}"),
              Text("SDK INT : ${deviceInfo?.sdkInt}"),
              Text("MODEL : ${deviceInfo?.model}"),
              Text("MANUFACTURE : ${deviceInfo?.manufacture}"),
              Text("DEVICE : ${deviceInfo?.device}"),
              const Divider(),
              isloading
                  ? const CircularProgressIndicator()
                  : getPermission
                      ? Text('Device $type: $deviceImei\n')
                      : Text(message),
              Container(
                padding: const EdgeInsets.all(20.0),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _getImei,
                  child: const Text("Get Device Info"),
                ),
              ),
            ],
          ),
        ),
      );
     
  }
}

//t6
 
class IntentUtils {

 
  IntentUtils._();
  static Future<void> launchGoogleMaps(double lat1,double lat2) async {
    // const double destinationLatitude= 31.5204;
    // const double destinationLongitude = 74.3587;
    double destinationLatitude= lat1;
    double destinationLongitude = lat2;
    final uri = Uri(
        scheme: "google.navigation",
        // host: '"0,0"',  {here we can put host}
        queryParameters: {
          'q': '$destinationLatitude, $destinationLongitude'
        });
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      debugPrint('An error occurred');
    }
  }
}