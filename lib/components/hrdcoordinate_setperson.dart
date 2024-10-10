import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HrdCoordinate_SetPerson extends StatefulWidget {
  final String nik;
  const HrdCoordinate_SetPerson({Key?key,required this.nik}):super(key: key);

  @override
  State<HrdCoordinate_SetPerson> createState() => _HrdCoordinate_SetPersonState(nik:nik);
}

class _HrdCoordinate_SetPersonState extends State<HrdCoordinate_SetPerson> {

 final String nik;
 _HrdCoordinate_SetPersonState({required this.nik});
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Location by Person"),
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      ),
    );
  }
}