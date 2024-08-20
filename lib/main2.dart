import 'package:flutter/material.dart';
 
import 'package:flutter_attendance_paradise/components/history.dart';
import 'package:flutter_attendance_paradise/main.dart';

import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
 import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:device_imei/device_imei.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:get_location_addres/get_imei.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:flutter_share/flutter_share.dart';
//import 'package:documents_picker/documents_picker.dart';
import 'package:esys_flutter_share_plus/esys_flutter_share_plus.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:device_info_plus/device_info_plus.dart';
 
 
    import 'package:http/http.dart' as http;
     import 'dart:convert';
 
  
 //awal
 
    
 

// void main() {
//   runApp(MyApp());
// }
// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Google Map',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: Homepage(),
//     );
//   }
// }
 



 
class HomepageMenu extends StatefulWidget {
  const HomepageMenu({Key? key}) : super(key: key);
  @override
  _HomepageState createState() => _HomepageState();
}
class _HomepageState extends State<HomepageMenu> {
     
  bool isloading = false;
   
   
//t0

   //late Position _currentPosition=Position(longitude: 0, latitude: 0, timestamp: DateTime(1972), accuracy: 0, altitude: 0, altitudeAccuracy: 0, heading: 0, headingAccuracy: 0, speed: 0, speedAccuracy: 0);
   late Position _currentPosition;
   late Position _currentPosition2;

   //late final String apiEndpoint;
   

  @override
  void initState() {
  
    super.initState();
 
  // _getImei();
   _gethasil();
   _getTime();
   _getId(); 
  
   
  }


 

_shareImage2() async{

final ByteData bytes = await rootBundle.load(image!.path);
await Share.file('Share image', 'esys.png', bytes.buffer.asUint8List(), 'image/png', text: 'My optional text.');

}

  

   Future<Position> getInitialPosition () async {
    _currentPosition = await _getGeoLocationPosition();
    return _currentPosition;
  }


  String? deviceImei;
  String? type;
  String message = "Please allow permission request!";
  DeviceInfo? deviceInfo;
  bool getPermission = false;
  final Uri _url = Uri.parse('https://flutter.dev'); 
  static String? ambilid;
   
  
 Future<String?> _getId() async {
  var deviceInfo = DeviceInfoPlugin();
  if (Platform.isIOS) { // import 'dart:io'
    var iosDeviceInfo = await deviceInfo.iosInfo;
    ambilid=iosDeviceInfo.identifierForVendor;
    return iosDeviceInfo.identifierForVendor; // unique ID on iOS
  } else if(Platform.isAndroid) {
    var androidDeviceInfo = await deviceInfo.androidInfo;
    ambilid=androidDeviceInfo.id;
    return androidDeviceInfo.id; // unique ID on Android
  }
}
  

  
 
       get_urltest() async {
       await IntentUtils.launchGoogleMaps;
       
       
    }
        

Future<void> _launchUrl() async {
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}



      static double lat1=0;
  static double lat2=0;
    static double lat1new=0;
  static double lat2new=0;
 _gethasil() async{
   Position position = await _getGeoLocationPosition();
              location ='Lat: ${position.latitude} , Long: ${position.longitude}';
             // isloading?GetAddressFromLatLong(position):const Center(child: CircularProgressIndicator(),);   
         
    setState(() {
          lat1new=position.latitude;
          lat2new=position.longitude;
    });   

    //  lat1=position.latitude;
    //       lat2=position.longitude;  

_currentPosition=position;
    
    
          GetAddressFromLatLong(position);

 }

 
  
 final snakbar=SnackBar(content:Text('Detail '+lat1.toString()+"  ,  "+lat2.toString()));
     //ScaffoldMessenger.of(context).showSnackBar(snakbar);


 

final snakbar2=SnackBar(content:Text(now2));

  final _deviceImeiPlugin = DeviceImei();

 File? image;
    
     
Future _getwarn(String msg) async{

  final warn1=SnackBar(content: Center(child: Text(msg,style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.black,
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(
            // bottom: MediaQuery.of(context).size.height-350,
            bottom: MediaQuery.of(context).size.height-200,
            left: 30,right: 30,
          ),  
          );
          ScaffoldMessenger.of(context).showSnackBar(warn1);

}

      
      final ImagePicker picker = ImagePicker();
 static String now2="x";
Future _getTime () async {
 DateTime now1=DateTime.now(); 
 int day=now1.day;
 int month=now1.month;
 int year=now1.year;
 int hour = now1.hour;
int minute = now1.minute;
int second2 = now1.second;
now2=day.toString()+month.toString()+year.toString()+hour.toString()+minute.toString()+second2.toString();
return now2;
 
}

final snakbartime=SnackBar(content:Text("test"));

      
 
 


//t3 
TextEditingController _title=TextEditingController();
 Future _AlertSave() async{

 return showDialog(
  context: context, 
  builder: (context) {
    return AlertDialog(
     // title: Center(child:Text("Title For Map")),
      content: TextField(
        onChanged: (value) {
          setState(() {
            _title.text=value;
          });
          
        },
        controller: _title,
        decoration: InputDecoration(
          hintText: 'Title For Parking Spot',

        ),
        
      ),
      actions: [
        MaterialButton(
          color: Colors.black,
          child: Text("Ok",style: TextStyle(color: Colors.white),),
          onPressed: () {
            saveImageMap();
            Navigator.pop(context);
          },)
      ],
    );
    
  },); 
 
 }
 
 Future saveImageMap() async {
   
       // var img = await picker.pickImage(source: media);
          //var choosedimage = await picker.pickImage(source: media,imageQuality: 5,preferredCameraDevice: CameraDevice.front) ;
        //set source: ImageSource.camera to get image from camera
      // setState(() {
       //image = File(choosedimage!.path);
    //});

    
       var uploadurl = Uri.parse('https://irawan.angsoft.info/tests/flutter/map1/insert.php');


//  uploadurl.files.add(pic);
    
//           await uploadurl.send();

  EasyLoading.show(status: "Saving Data..");

    try{
      List<int> imageBytes = image!.readAsBytesSync();
      String baseimage = base64Encode(imageBytes);
      String baseimage2=baseimage==null?'x':baseimage;
     

      var response = await http.post(
          uploadurl,
          body: {
            'imei_no':ambilid,
            'map_lat':lat1new.toString(),
            'map_long':lat2new.toString(),
            'keyno':now2,
            'judul':Address.toString(),
            'image': baseimage2,
          }
      );
      if(response.statusCode == 200){
        var jsondata = json.decode(response.body);
        if(jsondata["error"]){
          print(jsondata["msg"]);
        }else{
         // print("Upload successful");
             var message = jsonDecode(response.body);
    
              // show snackbar if input data successfully
              // final snackBar = SnackBar(
              //   content: Center(child:Text(message['message'])),
              //   backgroundColor: Colors.black,
              //   dismissDirection: DismissDirection.up,
              //   behavior: SnackBarBehavior.floating,
              //   margin: EdgeInsets.only(
              //     left: 30,
              //     right: 30,
              //     bottom: MediaQuery.of(context).size.height-350
              //   ),
                
              //   );
              // ScaffoldMessenger.of(context).showSnackBar(snackBar);
              _getwarn(message['message']) ;
             // Navigator.pop(context);
              EasyLoading.dismiss();
        }
      }else{
        print("Error during connection to server");
      }
    }catch(e){
      print("Error during converting to Base64");
    }
    
      }

 Future takePicture(ImageSource media) async {
   
       // var img = await picker.pickImage(source: media);
          var choosedimage = await picker.pickImage(source: media,imageQuality: 5,preferredCameraDevice: CameraDevice.front) ;
        //set source: ImageSource.camera to get image from camera
       setState(() {
       image = File(choosedimage!.path);
    });
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


  

final TextEditingController TestExt=TextEditingController();
 

 
      


 
               
 


  final mybutton=GlobalKey();



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

 

  

    return Scaffold(
      //backgroundColor: Colors.transparent,
       appBar: AppBar(
         title: const Center(child:Text('Attendance of PT Paradise',style: TextStyle(color: Colors.white),)),
 backgroundColor: Colors.blueAccent,
// actions: [
//             IconButton(onPressed: () {
//               Navigator.push(context, MaterialPageRoute(builder: (context) => History1(),));
//             }, icon: Icon(Icons.access_alarm,size: 30,))
//           ],

        ),
      body:
      
      SingleChildScrollView(
         
        child: 
      Container(
        
       height: MediaQuery.sizeOf(context).height/1.14,

        // constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
     color: Colors.black12,
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

FutureBuilder<Position>(
  
  future: getInitialPosition(), 
  builder:  (context, snapshot) {
   
    if (snapshot.hasData)
    {
      
       return getAmbildata(snapshot.data);
    }else{
      return CircularProgressIndicator();
    }

  },
  
  )
 
 
//addresss etc

// Expanded(child: 
// getAmbilpeta(),

// ),
 
 
                        
                        // decoration: BoxDecoration(
                        //   color: Colors.white12,
                        //   borderRadius: BorderRadius.circular(5),
                        //  border: Border.all(
                        //   style: BorderStyle.solid,
                        //   color: Colors.black,
                        //   strokeAlign: BorderSide.strokeAlignOutside,
                        //   width: 0.8
                          
                        // ),

                        // ),

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
 
 //mainAxisAlignment:MainAxisAlignment.center,
children: [

Column(
  children: [

    IconButton(
      onPressed: () {
        takePicture(ImageSource.camera);
        
      }, 
      
      icon: Icon(Icons.camera_enhance_rounded),iconSize: 30,),

      
    IconButton(
      onPressed: () {


   if (image==null){

          _getwarn('Image must be exist');
        //  ScaffoldMessenger.of(context).showSnackBar(warn1);

        }else{

        showDialog(context: context, 
        builder: (context) {
         return  AlertDialog(
            content: Image.file(File(image!.path)),
          );
        },);
        }




       
        
      }, 
      
      icon: Icon(Icons.center_focus_strong),iconSize: 30,),

      
    IconButton(
      onPressed: ( ) {
      //  shareFile();

      //  showDialog(context: context, 
      //   builder: (context) {
      //    return  AlertDialog(
      //       content: Image.file(File(image!.path)),
      //     );
      //   },);
    if (image==null){

          _getwarn('Image must be exist');
        //  ScaffoldMessenger.of(context).showSnackBar(warn1);

        }else{
      _shareImage2();
        }
      
      }, 
      
      icon: Icon(Icons.share_rounded),iconSize: 30,),
 
  ],
),

//for camera
Column(
  mainAxisAlignment: MainAxisAlignment.spaceAround,
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
    child: image==null?Center(child: Text("No Image",style: TextStyle(color: Colors.white),)):Image.file(
      fit: BoxFit.cover,
      File(image!.path)
      ),
  )
],
),
 
SizedBox(width: 8,),
 //for save control
 
Column(
  mainAxisAlignment: MainAxisAlignment.center,
   children: [


ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black87,
       
      ),
      //savedata
      onPressed: () {
        
        if (image==null){
//EasyLoading.show(status: "Saving Data..");
          _getwarn('Image must be exist');
        //  ScaffoldMessenger.of(context).showSnackBar(warn1);

        }else{
        //  showDialog(context: context, 
        //  builder:  (context){
        //     // Future.delayed(const Duration(milliseconds: 300));
        //    return Center(child: CircularProgressIndicator(),);
        //  },);
        //_AlertSave();
       // EasyLoading.show(status: "Saving Data..");
        saveImageMap();
     //   Navigator.pop(context);
        }

       
      }, 
      
      child: Row(
        
        children: [
          Icon(Icons.save,color: Colors.white),
          SizedBox(width: 5,),
          Text("Save",style: TextStyle(color: Colors.white),)

        ],

      )
      
      )

   ],
)

 

// child: Column(
  
//   mainAxisAlignment: MainAxisAlignment.center,
//   children: [
//     Padding(padding: EdgeInsets.all(5),
//     child: ElevatedButton(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Colors.black87,
       
//       ),
//       //savedata
//       onPressed: () {
        
//         if (image==null){
// //EasyLoading.show(status: "Saving Data..");
//           _getwarn('Image must be exist');
//         //  ScaffoldMessenger.of(context).showSnackBar(warn1);

//         }else{
//         //  showDialog(context: context, 
//         //  builder:  (context){
//         //     // Future.delayed(const Duration(milliseconds: 300));
//         //    return Center(child: CircularProgressIndicator(),);
//         //  },);
//         //_AlertSave();
//        // EasyLoading.show(status: "Saving Data..");
//         saveImageMap();
//      //   Navigator.pop(context);
//         }

       
//       }, 
      
//       child: Row(
        
//         children: [
//           Icon(Icons.save,color: Colors.white),
//           SizedBox(width: 5,),
//           Text("Save",style: TextStyle(color: Colors.white),)

//         ],

//       )
      
//       )
    
    
//     ),
    
//   ],
// )    
   

 
 
],



),

)
)
              

 
            
          ],
        ),
      ),
      )
      //disini 
    );
  }

//t5

  Widget getAmbildata(snapshot){
return Container(
   decoration: BoxDecoration(
    image: DecorationImage(
      image: AssetImage('assets/images/back5b.jpg'),
      fit: BoxFit.cover,
      )
   ),

 child: Column(
children: [
 Container(
   height: MediaQuery.of(context).size.height/3.0,
  child: 
 GoogleMap(
           
          initialCameraPosition: CameraPosition(    
    
          // target:LatLng(snapshot.latitude, snapshot.longitude),
          target:LatLng(lat1new,lat2new),
           zoom: 14,
            
          ),
        //  myLocationEnabled: true,
              
          markers: {
    Marker(
      markerId: MarkerId("source"),
      position: LatLng(snapshot.latitude, snapshot.longitude) ,
    ),
          }
        )
 ),



                Container(
                 //   height: MediaQuery.of(context).size.height /6,
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  
                    color: Colors.amberAccent,
                 gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.white,Colors.blueAccent]
                 ),
                 borderRadius: BorderRadius.circular(10),
                 border: Border.all(style: BorderStyle.solid,color: Colors.black12,width: 1,),
                 boxShadow: [
                  
                 const  BoxShadow(
                  offset: Offset(3, 3),
                  blurRadius: 3,
                  spreadRadius: 3

                 ),
                 const  BoxShadow(
                  color: Colors.white,
                  offset: Offset(2, 2),
                  blurRadius: 2,
                  spreadRadius: 2

                 )

                 ]
                

                ),
           
                 
                  child: Column(
mainAxisAlignment: MainAxisAlignment.center,
                      children: [

//layar1
 
  Container(
      // height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
  height: 80,
   child: Scrollbar(
     thumbVisibility: true,
 
                  thickness: 10, //width of scrollbar
                  radius: Radius.circular(20), //corner radius of scrollbar
                  scrollbarOrientation: ScrollbarOrientation.left,

    child: SingleChildScrollView(
 
    scrollDirection: Axis.vertical,
     child:Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
   //t11    
            // FutureBuilder(future: _getTime(), 
            // builder: (context, snapshot) {
            //   if (snapshot.hasData){
            //    //return snapshot.data??"";
            //    return  Text(snapshot.data);
            //   }else{
            //     return CircularProgressIndicator();
            //   }
              
            // },),
          
            // SizedBox(height: 5,),
           // Text(now2.toString()),
            // Text('ID/Corrdinates Location',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
            // Text("ID : ${deviceInfo?.deviceId}"),

            SizedBox(height: 5,),
            
            Text(location,style: TextStyle(color: Colors.black,fontSize: 16),),
            SizedBox(height: 5,),
            
            SizedBox(height: 5,),
            Text('${Address}',textAlign: TextAlign.center,),
]
),
   ),
   
   
   ),
  
  )
  

                    

 
                      ],

                  ),
                

         
                  
               
                
                  
              //for gmap

               ),

//button

SizedBox(height: 5,),
Row(
 mainAxisAlignment: MainAxisAlignment.center,
  children: [
    ElevatedButton(onPressed: 
    () {
      _getTime();
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => new MyApp(),));
     // _gethasil();
    }, 
    child: Row(
      children: [
        Icon(Icons.refresh),
        Text("Refresh",style:TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
      ],
    )
    
    ),
SizedBox(width: 10,),
     ElevatedButton(onPressed: 
    () {
    //_launchUrl;
    
    IntentUtils.launchGoogleMaps(lat1new,lat2new);
       //  get_urltest();
      // get_urltest();
    }, 
    child: Row(
      children: [
        Icon(Icons.directions),
        SizedBox(width: 10,),
        Text("Go To ",style:TextStyle(fontSize: 10,fontWeight: FontWeight.bold),)
      ],
    ))
  ],
)
]


//t7
 ),

);
  
  }


  Widget getAmbilpeta(){
   
       double? lat11=_currentPosition?.latitude;
      double? lat22=_currentPosition?.longitude;

   return Column(
    children: [
       
  Text("Tele "+lat11.toString()+" ' "+lat22.toString()),

    Expanded(child: 


    
     GoogleMap(
           
          initialCameraPosition: CameraPosition(    
         //   target: _kInitialPosition,       
       //target:_LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
       target:
       LatLng(_currentPosition2.latitude, _currentPosition2.longitude),
      // target:LatLng(lat1??0, lat2??0),
          zoom: 14,
          ),
        )
    
    )
   
    ,
    ],
    
    
   );

  }
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
       //   _getImei();
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