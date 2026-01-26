import 'package:flutter/material.dart';
import 'package:flutter_attendance_current/components/historycutidetail.dart';
import 'package:flutter_attendance_current/components/server.dart';
// import 'package:flutter_attendance_current/datamodel/history.dart';
// import 'package:flutter_attendance_current/datamodel/listpend.dart';
// import 'package:flutter_attendance_current/datamodel/post.dart';
// import 'package:flutter_attendance_current/main.dart';
import 'package:flutter_attendance_current/provider/mapdatas.dart';
 
// import 'package:flutter_attendance_current/route/routemap.dart';
import 'package:flutter/services.dart';

import 'dart:io'; 
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
 
  import 'package:http/http.dart' as http;
     import 'dart:convert';
 import 'package:flutter_typeahead/flutter_typeahead.dart';    
 import 'package:get_storage/get_storage.dart';




class HistoryCutiMainMenu extends StatelessWidget {
   final String nik;
   final String nama;
  const HistoryCutiMainMenu({Key?key,required this.nik,required this.nama}):super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
    debugShowCheckedModeBanner: false,
      home: HistoryCutiMainMenu1(nik: nik, nama: nama)
    );
  }
}


class HistoryCutiMainMenu1 extends StatefulWidget {
   
final String nik;
final String nama;

  const HistoryCutiMainMenu1({Key?key,required this.nik,required this.nama})  ;


 


  @override
  State<HistoryCutiMainMenu1> createState() => _HistoryCutiMainMenu1State(nik:nik,nama:nama );
}

class _HistoryCutiMainMenu1State extends State<HistoryCutiMainMenu1> {
 
final String nik;
final String nama;

  _HistoryCutiMainMenu1State({Key?key,required this.nik,required this.nama})  ;


 bool isLoading=true;
 
  String? txtTampung1;
  String _platformVersion = 'Unknown';
  String? deviceImei;
  String? type;
  String message = "Please allow permission request!";
 
  bool getPermission = false;
  bool isloading = false;
   
  TextEditingController _cari=TextEditingController();
 
    static DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy').format(now);

 

 DeviceInfoPlugin androidDeviceInfo = DeviceInfoPlugin();
 
 
  
  
  final box=GetStorage();
 //n2

 /*
 Future <void> getRefreshdata() async{
  Provider.of<MapDatas>(context,listen:false ).getHistoryCuti(box.read("imei").toString());
 }
*/

  


 Future <dynamic> getFormatDate() async{
 // final String tglnow=DateFormat('dd-MM-yyyy').format(DateTime.parse(tgl));
    DateTime now = DateTime.now();
    String formattedDate = '${now.day}/${now.month}/${now.year}';
    return formattedDate;
   
}
 
  @override
  void initState() {
  
    super.initState();
   //getRefreshdata();
 
 
   
  }


  @override
  Widget build(BuildContext context) {

 

    return
    PopScope(
     canPop: true,
  onPopInvoked : (didPop){
   // logic
  },
    child: 
    
     Scaffold(
    
     appBar: AppBar(title: Text("History Absen "+nama+"("+nik+")",style: TextStyle(fontWeight:FontWeight.bold,fontSize:14 ),textAlign: TextAlign.left,),
     backgroundColor: Colors.blueAccent,
     foregroundColor: Colors.white,
     ),
     body:Container(
      width: MediaQuery.of(context).size.width,
      color: Color.fromARGB(255, 233, 214, 214),
  
      child: 
      Column(

      
        
        children: [

           
            Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             
                Container(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    children: [
                        SizedBox(height: 5,),
                        GestureDetector(
                        child: 
                      Container(
                        width: MediaQuery.of(context).size.width-10,
                        decoration: BoxDecoration(color: Colors.black),
                        padding: EdgeInsets.only(top: 5,left: 10,bottom: 5,right: 5),
                        child: Text(
                          'Cuti',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                        ),                                                                  
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => HistoryCutiDetail(nik:nik, ket: 'cuti'),));
                      },
                        ),
                      SizedBox(height: 5,),
                      GestureDetector(
                        child: 
                         Container(
                          width: MediaQuery.of(context).size.width-10,
                             decoration: BoxDecoration(color: Colors.black),
                           padding: EdgeInsets.only(top: 5,left: 10,bottom: 5,right: 5),
                        child: Text(
                          'Sakit',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                        ),                                                                  
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => HistoryCutiDetail(nik: nik, ket: 'Sakit'),));
                      },
                      ),
                        SizedBox(height: 5,), 
                      GestureDetector(
                        child:   
                         Container(
                           width: MediaQuery.of(context).size.width-10,
                             decoration: BoxDecoration(color: Colors.black),
                          padding: EdgeInsets.only(top: 5,left: 10,bottom: 5,right: 5),
                        child: Text(
                          'Izin',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                        ),                                                                  
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => HistoryCutiDetail(nik: nik, ket: 'izin'),));
                      },
                      )

                    ],
                  ),
                )
              ],
             ),

        /*    
             SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height/1.4,
                 child: 
                 RefreshIndicator(onRefresh: () => getRefreshdata(),
                child: 
                FutureBuilder(future: Provider.of<MapDatas>(context,listen: false).getHistoryCuti(box.read("imei").toString())
                , builder: (context, snapshot) {
                   if (snapshot.connectionState==ConnectionState.waiting)
                   {
                    return Center( child:CircularProgressIndicator());
                   }else{
                    return Consumer<MapDatas>(builder: (context, prov, child) {
                    return ListView.builder(
                      itemCount: prov.datamap.length,
                      itemBuilder: (context, i) {
                        return Card(
                          margin: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                            clipBehavior: Clip.antiAlias,
                          child: 
                            Padding(padding: EdgeInsets.all(10),
                            child: 
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                        
                  /*          
                          Container(
                            height: 50,
                            width: 50,
                          decoration: BoxDecoration(
                          border: Border.all(style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(10),
                           
                           
                        ),  
                            clipBehavior: Clip.antiAlias,
                            child: Image==isLoading?Center(child: CircularProgressIndicator(),):
                            Image.network(
                            height: 50,width: 50,
                            fit: BoxFit.fill,
                            NamaServer.server+'hrd/uploademp/'+prov.datamap[i].pict_att!+".jpg",
                            frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                              return child;
                            },
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress==null)
                              {
                                return child;
                              }else{
                                return Center(child: CircularProgressIndicator(),);
                              }
                            },
                            ),
                           
                          ),
                          //n1
                          
                          SizedBox(width: 5,),
*/
                          Column(
                           
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomLeft,
                                    end: Alignment.topRight,
                                    colors: [Colors.black,Colors.black])
                                ),
                                child: 
                              Text(prov.datamap[i].absen!+"/"+prov.datamap[i].tglrec!,style: TextStyle(color: Colors.white),),
                              ),
                              Text(prov.datamap[i].nama!+"/"+prov.datamap[i].nik!)


                            ],
                          )
                          

                        
                          ]
                          )
                            )
                        );
                    },);
                  }
                  );
                   }
                },
                ),
              ),
             )
             ) 
*/
          ]
          )
         )
        )    
      );

 
 
 
 

 
    
 

  
  }


Widget showDateDetail(String tgl,String Absen) {
  final _tempDate=TextEditingController();
   String formatdate=tgl;
 _tempDate.text=Absen+" / "+formatdate;
  //final String formatdate=tgl;
  
  return Padding(padding: EdgeInsets.all(5),
      child: TextField(
        controller: _tempDate,

      ),
  );
}   
 
// Widget dataAll(){
// return

// SingleChildScrollView( 
//   child:    
//      Column(
// children: [
 

// Container(
 
//   margin: EdgeInsets.all(10),
// child: Text("Last 30 Records",textAlign:TextAlign.center),

 
// ),

 


// Container(
// height: MediaQuery.of(context).size.height/1.5,
  
//  color: Colors.blue,   
//   child: RefreshIndicator(
//     onRefresh:() => 
//     //getRefreshdata(),
    
    
//     child: 

      
//   FutureBuilder(
//         future: Provider.of<MapDatas>(context,listen:false ).getHistoryCari(box.read("imei").toString()),
//         builder: 
//         (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//               // until data is fetched, show loader
//               return Center(child:CircularProgressIndicator() ,) ;
//             } else  { 
//               // once data is fetched, display it on screen (call buildPosts())
             
//               return  Padding(
//                 padding: EdgeInsets.all(10),
              
//                   child:   Consumer<MapDatas>(builder: (context, value, child) {
//                     final datafinal=value.datamap;
//                     return ListView.builder(
//                       itemCount: datafinal.length,
//                       itemBuilder: (context, index) {
//                       return 
//                       Container(
//                         margin: EdgeInsets.only(bottom: 15),
                    
//                       decoration: BoxDecoration(
//                       border: Border.all(style: BorderStyle.solid,color: Colors.lightBlueAccent),
//                       borderRadius: BorderRadius.all(Radius.circular(10)),  
//                       gradient: LinearGradient(colors: [
                        
//                         Colors.white,Colors.lightBlueAccent
//                       ],
//                       begin: Alignment.bottomLeft,
//                       end: Alignment.topRight,
                      
//                       ),
//                       boxShadow: [
//                         BoxShadow(
//                           offset: Offset(3, 3),
//                           spreadRadius: 3,
//                           blurRadius:3,
//                                color: Colors.black26
//                         ),
//                       BoxShadow(
//                           offset: Offset(2, 2),
//                           spreadRadius: 2,
//                           blurRadius: 2,
//                           color: Colors.white
//                         ),
//                       ]
//                       ),
//                       child: 
//                       ListTile(

//                         leading: Container( 
                          
                         
//                         decoration: BoxDecoration(
//                           border: Border.all(style: BorderStyle.solid),
//                           borderRadius: BorderRadius.circular(10),
                           
                           
//                         ),  
//                         clipBehavior: Clip.antiAlias,
//                         child: Image==isLoading?Center(child: CircularProgressIndicator(),):
//                          Image.network(
                            
//                           width: 50,
//                           height: 70,
//                           fit: BoxFit.fill,
//                           NamaServer.server+'hrd/uploademp/'+datafinal[index].pict_att!+".jpg",
//                           frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
//                             return child;
//                           },
//                           loadingBuilder: (context, child, loadingProgress) {
//                             if (loadingProgress==null)
//                             {
//                               return child;
//                             }else{
//                              return Center(child: CircularProgressIndicator(),);
//                             }
//                           }, 
//                         ),
                        
                        
                        
                        
//                         ),
//                         title: Text(datafinal[index].nama!+"("+datafinal[index].nik!+")",overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.black45,fontWeight: FontWeight.bold),),
//                         subtitle: Text(datafinal[index].tglrec!
//                       ),
//                       ),
//                     );
//                     },);
//                   },)

//                 );

//             }
//             // } else {
//             //   // if no data, show simple Text
//             //   return const Text("No data available");
//             // }
//         },)


 
//    ),
  
  
// )
//   //singlechild
// ],

//      )
 
//     );



// }



 
    



}


