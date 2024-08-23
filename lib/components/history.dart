import 'package:flutter/material.dart';
import 'package:flutter_attendance_current/components/server.dart';
import 'package:flutter_attendance_current/datamodel/history.dart';
import 'package:flutter_attendance_current/datamodel/listpend.dart';
import 'package:flutter_attendance_current/datamodel/post.dart';
import 'package:flutter_attendance_current/main.dart';
import 'package:flutter_attendance_current/provider/mapdatas.dart';
 
import 'package:flutter_attendance_current/route/routemap.dart';
import 'package:flutter/services.dart';
import 'package:device_imei/device_imei.dart';
import 'dart:io'; 
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
 
  import 'package:http/http.dart' as http;
     import 'dart:convert';
 import 'package:flutter_typeahead/flutter_typeahead.dart';    




class HistoryMenu extends StatelessWidget {
  const HistoryMenu({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
    debugShowCheckedModeBanner: false,
      home: History1(),
    );
  }
}


class History1 extends StatefulWidget {
   

  const History1({super.key })  ;


 


  @override
  State<History1> createState() => _History1State( );
}

class _History1State extends State<History1> {
 



 bool isLoading=true;
 
 String? txtTampung1;
  String _platformVersion = 'Unknown';
  String? deviceImei;
  String? type;
  String message = "Please allow permission request!";
  DeviceInfo? deviceInfo;
  bool getPermission = false;
  bool isloading = false;
  final _deviceImeiPlugin = DeviceImei();
  TextEditingController _cari=TextEditingController();
 


 

//  DeviceInfoPlugin androidDeviceInfo = DeviceInfoPlugin();
 
 
  

 

setPlatformType() {
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



  
 
 
 Future <void> getRefreshdata() async{
  Provider.of<MapDatas>(context,listen:false ).getHistoryCari(deviceInfo!.deviceId.toString());
 }

 
  @override
  void initState() {
  
    super.initState();
   getRefreshdata();
   _getImei();
 
   
  }


  @override
  Widget build(BuildContext context) {

 

    return
    PopScope(
     canPop: false,
  onPopInvoked : (didPop){
   // logic
  },
    child: 
    
     Scaffold(
    
     appBar: AppBar(title: Center(child:Text("History",style: TextStyle(color: Colors.white),),),
     backgroundColor: Colors.blueAccent,
     
     ),
     body:Padding(
      padding: EdgeInsets.all(10),
     child: 
     
      
      FutureBuilder(future: Provider.of<MapDatas>(context,listen: false).getHistoryCari(deviceInfo!.deviceId.toString()), 
      
      builder: 
      (context, snapshot) {
        if (snapshot.connectionState==ConnectionState.waiting)
        {
          return CircularProgressIndicator();
        }else{
          return Consumer<MapDatas>(builder: (context, prov, child) {

            return ListView.builder(
              itemCount: prov.datamap.length,
              itemBuilder: (context, i) {
                return  Container(
                
                  child:ListTile(
                    leading: Text("Gbr"),
                    title: Text(prov.datamap[i].absen!,style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),), 
                    subtitle:Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Text(prov.datamap[i].nama!+"("+prov.datamap[i].nik!+"/"+prov.datamap[i].section!+")",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                         Text(DateFormat('dd-MM-yyyy').format(DateTime.parse(prov.datamap[i].tglrec!)).toString(),style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                      ],
                    )
                    
                    
                  )  
                   // Text(prov.datamap[i].nama!,style: TextStyle(color: Colors.red),),
                  //  Text("Test"),
                );
            },);
          },);
        }
      },
      )
      
    
      ),
     
     )
 
     
     );

 
    
 

  
  }


   
 
 
// Widget DataAll2(){
//   return   
//     Container(
      
//       color: Colors.blue,
//       child: 
      
//       SingleChildScrollView(
//         child: 
//       FutureBuilder(future: Provider.of<MapDatas>(context,listen: false).getHistoryCari(deviceInfo!.deviceId.toString()), 
      
//       builder: 
//       (context, snapshot) {
//         if (snapshot.connectionState==ConnectionState.waiting)
//         {
//           return CircularProgressIndicator();
//         }else{
//           return Consumer<MapDatas>(builder: (context, prov, child) {

//             return ListView.builder(
//               itemCount: prov.datamap.length,
//               itemBuilder: (context, i) {
//                 return ListTile(
//                     title: Text(prov.datamap[i].nama!,style: TextStyle(color: Colors.red),),
//                 );
//             },);
//           },);
//         }
//       },
//       )
      
    
//       ),
//   );
// }
    
    

Widget dataAll(){
return

SingleChildScrollView( 
  child:    
     Column(
children: [
 

Container(
 
  margin: EdgeInsets.all(10),
child: Text("Last 30 Records",textAlign:TextAlign.center),

 
),

 


Container(
height: MediaQuery.of(context).size.height/1.5,
  
 color: Colors.blue,   
  child: RefreshIndicator(
    onRefresh:() => 
    getRefreshdata(),
    
    
    child: 

      
  FutureBuilder(
        future: Provider.of<MapDatas>(context,listen:false ).getHistoryCari(deviceInfo!.deviceId.toString()),
        builder: 
        (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
              // until data is fetched, show loader
              return Center(child:CircularProgressIndicator() ,) ;
            } else  { 
              // once data is fetched, display it on screen (call buildPosts())
             
              return  Padding(
                padding: EdgeInsets.all(10),
              
                  child:   Consumer<MapDatas>(builder: (context, value, child) {
                    final datafinal=value.datamap;
                    return ListView.builder(
                      itemCount: datafinal.length,
                      itemBuilder: (context, index) {
                      return 
                      Container(
                        margin: EdgeInsets.only(bottom: 15),
                    
                      decoration: BoxDecoration(
                      border: Border.all(style: BorderStyle.solid,color: Colors.lightBlueAccent),
                      borderRadius: BorderRadius.all(Radius.circular(10)),  
                      gradient: LinearGradient(colors: [
                        
                        Colors.white,Colors.lightBlueAccent
                      ],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      
                      ),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(3, 3),
                          spreadRadius: 3,
                          blurRadius:3,
                               color: Colors.black26
                        ),
                      BoxShadow(
                          offset: Offset(2, 2),
                          spreadRadius: 2,
                          blurRadius: 2,
                          color: Colors.white
                        ),
                      ]
                      ),
                      child: 
                      ListTile(

                        leading: Container( 
                          
                         
                        decoration: BoxDecoration(
                          border: Border.all(style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(10),
                           
                           
                        ),  
                        clipBehavior: Clip.antiAlias,
                        child: Image==isLoading?Center(child: CircularProgressIndicator(),):
                         Image.network(
                            
                          width: 50,
                          height: 70,
                          fit: BoxFit.fill,
                          NamaServer.server+'hrd/uploademp/'+datafinal[index].pict_att!+".jpg",
                          frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                            return child;
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress==null)
                            {
                              return child;
                            }else{
                              return CircularProgressIndicator();
                            }
                          },
                        ),
                        
                        
                        
                        
                        ),
                        title: Text(datafinal[index].nama!+"("+datafinal[index].nik!+")",overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.black45,fontWeight: FontWeight.bold),),
                        subtitle: Text(datafinal[index].tglrec!
                      ),
                      ),
                    );
                    },);
                  },)

                );

            }
            // } else {
            //   // if no data, show simple Text
            //   return const Text("No data available");
            // }
        },)


 
   ),
  
  
)
  //singlechild
],

     )
 
    );



}
    



}


