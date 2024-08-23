import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';

void setMessageAll(BuildContext context,String msg) {
  final message=SnackBar(content:Text(msg,style: TextStyle(fontSize: 16,color: Colors.yellow),),
  behavior: SnackBarBehavior.floating,
   backgroundColor: Colors.teal,
  shape: StadiumBorder(side: BorderSide(width:2,style: BorderStyle.solid,strokeAlign: BorderSide.strokeAlignCenter)),
  margin: EdgeInsets.only(
    left:30,right:30,bottom: MediaQuery.of(context).size.height-450
  ),
  );
  
  ScaffoldMessenger.of(context).showSnackBar(message);
}