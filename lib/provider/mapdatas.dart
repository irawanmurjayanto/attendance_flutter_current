

import 'package:flutter_attendance_current/components/server.dart';
import 'package:flutter_attendance_current/datamodel/history.dart';
import 'package:flutter_attendance_current/datamodel/listsection.dart';
import 'package:flutter_attendance_current/message/warning.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:io';
import 'package:just_audio/just_audio.dart';
 

class MapDatas with ChangeNotifier {
 
List<DataModel> _datamap=[];
List<DataModel> get datamap => _datamap;

// Future<void> getHistoryC(String imeino) async{

// var url=Uri.parse(NamaServer.server+'tests/flutter/map1/history.php');

// final response=await http.post(
//   url,
  
//   body: {
//     'tipe':'lihat',
//     'imeino':imeino,
//   }
  
//   ); 


 
//   final json=jsonDecode(response.body)['data'] as List;

//   final datajson=json.map((e) => DataModel.fromJson(e)).toList();
//   _datamap=datajson;

//   notifyListeners();
  


// }


Future <void> getHistoryCari (String imeino) async {
  _datamap.clear();
  var url=Uri.parse(NamaServer.server+'hrd/newloaddataatt_paris_flut.php');

final response=await http.post(
  url,
  body: {
    'macadd':imeino,
  }
  
  );
   print(response.body);
  final json=jsonDecode(response.body)['data'] as List;
  final newData=json.map((e) =>  DataModel.fromJson(e)).toList();

  _datamap=newData;
  notifyListeners();
                

}

Future <void> getDelete(String idnoval) async{
  var url=Uri.parse(NamaServer.server+'tests/flutter/map1/history.php');

  final response=await http.post(
    url,
     body: {
      'tipe':'hapus',
      'idno':idnoval
     }
    
    );

    // if (response.statusCode==200)
    // {
    //   print(response.body);
      
    // }
 
notifyListeners();
}

Future <void> provEmpReg(BuildContext context,String nik,String macadd) async{
  var url=Uri.parse(NamaServer.server+'hrd/new_savereg_flut.php');

  final response=await http.post(
    url,
    body: {
       'nik':nik,
       'macadd':macadd
    } 
  ); 

  final json =jsonDecode(response.body);
  if (response.statusCode==200)
  {
     if(json['errormsg']=='fail')
     {
       Fluttertoast.showToast(
        msg: "NIK Sudah Terdaftar,mohon hubungi HRD",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );

     }else
     {
       Fluttertoast.showToast(
        msg: "NIK Sukses Terdaftar",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
       );
     }
  }

}



 
 
Future <void> saveImageMapxx(BuildContext context,image,String macadd,String lok,String absen) async {
       
       EasyLoading.show(status:"Processing...");
      
    
       var url = Uri.parse(NamaServer.server+'hrd/newsaveatt_flut2.php');


 
//  EasyLoading.show(status: "Saving Data..");

   
     

      final response = await http.post(
          url,
          body: {
            'macadd':macadd,
            'location':lok,
            'absen':absen,
            'image':image,

         }
          
      );

     final json = jsonDecode(response.body);
        if (response.statusCode==200)
        {
         print(json);

          if (json['detek']=='sudahabsen') {

             Fluttertoast.showToast(
              msg: "Anda sudah Absen MASUK hari ini jam "+json['jam'],
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
              );
              return;
          }      



         if (json['errormsg']=='fail') 
         {
        
              Fluttertoast.showToast(
              msg: "NIK Anda belum terdaftar,Mohon hubungi HRD",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0
              );
              return;
            
          }

          //sound farewell  
          final player = AudioPlayer();    
          if (absen=='MASUK')
          {
             player.setAsset('assets/sound/feramasuk.mpeg');
             player.play(); 
          }else
          {
             player.setAsset('assets/sound/ferakeluar.mpeg');
             player.play();

          }

          
          //player.play(AssetSource('audio/bell.mpeg'));
         
        EasyLoading.dismiss();
        
         showDialog(context: context, builder: (context) {
           return AlertDialog(
              content:
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black ,
                      borderRadius: BorderRadius.circular(5) 
                    ),
                    child:  Text(json['message'],textAlign: TextAlign.center,style: TextStyle(fontWeight:FontWeight.bold,color: Colors.white),), 
                  ),
                  
                  SizedBox(height: 5,),
                  Text(json['nama'],textAlign: TextAlign.center,style: TextStyle(fontWeight:FontWeight.bold)),
                  Text('('+json['nik']+'/'+json['section']+')',style: TextStyle(fontWeight:FontWeight.bold),),
                  Text("Status :",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold),),
                  Text(json['absen']+'/'+json['jam'],textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              
               
            actions: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: () {
                    Navigator.pop(context);
                  }, child: Text("Close"))
                ],
              )
            ],
           );
         
         },
         
         );
        //  EasyLoading.dismiss(); 
        }
 
   
    
      }

   List <hrdsection> _gethrdsection=[];
   List <hrdsection> get globalhrdsection=>_gethrdsection;

  Future <void> getListSection() async{

      var url=Uri.parse(NamaServer.server+"hrd/carisection.php");

      final response=await http.post(
        url,
        
      );   

      if (response.statusCode==200)
      {
        final json=jsonDecode(response.body)['data'] as List;
        final _newData=json.map((e) => hrdsection.fromJson(e)).toList();
        _gethrdsection=_newData;
      } 
      notifyListeners();
  }   

}