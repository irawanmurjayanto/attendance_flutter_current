import 'package:flutter/material.dart';
import 'package:flutter_attendance_current/components/hrd_data_cari.dart';
import 'package:flutter_attendance_current/components/hrdcoordinate.dart';
import 'package:flutter_attendance_current/components/hrdcoordinate_sub.dart';
import 'package:flutter_attendance_current/components/hrdkoordinat_cari.dart';
import 'package:flutter_attendance_current/main.dart';
import 'package:flutter_attendance_current/main2.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class HrdCoordinate_Menu extends StatefulWidget {
  const HrdCoordinate_Menu({super.key});

  @override
  State<HrdCoordinate_Menu> createState() => _HrdCoordinate_MenuState();
}

class _HrdCoordinate_MenuState extends State<HrdCoordinate_Menu> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () {
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => new MyApp()))      ;
       return Future.value(false);
    },child: 
     Scaffold(
        appBar: AppBar(title: Text('Coordinate Menu',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        ),
        body: Container(
          child: Column(
            
            children: [
              Row(
                children: [
                    
                    WMenu('Loc. Set Up','assets/images/menu2.jpg',HrdCoordinat_cari()),
                    WMenu('Coordinate','assets/images/menu1.jpg',Hrd_Coordinate_set()),
                ],
              )
    
            ],
          )
        ),
    ),
    );
  }

  Widget WMenu(String title,String img,Widget func1){
    return 
    GestureDetector(
      child: 
    Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
        height: 90,
        width: 90,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(style: BorderStyle.solid,color: Colors.grey)
        ),
        child: Column(
          children: [
        
            
            Image.asset(
              height: 50,
              width: 50,
              img,
              fit: BoxFit.cover,
              ),
              SizedBox(height: 5,),
              Text(title,style: TextStyle(fontWeight: FontWeight.bold),),
          ],
        ),
    ),
    onTap: () {
      EasyLoading.show(status: 'Processing..');
      Navigator.push(context, MaterialPageRoute(builder: (context) => func1));
    },

    );
  }
}