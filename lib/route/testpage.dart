import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  final String datakirim;
  TestPage({super.key,required this.datakirim});

  @override
  State<TestPage> createState() => _TestPageState(datakirim:datakirim );
}

class _TestPageState extends State<TestPage> {
 
   final String? datakirim;
   _TestPageState({required this.datakirim});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Page2"),
      
      ),
      body: Navigator(
onGenerateRoute: (settings) {
  
},
      )
    );
  }
}