import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return
    WillPopScope(
     onWillPop: () async => false,
    child: 
    
     Scaffold(
  appBar: AppBar(title: Center(child:Text("About",style: TextStyle(color: Colors.white),),),
     backgroundColor: Colors.blueAccent,
      
      
      ),
      body: Container(
        
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/back4b.jpg"),
            fit: BoxFit.cover,
            )
        ),
         
          child: 
           
            Center(
             
             child:  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

            Text("Parking Spot versi 1.0",style: TextStyle(color: Colors.white),),
            SizedBox(height: 10,),
             Text("Irawan Murjayanto 2024",style: TextStyle(color: Colors.white),),
             SizedBox(height: 10,),
             Text("Made By Flutter",style: TextStyle(color: Colors.white),)
          ],

                
               
             )

            )
           
         
      ),
     ),
    );
  }
}