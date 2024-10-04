import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_attendance_current/components/hrdcoordinate_sub.dart';
import 'package:flutter_attendance_current/components/orientation.dart';
import 'package:flutter_attendance_current/message/warning.dart';
import 'package:flutter_attendance_current/provider/mapdatas.dart';
import 'package:provider/provider.dart';

class Hrd_Coordinate_set extends StatefulWidget {
  const Hrd_Coordinate_set({super.key});

  @override
  State<Hrd_Coordinate_set> createState() => _Hrd_Coordinate_setState();
}

class _Hrd_Coordinate_setState extends State<Hrd_Coordinate_set> {

  final _Text_lat1=TextEditingController();
  final _Text_lat2=TextEditingController();
  final _Text_long1=TextEditingController();
  final _Text_long2=TextEditingController();
  final _Text_homebase=TextEditingController();

  @override
  void dispose() {
 SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
  ///  getLandscapeCentral();
    getRefreshData();
    // TODO: implement initState
    super.initState();
  }

  getRefreshData() async{
    Provider.of<MapDatas>(context,listen: false).getList_Coordinate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Coordinate Location",style: TextStyle(color: Colors.white),
        
        ),
        backgroundColor: Colors.blue ,
        foregroundColor: Colors.white,
        actions: [
          IconButton(onPressed: () {
            
          }, icon: Icon(Icons.add,size: 30,))
        ],
        ),
        
        body: SingleChildScrollView(
          child:
          
          Column(children: [

         
           Row(
                      children: [
                        Expanded(child: 
                        Container(
                          padding:  EdgeInsets.only(left: 5,right: 5,top: 10,bottom: 10),
                          decoration: BoxDecoration(
                              color: Colors.green,
                              border: Border.all(style: BorderStyle.solid,color: Colors.white)
                              
                          ),
                          child: 
                            Text('Latitude ',style: TextStyle(color: Colors.white),),
                        ),
                        ),


                      Expanded(child: 
                        Container(
                          padding:  EdgeInsets.only(left: 5,right: 5,top: 10,bottom: 10),
                          decoration: BoxDecoration(
                              color: Colors.green,
                              border: Border.all(style: BorderStyle.solid,color: Colors.white)
                              
                          ),
                          child: 
                            Text('Longitude ',style: TextStyle(color: Colors.white),),
                        ),
                        ),

                        Expanded(child: 
                        Container(
                          padding:  EdgeInsets.only(left: 5,right: 5,top: 10,bottom: 10),
                          decoration: BoxDecoration(
                              color: Colors.green,
                              border: Border.all(style: BorderStyle.solid,color: Colors.white)
                              
                          ),
                          child: 
                            Text('Home Base ',style: TextStyle(color: Colors.white),),
                        ),
                        ),
 
                     
                 

                      ]
                        ),

                     
         

          
          Container(  
            height: MediaQuery.of(context).size.height,
          child: 
               Consumer<MapDatas>(builder: (context, provx, child) {
                 return ListView.builder(
                  itemCount: provx.globallistgoogle.length,
                  itemBuilder: (context, i) {
                    return Container(
                     
                     child:
                     
                     Column(children: [
                      
                     GestureDetector(
                      child: 
                      Row(
                      children: [
                        Expanded(child: 
                        Container(
                          padding:  EdgeInsets.only(left: 5,right: 5,top: 10,bottom: 10),
                          decoration: BoxDecoration(
                              color: Colors.black,
                              border: Border.all(style: BorderStyle.solid,color: Colors.white)
                              
                          ),
                          child: 
                            Text(provx.globallistgoogle[i].lat1.toString(),style: TextStyle(color: Colors.white),),
                        )
                        ),
                         Expanded(child: 
                           Container(
                              padding: EdgeInsets.only(left: 5,right: 5,top: 10,bottom: 10),
                          decoration: BoxDecoration(
                              color: Colors.black,
                              border: Border.all(style: BorderStyle.solid,color: Colors.white)
                              
                          ),
                            child: 
                            Text(provx.globallistgoogle[i].long1.toString(),style: TextStyle(color: Colors.white),),
                        )
                        ),

                        Expanded(child: 
                           Container(
                              padding:  EdgeInsets.only(left: 5,right: 5,top: 10,bottom: 10),
                          decoration: BoxDecoration(
                              color: Colors.black,
                              border: Border.all(style: BorderStyle.solid,color: Colors.white)
                              
                          ),
                            child: 
                            Text(provx.globallistgoogle[i].homebase!,style: TextStyle(color: Colors.white),)),
                        ),

                      
                      
                      
                      ],
                     ),
                     onTap: () {
                       setMessage2(provx.globallistgoogle[i].idno.toString());
                       Navigator.push(context, MaterialPageRoute(builder: (context) => HrdcoordinateSub(idno: provx.globallistgoogle[i].idno!, homebase: provx.globallistgoogle[i].homebase!),));
                     },

                     )
                     ])
                    );
                   
                 },);
               },) 

           
           
          
        ),
          ]
        )
        )
    );
  }

  
}