 

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_attendance_current/components/hrd_data_detail.dart';
import 'package:flutter_attendance_current/message/warning.dart';
import 'package:flutter_attendance_current/provider/mapdatas.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'dart:async';

class Hrd_Data extends StatefulWidget {
  const Hrd_Data({super.key});

  @override
  State<Hrd_Data> createState() => _Hrd_DataState();
}

class _Hrd_DataState extends State<Hrd_Data> {


  
//  Timer? _timer;
//   late double _progress;
// @override
//   void initState() {
    
//          EasyLoading.addStatusCallback((status) {
//       print('EasyLoading Status $status');
//       if (status == EasyLoadingStatus.dismiss) {
//         _timer?.cancel;
//       }
//     });
//     EasyLoading.showSuccess('Use in initState');   
//     // TODO: implement initState
//     super.initState();
//   }

final _TextCariNIK=TextEditingController();



 


  getSearchNIK() async{
    _TextCariNIK.text='';
    Provider.of<MapDatas>(context,listen: false).getListPerson_manualatt(_TextCariNIK.text);
    showDialog(context: context,
     builder: (context) {
       return SingleChildScrollView(
        child: 
       
       AlertDialog(
        title: Text("Data Search"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _TextCariNIK,
              decoration: InputDecoration(
                hintText: "Personal Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(style: BorderStyle.solid)
                )
              ),
              onChanged: (value) {
                
                Provider.of<MapDatas>(context,listen: false).getListPerson_manualatt(value);

              },
            ),


                SizedBox(height: 5,),
         Container(
          decoration: BoxDecoration(
              border: Border.all(style: BorderStyle.solid)
          ),
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height/2.5,
              child: Consumer<MapDatas>(builder: (context, prov, child) {
               return  ListView.builder(
                  itemCount: prov.globalperson_manualatt.length,
                  itemBuilder: (context, i) {
                    return ListTile(
                        title: 
                        GestureDetector(
                         child: 
                                  Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(style: BorderStyle.solid,color: Colors.brown),
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.blue
                          ),
                  
                          child: Text
                        (prov.globalperson_manualatt[i].nama_person!+"("+prov.globalperson_manualatt[i].nik!+")",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold,color: Colors.white)),
                        ),

                          
                          onTap: () {
                              getStatusInet(context);
                              EasyLoading.show(status: 'Processing...');
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Hrd_Data_Detail_Search(NIK: prov.globalperson_manualatt[i].nik!),));
                              
                        
                                                    //  setMessage2(prov.globalperson_manualatt[i].nik!);
                          },
                        
                        
                        ),
                        );
 
                },);
                
              },),
            ),
          ),
         )
          ],
        )
       ),
       );
     },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Personal Data",style: TextStyle(color: Colors.white,),),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        // actions: [
        //   IconButton(onPressed: () {
        //      //Navigator.push(context, MaterialPageRoute(builder: (context) => Hrd_Data_Detail_Search(NIK: 'testnik',)));
        //   }, icon:Icon(Icons.abc))
        // ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        
        children: [
          GestureDetector(
            child: 
          MainMenu("personaldata.png", "Personal Data")      ,
          onTap: () {
            getSearchNIK();
          },
          )
        ],
      ),
    );
  }

  Widget MainMenu(String pict, String title) {
    return  
        Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            border: Border.all(style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(7)

          ),  
               
         child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
             // clipBehavior: Clip.antiAlias,
             decoration: BoxDecoration(
              border: Border.all(style: BorderStyle.solid,color: Colors.grey),
              shape: BoxShape.circle
             ),
              
             padding: EdgeInsets.all(1),
             
              child: 
               CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage("assets/images/$pict"),
              
               ),
            ),    
           

            SizedBox(height: 5,),
            Text(title,style: TextStyle(fontSize: 12),),
          ],
         ),

        
       
    );
  }
}
