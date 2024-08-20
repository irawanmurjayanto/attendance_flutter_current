import 'package:flutter/material.dart';
import 'package:flutter_attendance_paradise/components/server.dart';
import 'package:flutter_attendance_paradise/datamodel/history.dart';
import 'package:flutter_attendance_paradise/datamodel/listpend.dart';
import 'package:flutter_attendance_paradise/datamodel/post.dart';
import 'package:flutter_attendance_paradise/main.dart';
import 'package:flutter_attendance_paradise/provider/mapdatas.dart';
 
import 'package:flutter_attendance_paradise/route/routemap.dart';
import 'package:flutter/services.dart';
import 'package:device_imei/device_imei.dart';
import 'dart:io'; 
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:provider/provider.dart';
 
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
 List<DataModel> listHistory=[];
 List<Pendidikan> listPendidikan=[];
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
 

  @override
  void initState() {
  
    super.initState();
    print('inistate');
   //_getImei();
    _getId();
    
   //_getHistory();
  
   
  }


  
   @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies

    //  final snackbar2=SnackBar(content: Text("TestdidChange"));
    //  ScaffoldMessenger.of(context).showSnackBar(snackbar2);
    
    print('didChangeDependencies()');
    super.didChangeDependencies();
  }


 DeviceInfoPlugin androidDeviceInfo = DeviceInfoPlugin();
 
 
 static String? ambilid;
 _getId() async {
  var deviceInfo = DeviceInfoPlugin();
  if (Platform.isIOS) { // import 'dart:io'
    var iosDeviceInfo = await deviceInfo.iosInfo;
    setState(() {
      ambilid=iosDeviceInfo.identifierForVendor;
    });
    
    return iosDeviceInfo.identifierForVendor; // unique ID on iOS
  } else if(Platform.isAndroid) {
    var androidDeviceInfo = await deviceInfo.androidInfo;
    setState(() {
      ambilid=androidDeviceInfo.id;
    });
    
    return androidDeviceInfo.id; // unique ID on Android
  }
}

final String apiUrl = "https://reqres.in/api/users?per_page=15";
Future<List<dynamic>> _fecthDataUsers() async {
  var result = await http.get(Uri.parse(apiUrl));
  return json.decode(result.body)['data'];
}


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



  Future getListPendidikan() async{

   try{
    var response= await http.get(Uri.parse(NamaServer.server+'tests/flutter/dropdown/list1.php'));

     if(response.statusCode==200)
     {
      var jsonget=jsonDecode(response.body)['data'];
      for (var i=0;i<jsonget.length;i++)
      {
        setState(() {
          
          listPendidikan.add(Pendidikan.fromJson(jsonget[i]));
        });
        print('Data : $jsonget');
      }

     }

   }catch(e)
   {
    print(e);
   }

  }

 Future<List<Post>> postsFuture = getPosts();
  
static Future<List<Post>> getPosts() async {
  var url = Uri.parse("https://jsonplaceholder.typicode.com/albums/1/photos");
  final response = await http.get(url, headers: {"Content-Type": "application/json"});
  final List body = json.decode(response.body);
  return body.map((e) => Post.fromJson(e)).toList();
}


//  Future<List<DataModel>> historyFuture = _getHistory();

  

Future <List<DataModel>>   _getHistory() async{
  
    

    var url=(NamaServer.server+'tests/flutter/map1/history.php');

    final response = await http.get(Uri.parse(url).replace(queryParameters: {'imeino':ambilid}));
    
 
   final data = (json.decode(response.body)['data'] as List)
                     .map((json) =>DataModel.fromJson(json))
                     .toList();
   return data;                  
 
  //  //var url = Uri.parse("https://jsonplaceholder.typicode.com/albums/1/photos");
  // final response = await http.get(url, headers: {"Content-Type": "application/json"});
  // final List body = json.decode(response.body)['data'];

  // return body.map((e) => DataModel.fromJson(e)).toList();                     
   
  }

   

   _getDelete(String keyno) async{
  
    //List<DataModel> _data = [];

    var url=(NamaServer.server+'tests/flutter/map1/delete.php');

     await http.get(Uri.parse(url).replace(queryParameters: {'keyno':keyno}));
    
                  

  //  //var url = Uri.parse("https://jsonplaceholder.typicode.com/albums/1/photos");
  // final response = await http.get(url, headers: {"Content-Type": "application/json"});
  // final List body = json.decode(response.body)['data'];

  // return body.map((e) => DataModel.fromJson(e)).toList();                     
   
  }

 
  Future <void> getData() async {
    await Provider.of<MapDatas>(context,listen:false).getHistoryCari(ambilid.toString(),_cari.text);
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
    
      resizeToAvoidBottomInset: false,
     appBar: AppBar(title: Center(child:Text("History",style: TextStyle(color: Colors.white),),),
     backgroundColor: Colors.blueAccent,
     
     ),
     body: 
  SingleChildScrollView( 
  child:    
     Column(
children: [
 

Container(
  margin: EdgeInsets.all(10),
child: 
Form(
  
  child: 
TextFormField(
  
  onChanged: (value) {
    final SnackBar1 = SnackBar(content: Text(value));
    //ScaffoldMessenger.of(context).showSnackBar(SnackBar1);
    setState(() {
      _cari.text=value;
    });
    Provider.of<MapDatas>(context,listen: false).getHistoryCari(ambilid.toString(), value);
  },
  decoration: InputDecoration(
  //hintStyle: TextStyle(fontSize: 8),  
  
  hintText:"Search of Places/Streets",
  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
  
  ),
controller: _cari,
),

),
),

 
 

Container(
 height: MediaQuery.of(context).size.height/1.5,
 //height: 100,
   
  child: 
  FutureBuilder(
        future: Provider.of<MapDatas>(context,listen:false ).getHistoryCari(ambilid.toString(),_cari.text),
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
                          NamaServer.server+'tests/flutter/map1/images/'+datafinal[index].imei_no!+"/"+datafinal[index].image!,
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
                        title: Text(datafinal[index].title!,overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.black45,fontWeight: FontWeight.bold),),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(onPressed: () {
                              showDialog(context: context, builder:(context) {
                                return AlertDialog(
                                  title: Text("Data"),
                                  content: Text("Delete This Data ?"),
                                  actions: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                      ElevatedButton(onPressed: () {
                                        Provider.of<MapDatas>(context,listen:false).getDelete(datafinal[index].idno.toString());
                                         getData();
                                        Navigator.of(context).pop();
                                       
                                        
                                      }, child: Text("Yes")),
                                      SizedBox(width: 5,),

                                       ElevatedButton(onPressed: () {
                                        Navigator.of(context).pop();
                                      }, child: Text("No")),

                                    ],)
                                  ],
                                );
                              },);
                            },
                            icon: Row(
                              children: [
                                Icon(Icons.delete),
                                Text("Delete",style: TextStyle(color: Colors.pink,fontWeight: FontWeight.bold),),
                              ],
                            ),

                            ),
                            
                              SizedBox(width: 5,),

                             IconButton(onPressed: () {
                              Navigator.push(context,MaterialPageRoute(builder: (context) => Homepage2(latx: datafinal[index].map_lat, longx: datafinal[index].map_long, gambar: datafinal[index].image, imeino: ambilid.toString()),));
                            }, icon: Row(
                              children: [
                              Icon(Icons.directions),
                              Text("Go To",style: TextStyle(color: Colors.pink,fontWeight: FontWeight.bold))
                              ]
                              )), 
                           

                          ],
                        )
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
)
  //singlechild
],

     )
 
    )
 
     
     ),

 
    
   
    );

    
  }





Widget buildHistory(List<DataModel> history) {
  return ListView.builder(
    itemCount: history.length,
    itemBuilder: (context, index) {
      final post = history[index];

      return Container(
        margin: EdgeInsets.only(left: 10,right: 10,bottom: 9,top:5),
        
        height: MediaQuery.of(context).size.height/6.5,
         
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Colors.white,Colors.blueAccent
            ]),
          borderRadius: BorderRadius.circular(5),
          border: Border.all(style: BorderStyle.solid),
          boxShadow: [
         
            BoxShadow(
              color: Colors.white,
              offset: Offset(2, 2),
              spreadRadius: 2,
              blurRadius: 2
            ),
             BoxShadow(
                color: Colors.black,
              offset: Offset(2, 2),
              spreadRadius: 2,
              blurRadius: 2
            )
          ]
        ),
      
        child:Row(
        //  mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
          
        
        Container(
          margin: EdgeInsets.all(5),
width: 70,
height: 70,
          clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10)
        ),  
          child: 
        Image.network(fit: BoxFit.cover,height:150,width: 50,'https://irawan.angsoft.info/tests/flutter/map1/images/'+post.imei_no!+"/"+post.image!),
        ),
        
        
        
  Expanded(child:     
 Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [ 

  
Column(children: [
Text(post.title!,overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 12),),
Text(post.tgl_rec!,style: TextStyle(fontSize: 10),textAlign: TextAlign.center,)
],),
    
         Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
             IconButton(onPressed: () {
           
          //Navigator.push(context, MaterialPageRoute(builder: (context) => TestPage(datakirim: post.keyno!,),));
         Navigator.push(context, MaterialPageRoute(builder: (context) => Homepage2(latx: post.map_lat,longx: post.map_long,gambar: post.image,imeino:post.imei_no ,)));
        }, icon: Row(children: [Icon(Icons.directions), SizedBox(width:5 ,),Text("View")],)),

        IconButton(onPressed: () {

showDialog(context: context, builder: (context) {
  return AlertDialog(
    title: Text("Delete this Data ?"),
    actions: [
      Row(
        children: [
          MaterialButton(
            child: Text("Yes"),
            onPressed: () {
            _getDelete(post.keyno!);
           _getHistory();
        //  Navigator.push(context, MaterialPageRoute(builder: (context) => History1(),))  ;
  Navigator.pushNamed(context,History1().toString())  ;


  
            
          },)
,
          MaterialButton(
            child: Text("No"),
            onPressed: () {
            
            Navigator.pop(context);
          },)
        ],
      )
    ],
  );
},);

            
        }, icon: Row(children: [Icon(Icons.delete), SizedBox(width:5 ,),Text("Delete")],)),


          ],
        )
       





        ]
        ),


  ),

          ]
        ),

      );

      
    },
  );
}


Widget buildPosts(List<Post> posts) {
  return ListView.builder(
    itemCount: posts.length,
    itemBuilder: (context, index) {
      final post = posts[index];
      return Container(
        color: Colors.grey.shade300,
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        height: 100,
        width: double.maxFinite,
        child: Row(
          children: [
            Expanded(flex: 1, child: Image.network(post.url!)),
            SizedBox(width: 10),
            Expanded(flex: 3, child: Text(post.title!)),
          ],
        ),
      );
    },
  );
}


Widget listHistory1(){

return Container(

child: FutureBuilder<List<DataModel>>
(future: _getHistory(), 
builder: (context, snapshot) {
  
  if (snapshot.hasData)
  {
    return Text(snapshot.data.toString());
    // return ListView.builder(
    //   itemCount: snapshot.data!.length,
    //   itemBuilder: (context, index) {
    //     final data=snapshot.data![index];
    //     return ListTile(
    //       leading: Text(data.title.toString()),
    //     );
    //   },);
  }else{
    return Center(child: CircularProgressIndicator(),);
  }

},),

);

}
 

 

   Widget DropdownHistory(){
    return Padding(padding: EdgeInsets.all(5),
    
    child: DropdownButtonFormField(
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
      isExpanded: true,
      hint: Text("Pilih Pendidikan"),
      items:listHistory.map((data) => DropdownMenuItem(
        child: Text(data.title.toString()),
        value: data.title.toString(),
        
        )).toList()
     
     
     
     , 
     
     
     
     onChanged:(value) {
       setState(() {
         txtTampung1=value;
       });
     }, 
     
     ),
     

    
    );


   }



}


