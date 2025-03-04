

import 'package:flutter_attendance_current/components/attreport.dart';
import 'package:flutter_attendance_current/components/clear_data_register.dart';
import 'package:flutter_attendance_current/components/hrd_attmanual.dart';
import 'package:flutter_attendance_current/components/hrd_data.dart';
import 'package:flutter_attendance_current/components/hrd_data_cari.dart';
import 'package:flutter_attendance_current/components/hrdcoordinate_menu.dart';
import 'package:flutter_attendance_current/components/server.dart';
import 'package:flutter_attendance_current/datamodel/history.dart';
import 'package:flutter_attendance_current/datamodel/hrd_data_model.dart';
import 'package:flutter_attendance_current/datamodel/listsection.dart';
import 'package:flutter_attendance_current/main.dart';
import 'package:flutter_attendance_current/message/warning.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:io';
import 'package:just_audio/just_audio.dart';
import 'package:flutter_attendance_current/sqllite/database_helper.dart';
 

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


Future <void> provEmpReg_Del_Register(BuildContext context,String nik) async{

   var url=Uri.parse(NamaServer.server+'hrd/cariperson_flut_delete_register.php');

  final response=await http.post(
    url,
    body: {
       'nik':nik,
    
    } 
  ); 

  final json =jsonDecode(response.body);
  if (json['message']=='ok')
  {
    setMessage2('Delete Successfully');
  }else
  {
    setMessage2('Delete failed');
  }
  notifyListeners();
}



Future <void> provEmpReg_Check(BuildContext context,String nik) async{

   var url=Uri.parse(NamaServer.server+'hrd/cariperson_flut_register.php');

  final response=await http.post(
    url,
    body: {
       'nik':nik,
    
    } 
  ); 

  final json =jsonDecode(response.body);

  if (json['message']=='ok')
  {
    
        showDialog(context: context, builder: (context) {
          return AlertDialog(
            title: Text('Register Warning'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                    Text('Apakah Nama Anda '+json['nama']+' ?')
              ],
            ),
            actions: [
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: () {
                  Navigator.pop(context);
                }, child: Text('No')),
                SizedBox(width: 5,),
                ElevatedButton(onPressed: () {
                  provEmpReg(context, nik, nik);
                }, child: Text('Yes')),
              ],
             )
            ],
          );
        },);


  }else
  {
    Fluttertoast.showToast(
        msg: "NIK Anda tidak ada di Database kami,mohon hubungi HRD",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
       
    );
  }

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
    print(json);
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

    //  ShowWarningPopup('NIK Sudah Terdaftar,mohon hubungi HRD', 'Warning NIK', context);

      EasyLoading.dismiss();
          return;
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

  EasyLoading.dismiss();
        
            // deleteNIK(_empregnik.text); 
            // addNIK();
            // getNIK();  

     }
     EasyLoading.dismiss();
  }



         
    await DatabaseHelper.deleteItem(nik);
 
    
 
    await DatabaseHelper.createItem(
        nik,'desc');

   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => new MyApp()));
   EasyLoading.dismiss();


}




Future <void> savehrd_data_all(String hak_person,BuildContext context,String tipe,String nik,String nama,String email,String jabatan,String section,String tp_lahir,String tgl_lahir,String no_telp,String gender,String marital_status,String alamatktp,String alamatnow,String nama_contact,String hubungan,String pendidikan,String jurusan,String status_emp,String status_pegawai,String tgl_masuk,String tgl_resign,String masa_kontrak1,String masa_kontrak2,String remarksmasa_kontrak,String ktp,String jkn,String kpj,String bpjs,String npwp,String rekening,String no_hp,String nama_suami_istri,String nama_anak1,String nama_anak2,String nama_anak3) async {
//Future <void> savehrd_data_all(BuildContext context,String nik,String nama,String email) async {
       getStatusInet(context);
       EasyLoading.show(status: "Processing.. ");
  

   
       var url = Uri.parse(NamaServer.server+'hrd/newsaveatt_hrdall_flut.php');
       var response=await http.post(
        url,
        body: {
            'hak_person':hak_person,
            'nik':nik,
            'nama_person':nama,
            'email':email,
            'tipe':tipe,

            'jabatan':jabatan,
            'section':section,
            'tempat_lahir':tp_lahir,
            'tgl_lahir':tgl_lahir,
            'no_telepon':no_telp,
            'gender':gender,
            'marital_status':marital_status,
            'alamat_ktp':alamatktp,
            'alamat_now':alamatnow,
            'nama_contact':nama_contact,
            'hubungan':hubungan,
            'pendidikan':pendidikan,
            'jurusan':jurusan,
            'status_emp':status_emp,
            'status_pegawai':status_pegawai,
            'tgl_masuk':tgl_masuk,
            'tgl_resign':tgl_resign,
            'masa_kontrak1':masa_kontrak1,
            'masa_kontrak2':masa_kontrak2,
            'remarksmasa_kontrak':remarksmasa_kontrak,
            'KTP':ktp,
            'JKN':jkn,
             'KPJ':kpj,
            'BPJS':bpjs,
            'NPWP':npwp,
            'rekening':rekening,
            'no_hp':no_hp,
            'nama_suami_istri':nama_suami_istri,
            'nama_anak1':nama_anak1,
            'nama_anak2':nama_anak2,
            'nama_anak3':nama_anak3,






 

            
        }
        );

        if (response.statusCode==200)
        {
          final json=jsonDecode(response.body);

         

          print(json);

           if (json['message']=='sudahada')
           {
                setMessageAll(context, json['messageerror']);
                 EasyLoading.dismiss();
                return;
           } 

           if (json['message']=='ok')
           {
            setMessageAll(context, "Save Data Successfully");
          }else
          {
            setMessageAll(context, 'Data Failed' );
          }
        }

         EasyLoading.dismiss();
        notifyListeners();
}       

Future <void> saveImageByNIK(BuildContext context,nik,image) async {
       getStatusInet(context);
  //   EasyLoading.show(status:"Processing...");
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
     
  // EasyLoading.dismiss();
}      
 


 
Future <void> saveImageMapxx_manualatt(BuildContext context,image,String nik,String lok,String absen) async {
       
    EasyLoading.show(status:"Processing...");
      
    
       var url = Uri.parse(NamaServer.server+'hrd/newsaveatt_flut2_manual.php');


 
//  EasyLoading.show(status: "Saving Data..");

   
     

      final response = await http.post(
          url,
          body: {
            'nik':nik,
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
              // EasyLoading.dismiss();
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
         
       // EasyLoading.dismiss();

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



Future <void> getList_Coordinate_save(String lat1,String lat2,String long1,String long2,String homebase) async{
     
 

      var url=Uri.parse(NamaServer.server+"hrd/list_location_google_save.php");

      final response=await http.post(
        url,
        body: {
           
          'lat1':lat1,
          'lat2':lat2,
          'long1':long1,
          'long2':long2,
          'homebase':homebase,
        }
        
      );   

      if (response.statusCode==200)
      {
        final json=jsonDecode(response.body);
          print(json);
        if (json['message']=='sukses')
        {
          setMessage2("Save Succesfully");
        }else
        {
          setMessage2("Save failed");
        }
      }

   }       



   List <List_Google> _getlistgoggle_edit=[];
   List <List_Google> get globallistgoogle_edit=>_getlistgoggle_edit;

 Future <void> getList_Coordinate_edit(String idno) async{
    _getlistgoggle_edit.clear();
 
      
      var url=Uri.parse(NamaServer.server+"hrd/list_location_google_edit.php");

      final response=await http.post(
        url,
        body: {
          'idno':idno
        }
        
      );   

      if (response.statusCode==200)
      {
        final json=jsonDecode(response.body)['data'] as List;
        print('nilainya :'+json.toString());
        final _newData=json.map((e) => List_Google.fromJson(e)).toList();
        _getlistgoggle_edit=_newData;
      } 
      notifyListeners();
  } 




List <List_Google_1st> _getlistgoggle_firstime=[];
   List <List_Google_1st> get globallistgoogle_firstime=>_getlistgoggle_firstime;

 Future <void> getList_Coordinate_FirstTime(String macadd) async{
  
     _getlistgoggle_firstime.clear();

    

      var url=Uri.parse(NamaServer.server+"hrd/list_location_google_firsttime.php");

      final response=await http.post(
        url,
        body: {
          'macadd':macadd
        }
        
      );   

      if (response.statusCode==200)
      {
        final json=jsonDecode(response.body)['data'] as List;
        print(json);
        final _newData=json.map((e) => List_Google_1st.fromJson(e)).toList();
        _getlistgoggle_firstime=_newData;
      } 
      notifyListeners();
     // EasyLoading.dismiss();
  } 



List <List_Google> _getlistgoggle=[];
   List <List_Google> get globallistgoogle=>_getlistgoggle;

 Future <void> getList_Coordinate() async{
    _getlistgoggle.clear();
 

      var url=Uri.parse(NamaServer.server+"hrd/list_location_google.php");

      final response=await http.post(
        url,
        // body: {
        //   'tipe':tipe
        // }
        
      );   

      if (response.statusCode==200)
      {
        final json=jsonDecode(response.body)['data'] as List;
        print(json);
        final _newData=json.map((e) => List_Google.fromJson(e)).toList();
        _getlistgoggle=_newData;
      } 
      notifyListeners();
      EasyLoading.dismiss();
  } 





 
Future <void> saveImageMapxx(String lat1,String long1,BuildContext context,image,String macadd,String lok,String absen) async {
       
       EasyLoading.show(status:"Processing...");
      
    
       var url = Uri.parse(NamaServer.server+'hrd/newsaveatt_flut2_google_gen2.php');


 
//  EasyLoading.show(status: "Saving Data..");

   
     

      final response = await http.post(
          url,
          body: {
            'lat1':lat1,
            'long1':long1,
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
       //  setMessage2(json);
          
        

            
 
        //  if (json['google']=='nomatch') {
        //   //setMessageAll(context, "nomatch");
        //   showDialog(context: context, builder: (context) {
        //     return AlertDialog(
        //       title: Text("Coordinat Warning "),
        //       content: Text('Anda Telah diluar Koordinat google dengan lokasi kantor di  '+json['homebase']),
        //       actions: [
        //         Column(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: [
        //             IconButton(onPressed: () {
        //               Navigator.pop(context);
        //             }, icon: Icon(Icons.close))
        //           ],
        //         )
        //       ],
        //     );
        //   },);
        //   EasyLoading.dismiss();
        //   return;
        //  }


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
             //  EasyLoading.dismiss();
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

             //  EasyLoading.dismiss();
            
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

          
    
         
       // EasyLoading.dismiss();

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


   List <List_NIK> _getlistnik=[];
   List <List_NIK> get globallistnik=>_getlistnik;

  Future <void> getListNIK() async{
    EasyLoading.show(status: "Processing..");
    _getlistnik.clear();
    var url=Uri.parse(NamaServer.server+"hrd/list_nik_flut.php");

      final response=await http.post(
        url,
        
      );   

      if (response.statusCode==200)
      {
        final json=jsonDecode(response.body)['data'] as List;
        print(json);
        final newData=json.map((e) => List_NIK.fromJson(e)).toList();
        _getlistnik=newData;
        
      }
      notifyListeners();

  }


   List <hrdsection> _gethrdsection=[];
   List <hrdsection> get globalhrdsection=>_gethrdsection;

  Future <void> getListSection(String section) async{
    EasyLoading.show(status: "Processing..");
    _gethrdsection.clear();
    _getdatasection.clear();
  
    //_getpersonsection.clear();

      var url=Uri.parse(NamaServer.server+"hrd/carisection.php");

      final response=await http.post(
        url,
        body: {
           'section':section
        }
        
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



 
   List <DataNama_person_NIK> _getnik_person=[];
   List <DataNama_person_NIK> get globalnik_person=>_getnik_person;

 Future <void> getListPersonByNIK(String nik) async{
    _getnik_person.clear();
    

      var url=Uri.parse(NamaServer.server+"hrd/cariperson_flut_nik.php");

      final response=await http.post(
        url,
        body: {
          'nik':nik
        }
        
      );   

      if (response.statusCode==200)
      {
        final json=jsonDecode(response.body)['data'] as List;
        print(json);
        final _newData=json.map((e) => DataNama_person_NIK.fromJson(e)).toList();
        _getnik_person=_newData;
        
      } 
  
      notifyListeners();
      EasyLoading.dismiss();
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


Future <void> setList_Location_Only(String homebase,String nik) async{
    
   

      var url=Uri.parse(NamaServer.server+"hrd/list_location_flutonly_save.php");

      final response=await http.post(
        url,
        body: {
          'nik':nik,
          'homebase':homebase,
        }
        
      );   

      if (response.statusCode==200)
      {
        final json=jsonDecode(response.body);
        print(json);
        if (json['message']=='sukses')
        {
          setMessage2("Save Data Succesfully");
        }else{
          setMessage2("Failed Save data");
        }
       
      } 
      notifyListeners();
      EasyLoading.dismiss();
  } 


List <List_Location_only> _getlist_location_only=[];
   List <List_Location_only> get globallist_location_only=>_getlist_location_only;

 Future <void> getList_Location_Only() async{
    _getlist_location_only.clear();
   

      var url=Uri.parse(NamaServer.server+"hrd/list_location_flutonly.php");

      final response=await http.post(
        url,
        // body: {
        //   'nama':nama
        // }
        
      );   

      if (response.statusCode==200)
      {
        final json=jsonDecode(response.body)['data'] as List;
        print(json);
        final _newData=json.map((e) => List_Location_only.fromJson(e)).toList();
        _getlist_location_only=_newData;
      } 
      notifyListeners();
      EasyLoading.dismiss();
  } 


 List <DataBySection_person> _getperson_manualatt=[];
   List <DataBySection_person> get globalperson_manualatt=>_getperson_manualatt;

 Future <void> getListPerson_manualatt_google(String nama) async{
    _getperson_manualatt.clear();
   

      var url=Uri.parse(NamaServer.server+"hrd/cariperson_flut_google.php");

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
      EasyLoading.dismiss();
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
        }
        else if (((json['errormsg']==1)||(json['errormsg']==3))  & (menu=='5'))
        {
           Navigator.push(context,MaterialPageRoute(builder: (context) => HrdCoordinate_Menu()));   
        }else if (((json['errormsg']==1)||(json['errormsg']==3))  & (menu=='2'))
        {
           Navigator.push(context,MaterialPageRoute(builder: (context) => HRD_Att_Manual()));
        }
        else if (((json['errormsg']==3)) & (menu=='3'))
        {
           Navigator.push(context,MaterialPageRoute(builder: (context) => Hrd_Data_Cari()));
        }  
         else if (((json['errormsg']==3)) & (menu=='6'))
        {
           Navigator.push(context,MaterialPageRoute(builder: (context) => Clear_Data_Register()));   
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


Future <void> saveDataBySectionbyDate(String idno,String tgl_rec) async{


      var url=Uri.parse(NamaServer.server+"hrd/saveDataBySectionbyDate_flut.php");

      final response =await http.post
      (
        url,
        body: {
          'idno':idno,
          'tgl_rec':tgl_rec,
        }
      );

      final json=jsonDecode(response.body);
      if (json['message']=='ok')
      {
        setMessage2("Save data succesfully");
      }else
      {
        setMessage2("Save data failed");
      }
notifyListeners();


}



List<DataBySection> _getdatasection=[];
List<DataBySection> get getglobal_datasection =>_getdatasection;

Future <void> getDataBySection(BuildContext context, tgl1,String tgl2,String locatt,String nik) async{

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

      final jsonwarn=jsonDecode(response.body);
        print(jsonwarn);
        if (jsonwarn['errormsg']=='nodata')
        {
              setMessageAll(context, "Tidak ada data");
              EasyLoading.dismiss();
              return;
        }


        final json=jsonDecode(response.body)['data'] as List;
        //final json=jsonDecode(response.body);

          
         print(json);
        //print(tgl1+'/'+tgl2+'/'+locatt);
        final newData=json.map((e) => DataBySection.fromJson(e)).toList(); 
        _getdatasection=newData;
        }  

         notifyListeners();
         EasyLoading.dismiss();
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




 