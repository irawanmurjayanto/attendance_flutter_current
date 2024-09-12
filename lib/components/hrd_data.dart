import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Hrd_Data extends StatefulWidget {
  const Hrd_Data({super.key});

  @override
  State<Hrd_Data> createState() => _Hrd_DataState();
}

class _Hrd_DataState extends State<Hrd_Data> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Personal Data"),),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
              //row menu
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/menudata.png"),
                          fit: BoxFit.cover
                          
                          )
                      ),
                      
                  )
                ],
              )

          ],
        ),
    );
  }
}