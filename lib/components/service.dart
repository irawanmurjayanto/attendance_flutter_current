 
 
import 'dart:convert';
import 'package:flutter_attendance_current/datamodel/history.dart';
import 'package:http/http.dart' as http;

class Services{

 
 Future <List<DataModel>> getHistory() async {

 //   List<DataModel> _data = [];

 
 String url = "https://irawan.angsoft.info/tests/flutter/map1/history.php";
//String url = "https://jsonplaceholder.typicode.com/comments/1";


     
    final response = await http.get(Uri.parse(url));
 
   // return jsonDecode(response.body);

  if (response.statusCode == 200) {
      //final item = json.decode(response.body)['meals'].cast<Map<String, dynamic>>() ;
       final data = (json.decode(response.body)['data'] as List)
                     .map((json) =>DataModel.fromJson(json))
                     .toList();
     // _data = item.map<DataModel>((json) => DataModel.fromJson(json)).toList();
        // _data = item.map<DataModel>((json) => DataModel.fromJson(json)).toList();
       
      return data;
     
   
    } else {
     print('Error Occurred');
    
    }  
  
return [];
       
 }


 



}