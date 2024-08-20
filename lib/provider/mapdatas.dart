import 'package:flutter_attendance_paradise/components/server.dart';
import 'package:flutter_attendance_paradise/datamodel/history.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

class MapDatas with ChangeNotifier {
 
List<DataModel> _datamap=[];
List<DataModel> get datamap => _datamap;

Future<void> getHistoryC(String imeino) async{

var url=Uri.parse('https://irawan.angsoft.info/tests/flutter/map1/history.php');

final response=await http.post(
  url,
  
  body: {
    'tipe':'lihat',
    'imeino':imeino,
  }
  
  ); 


 
  final json=jsonDecode(response.body)['data'] as List;

  // if (json==null)
  // {
  //   return ;
  // }

   //print(response.body);

  final datajson=json.map((e) => DataModel.fromJson(e)).toList();
  _datamap=datajson;

  notifyListeners();
  


}


Future <void> getHistoryCari (String imeino,String cari) async {
  var url=Uri.parse(NamaServer.server+'tests/flutter/map1/history.php');

final response=await http.post(
  url,
  body: {
    'tipe':'cari',
    'cari':cari,
    'imeino':imeino,

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


}