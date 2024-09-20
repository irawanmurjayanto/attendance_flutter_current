

import 'package:flutter_attendance_current/components/attreport.dart';
import 'package:flutter_attendance_current/components/hrd_attmanual.dart';
import 'package:flutter_attendance_current/components/hrd_data.dart';
import 'package:flutter_attendance_current/components/server.dart';
import 'package:flutter_attendance_current/datamodel/history.dart';
import 'package:flutter_attendance_current/datamodel/hrd_data_model.dart';
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


Future <void> saveImageByNIK(BuildContext context,nik,image) async {
       getStatusInet(context);
       EasyLoading.show(status:"Processing...");
       var url = Uri.parse(NamaServer.server+'hrd/newsaveatt_flut2_nik.php');

       var response=await http.post(
        url,
        body: {
         'nik':nik,
         'image':image, 
        }
        
        );
        
        if (response.statusCode==200)
        {
          final json=jsonDecode(response.body);
          if (json['message']=='success')
          {
                setMessage2("Photo Upload Succesfully");

          }
        }

        notifyListeners();
     

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
               EasyLoading.dismiss();
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

               EasyLoading.dismiss();
            
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
    EasyLoading.show(status: "Processing..");
    _gethrdsection.clear();
    _getdatasection.clear();
  
    //_getpersonsection.clear();

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
      EasyLoading.dismiss();
  } 


   List <Status_HRD> _getstatushrd=[];
   List <Status_HRD> get globalstatushrd=>_getstatushrd;

 Future <void> getStatus_HRD(context,String tipe) async{
  getStatusInet(context);

  var url=Uri.parse(NamaServer.server+'hrd/status_hrd.php');

  var response=await http.post(url,
  body: {
    'tipe':tipe
  }
  );

    if (response.statusCode==200)
    {
      final json=jsonDecode(response.body)['data'] as List;
      final newData=json.map((e) => Status_HRD.fromJson(e)).toList();
      _getstatushrd=newData;
    }
     notifyListeners();
 }



   List <DataBySection_person> _getpersonsection=[];
   List <DataBySection_person> get globalpersonsection=>_getpersonsection;

 Future <void> getListPerson(String section) async{
    _getpersonsection.clear();
    _getdatasection.clear();

      var url=Uri.parse(NamaServer.server+"hrd/cariperson.php");

      final response=await http.post(
        url,
        body: {
          'section':section
        }
        
      );   

      if (response.statusCode==200)
      {
        final json=jsonDecode(response.body)['data'] as List;
        print(json);
        final _newData=json.map((e) => DataBySection_person.fromJson(e)).toList();
        _getpersonsection=_newData;
      } 
      notifyListeners();
  } 

List<HRD_Detail_Personal> _gethrddetail_personal=[];
List<HRD_Detail_Personal> get getglobalhrddetail_personal=>_gethrddetail_personal;

Future <void> getListPersonAll(context,String nik) async{
  getStatusInet(context);
  EasyLoading.show(status: 'Processing...');
    _gethrddetail_personal.clear();
  

      var url=Uri.parse(NamaServer.server+"hrd/cariperson_all_flut.php");

      final response=await http.post(
        url,
        body: {
          'nik':nik
        }
        
      );   

      if (response.statusCode==200)
      {
        final json=jsonDecode(response.body)['data'] as List  ;
        print('datanya : '+json.toString());
       // setMessage2('masuk');
        final _newData=json.map((e) => HRD_Detail_Personal.fromJson(e)).toList();
        _gethrddetail_personal=_newData;
      } 
     notifyListeners();
  } 


 List <DataBySection_person> _getperson_manualatt=[];
   List <DataBySection_person> get globalperson_manualatt=>_getperson_manualatt;

 Future <void> getListPerson_manualatt(String nama) async{
    _getperson_manualatt.clear();
   

      var url=Uri.parse(NamaServer.server+"hrd/cariperson_flut.php");

      final response=await http.post(
        url,
        body: {
          'nama':nama
        }
        
      );   

      if (response.statusCode==200)
      {
        final json=jsonDecode(response.body)['data'] as List;
        print(json);
        final _newData=json.map((e) => DataBySection_person.fromJson(e)).toList();
        _getperson_manualatt=_newData;
      } 
      notifyListeners();
  } 


Future <void> getCheckHak(String macadd,BuildContext context,String menu) async{

      

      var url=Uri.parse(NamaServer.server+"hrd/newcheckpersonal.php");

      final response=await http.post(
        url,
        body: {
          'macadd':macadd,
        }
        
      );   

      if (response.statusCode==200)
      {
        final json=jsonDecode(response.body);
        if(json['errormsg']=='failed')
        {
          
              Fluttertoast.showToast(
              msg: "Anda tidak berhak atas module ini",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
              );
              EasyLoading.dismiss();
              return;
        } else if (((json['errormsg']==1)||(json['errormsg']==3))  & (menu=='1'))
        {
           Navigator.push(context,MaterialPageRoute(builder: (context) => AttbySection()));
        }else if (((json['errormsg']==1)||(json['errormsg']==3))  & (menu=='2'))
        {
           Navigator.push(context,MaterialPageRoute(builder: (context) => HRD_Att_Manual()));
        }
        else if (((json['errormsg']==3)) & (menu=='3'))
        {
           Navigator.push(context,MaterialPageRoute(builder: (context) => Hrd_Data()));
        }else{

           Fluttertoast.showToast(
              msg: "Anda tidak berhak atas module ini",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
              );
              EasyLoading.dismiss();
              return;

        }

         EasyLoading.dismiss();
      } 
      notifyListeners();
  } 


List<DataBySection> _getdatasection=[];
List<DataBySection> get getglobal_datasection =>_getdatasection;

Future <void> getDataBySection(String tgl1,String tgl2,String locatt,String nik) async{

      _getdatasection.clear();

      var url=Uri.parse(NamaServer.server+"hrd/newloaddataatt_parisbysection_flut.php");

      final response=await http.post(
        url,
        body: {
          'tgl1':tgl1,
          'tgl2':tgl2,
          'locatt':locatt,
          'nikperson':nik,
        }
        
      );   

      //     print(tgl1+'/'+tgl2+'/'+locatt);

        if (response.statusCode==200)
       {
        final json=jsonDecode(response.body)['data'] as List;
        //final json=jsonDecode(response.body);
         print(json);
        //print(tgl1+'/'+tgl2+'/'+locatt);
        final newData=json.map((e) => DataBySection.fromJson(e)).toList(); 
        _getdatasection=newData;
        }  

         notifyListeners();
      } 




      List<DataBySection_idno> _getdatasection_idno=[];
      List<DataBySection_idno> get getglobal_datasection_idno =>_getdatasection_idno;

Future <void> getDataBySection_idno(String idno) async{

      _getdatasection_idno.clear();

      var url=Uri.parse(NamaServer.server+"hrd/newloaddataatt_parisbysection_flut_idno.php");

      final response=await http.post(
        url,
        body: {
          'idno':idno,
        
        }
        
      );   
 

        if (response.statusCode==200)
       {
        final json=jsonDecode(response.body)['data'] as List;
       // final json=jsonDecode(response.body);
         
        print(json);
        final newData=json.map((e) => DataBySection_idno.fromJson(e)).toList(); 
        _getdatasection_idno=newData;
        }  

         notifyListeners();
      } 
      
  } 




 