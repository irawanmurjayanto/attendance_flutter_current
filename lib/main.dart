import 'package:flutter/material.dart';
 
import 'package:flutter_attendance_current/components/history.dart';
import 'package:flutter_attendance_current/main2.dart';
import 'package:flutter_attendance_current/main3.dart';
import 'package:flutter_attendance_current/provider/mapdatas.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

//Irawan Murjayanto Agustus 2024

void main() {
  runApp(
    
    MultiProvider(providers: [
     ChangeNotifierProvider.value(value: MapDatas()),

    ],
    child:MyApp(),
    
    )
    
    
    );
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      title: 'Flutter Attendance',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Lay_Nav_ira(),
    );
  }
}


class Lay_Nav_ira extends StatefulWidget {
  const Lay_Nav_ira({super.key});

  @override
  State<Lay_Nav_ira> createState() => _Lay_Nav_iraState();
}

class _Lay_Nav_iraState extends State<Lay_Nav_ira> {
  @override
  void initState() {
    //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Nav,));//
    // TODO: implement initState
    super.initState();
  }

final List<Widget> _children=[
  HomepageMenu(),
  HistoryMenu(),
  About()
];

int _currentIndex = 0;

void onBarTapped(int index) {
  setState(() {
    _currentIndex = index;
  });
}


  @override
  Widget build(BuildContext context) {
   const primaryColor = Color(0xFF151026);
    return MaterialApp(
      debugShowCheckedModeBanner: false,

         builder: EasyLoading.init(),
     
       theme: ThemeData(
   primaryColor: primaryColor,
   ),
   
      home: Scaffold(
      //  appBar: AppBar(title: Text("Parking Spot"),),
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: onBarTapped,
           selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 8,
        unselectedFontSize: 8,
          items: [
             BottomNavigationBarItem(
      icon: new Icon(Icons.home,size: 40),
      label: 'Home'
    ),
    BottomNavigationBarItem(
        icon: new Icon(Icons.history,size: 40),
        label: 'History'
    ),
    BottomNavigationBarItem(
        icon: new Icon(Icons.person,size: 40),
        label: 'About'
    ),
   
          ]
      ),
    ),
  
    );
  }
}