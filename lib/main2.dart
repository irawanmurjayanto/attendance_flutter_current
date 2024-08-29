import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
 
import 'package:flutter_attendance_current/components/history.dart';
import 'package:flutter_attendance_current/main.dart';
import 'package:flutter_attendance_current/message/warning.dart';
import 'package:flutter_attendance_current/provider/mapdatas.dart';
//import 'package:flutter_attendance_current/provider/mapdatas.dart';

import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
 import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:device_imei/device_imei.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
 
import 'package:permission_handler/permission_handler.dart';
 
import 'package:provider/provider.dart';
 
import 'package:esys_flutter_share_plus/esys_flutter_share_plus.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:device_info_plus/device_info_plus.dart';
 
 
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:just_audio/just_audio.dart';
 
  
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
   getSession() async{
    await GetStorage.init();
   } 
  
  @override
  void initState() {
  
    super.initState();
 
   // _getImeix();
   _getTimeClock();
   _gethasil();
   _getTime();
   _getId(); 
    getSession(); 
   
  }

  final box=GetStorage();

final _empregnik=TextEditingController();
 getEmpReg() async {
  showDialog(context: context, builder: (context) {
    // ignore: prefer_const_constructors
    return AlertDialog(
      
       title: Text("Employee Register"), 
       content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
          autofocus: true,  
          controller: _empregnik,
          decoration: InputDecoration(
          labelText: "NIK",
          hintText: "NIK"
        ),
       ),

        ],
        
       ),
      actions: [
        IconButton(onPressed: () {
           Provider.of<MapDatas>(context,listen: false).provEmpReg(context, _empregnik.text,ambilid!.toString()).then((value) => Navigator.pop(context));
        }, icon: Icon(Icons.save)),

        IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(Icons.cancel))
      ],
    );
  },);
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
    box.write("imei",androidDeviceInfo.id);
    return androidDeviceInfo.id; // unique ID on Android
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

String? jam;

 _getTimeClock() async{

 
  Timer.periodic(Duration(seconds: 1), (timer) { 
   
   jam=DateFormat("HH:mm:ss dd-MM-yyyy ").format(DateTime.now());
   _jam.text=jam!; 
    
  });
    
   
}

final snakbartime=SnackBar(content:Text("test"));

//t3 
TextEditingController _title=TextEditingController();
 

  

 
 Future takePicture(ImageSource media) async {
   
       // var img = await picker.pickImage(source: media);
          var choosedimage = await picker.pickImage(source: media,imageQuality: 4,preferredCameraDevice: CameraDevice.rear) ;
        //set source: ImageSource.camera to get image from camera
       setState(() {
       image = File(choosedimage!.path);
    });
 }


 String? _tempImei;  
 final _imetText =TextEditingController();


//u3
 _getImeix() async {

    Fluttertoast.showToast(
                          msg: "tset",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0
                        ); 
    
    var permission = await Permission.phone.status;

    //DeviceInfoPlugin androidDeviceInfo = DeviceInfoPlugin();

    DeviceInfo? dInfo = await _deviceImeiPlugin.getDeviceInfo();


      

    if (dInfo != null) {
      setState(() {
        deviceInfo = dInfo;
        _tempImei=deviceInfo!.deviceId;
        box.write("imei",ambilid!.toString());
         
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
          _getImeix();
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


  //atas
  


  @override
  Widget build(BuildContext context) {

   final screenHeight=MediaQuery.of(context).size.height;
    return Scaffold(
      //backgroundColor: Colors.transparent,
      
       appBar: AppBar(
         title: const Center(child:Text('Attendance of PT. Paradise Island',style: TextStyle(color: Colors.white,fontSize: 18),)),
 backgroundColor: Colors.blueAccent,
 toolbarHeight: screenHeight*0.1,
 
                //   actions: [
                //               IconButton(onPressed: () {


                //                 Fluttertoast.showToast(
                //           msg: box.read('imei'),
                //           toastLength: Toast.LENGTH_SHORT,
                //           gravity: ToastGravity.CENTER,
                //           timeInSecForIosWeb: 2,
                //           backgroundColor: Colors.green,
                //           textColor: Colors.white,
                //           fontSize: 16.0
                //         );
                                
                //   }, icon: Icon(Icons.access_alarm,size: 30,))
                // ],
        flexibleSpace: Stack(
           
           children: [
           
            Image.asset("assets/images/appbar.png",
            fit: BoxFit.cover,
            //height: screenHeight*0.1,
            height: screenHeight * 0.2,
            ),
            
           ],
        ),
        actions: [
         
          PopupMenuButton(
            iconColor: Colors.white,
            iconSize: 30,
            color: Colors.white,
            itemBuilder: (context) {
            
            return[
              PopupMenuItem<int>(
                value: 0,
                child: Text("Employee Register"),
              ),       
               
            ];
          },
          onSelected: (value) {

            if (value==0)
            {
              //_getwarn("Menu 1");
              getEmpReg();
            }

           
              
          },
          )
          
        ],
      
        ),
      // floatingActionButton: FloatingActionButton.small(onPressed: () {

      //  //_getImeix();
      //  _getId();

       
      //                           Fluttertoast.showToast(
      //                     msg: "test"+ambilid!.toString(),
      //                     toastLength: Toast.LENGTH_SHORT,
      //                     gravity: ToastGravity.CENTER,
      //                     timeInSecForIosWeb: 2,
      //                     backgroundColor: Colors.green,
      //                     textColor: Colors.white,
      //                     fontSize: 16.0
      //                   );

      // },),  
      body:
      
      SingleChildScrollView(
         
        child: 
      Container(
       //height all frame 
       height: MediaQuery.sizeOf(context).height/1.1,

        // constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
     color: Colors.black12,
        ),
        child:
        Column(
          
          children: [
  

//bikinbox flexible
              
            //bedul 2
                
               Flexible(
                flex:5,
                fit: FlexFit.loose,
                child: Container(
                 //frame block 2 
                  height: MediaQuery.of(context).size.height/2.5,
                 padding: EdgeInsets.all(5),
                // height: MediaQuery.of(context).size.height/3,
                  width: double.infinity,
                  margin: EdgeInsets.all(10),
                   decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
          
                   ),
                   child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      
                      Container(

                 
 
                      
                      //u1
                      child: newData(),





                      ),
                      //t4
                     
                    ]
                       
                    
                   
                   )

                )
          
                ),


//bedul2
Container(
 
  child: 
Container(
  height: MediaQuery.of(context).size.height/3,
  padding: EdgeInsets.all(20),
  margin: EdgeInsets.only(left:10,right:10,top:2),
decoration: BoxDecoration(
  color: Colors.white,
  border: Border.all(style: BorderStyle.solid,color: Colors.white),
  borderRadius: BorderRadius.circular(7),  
   image: DecorationImage(
      image: AssetImage('assets/images/back5b.jpg'),
      fit: BoxFit.cover,
      )

 
  
),


child: Row(
 
 //mainAxisAlignment:MainAxisAlignment.center,
children: [


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

,
  


],
),
 
SizedBox(width: 20,),
 //for save control
 
Column(
  mainAxisAlignment: MainAxisAlignment.center,
   children: [


ElevatedButton(onPressed: () {
     takePicture(ImageSource.camera);
      // final player = AudioPlayer();  
      //     //player.play(AssetSource('audio/bell.mpeg'));
      //     player.setAsset('assets/sound/ferakeluar.mpeg');
    
      //     player.play();


  }, child: 
  Row(
    children: [
      Icon(Icons.camera_enhance_rounded,size: 20,),
      SizedBox(width: 5,),
      Text("Ambil Photo   ",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),)
    ],
  )
  ),

  SizedBox(height: 5,),

ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black87,
       
      ),
      //savedata
      onPressed: () {

      if (image==null){
        Fluttertoast.showToast(
        msg: "Photo Wajah harus ada",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 20.0
       );
        return;
        }


      List<int> imageBytes = image!.readAsBytesSync();
      String baseimage = base64Encode(imageBytes);
      String baseimage2=baseimage==null?'x':baseimage;

      final String lok=lat1new.toString()+","+lat2new.toString()+","+Address.toString();

      getStatusInet(context);
      Provider.of<MapDatas>(context,listen:false).saveImageMapxx(context,baseimage2,ambilid!.toString(),lok,'MASUK');   

       
      }, 
      
      child: Row(
        
        children: [
          Icon(Icons.input,color: Colors.white),
          SizedBox(width: 5,),
          Text("Absen Masuk",style: TextStyle(color: Colors.white,fontSize: 10,fontWeight: FontWeight.bold))

        ],

      )
      
      ),


      SizedBox(height: 5,),

      ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black87,
       
      ),
      //savedata
      onPressed: () {
        

       if (image==null){
        Fluttertoast.showToast(
        msg: "Photo Wajah harus ada",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 20.0
       );
        return;
        }


      List<int> imageBytes = image!.readAsBytesSync();
      String baseimage = base64Encode(imageBytes);
      String baseimage2=baseimage==null?'x':baseimage;

      final String lok=lat1new.toString()+","+lat2new.toString()+","+Address.toString();

      getStatusInet(context);
      Provider.of<MapDatas>(context,listen:false).saveImageMapxx(context,baseimage2,ambilid!.toString() ,lok,'KELUAR');   

     
     

      


          
    
   

       
      }, 
      
      child: Row(
        
        children: [
          Icon(Icons.output,color: Colors.white),
          SizedBox(width: 5,),
          Text("Absen Keluar",style: TextStyle(color: Colors.white,fontSize: 10,fontWeight: FontWeight.bold),)

        ],

      )
      
      )




   ],
)

 
 
   

 
 
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

  final _jam=TextEditingController();

  Widget Jam_clock(){
    return Padding(padding: EdgeInsets.all(5),
    child: TextField(
      textAlign: TextAlign.center,
      style: TextStyle(decoration: TextDecoration.none,fontWeight: FontWeight.bold,fontSize: 20), 
     
      
      controller: _jam,
    ),
    
    );
  }

//u2
  Widget newData(){
   return Container(
          padding: EdgeInsets.only(bottom:10,top:10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage('assets/images/back5b.jpg'),
                fit: BoxFit.cover,
                )
            ),

     child: SingleChildScrollView(
 
    scrollDirection: Axis.vertical,
     child:Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [


    //cur   T
            Text("Summary",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
            SizedBox(height: 5,),
            Jam_clock(),
            SizedBox(height: 5,),
            Text (box.read("imei"),style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),    
            SizedBox(height: 5,),
            
            Text(location,style: TextStyle(color: Colors.black,fontSize: 16),),
            SizedBox(height: 5,),
            
            SizedBox(height: 5,),
            Text('${Address}',textAlign: TextAlign.center,),
]
),
   ),
    
    );
  }


//just note script for next
  Widget getAmbildata(){
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
 // height: 80,
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


    //cur   T
            Text("Summary",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
            SizedBox(height: 5,),
            Jam_clock(),
            SizedBox(height: 5,),
            Text (deviceInfo!.deviceId.toString(),style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),    
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
 
    
  ],
)
]


//t7
 ),

);
  
  }


  // Widget getAmbilpeta(){
   
  //      double? lat11=_currentPosition?.latitude;
  //     double? lat22=_currentPosition?.longitude;

  //  return Column(
  //   children: [
       
  // Text("Tele "+lat11.toString()+" ' "+lat22.toString()),

  //   Expanded(child: 


    
  // //    GoogleMap(
           
  // //         initialCameraPosition: CameraPosition(    
  // //        //   target: _kInitialPosition,       
  // //      //target:_LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
  // //      target:
  // //      LatLng(_currentPosition2.latitude, _currentPosition2.longitude),
  // //     // target:LatLng(lat1??0, lat2??0),
  // //         zoom: 14,
  // //         ),
  // //       )
    
  // //   )
   
  // //   ,
  // //   ],
    
    
  // //  );

  // // }
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
 
// class IntentUtils {

 
//   IntentUtils._();
//   static Future<void> launchGoogleMaps(double lat1,double lat2) async {
//     // const double destinationLatitude= 31.5204;
//     // const double destinationLongitude = 74.3587;
//     double destinationLatitude= lat1;
//     double destinationLongitude = lat2;
//     final uri = Uri(
//         scheme: "google.navigation",
//         // host: '"0,0"',  {here we can put host}
//         queryParameters: {
//           'q': '$destinationLatitude, $destinationLongitude'
//         });
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri);
//     } else {
//       debugPrint('An error occurred');
//     }
//   }
// }