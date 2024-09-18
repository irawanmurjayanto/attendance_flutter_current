import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_attendance_current/components/hrd_data_detail.dart';
import 'package:flutter_attendance_current/message/warning.dart';
import 'package:flutter_attendance_current/provider/mapdatas.dart';
import 'package:provider/provider.dart';

class Hrd_Data extends StatefulWidget {
  const Hrd_Data({super.key});

  @override
  State<Hrd_Data> createState() => _Hrd_DataState();
}

class _Hrd_DataState extends State<Hrd_Data> {

final _TextCariNIK=TextEditingController();

  getSearchNIK() async{
    showDialog(context: context,
     builder: (context) {
       return SingleChildScrollView(
        child: 
       
       AlertDialog(
        title: Text("Data Search"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _TextCariNIK,
              decoration: InputDecoration(
                hintText: "Personal Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(style: BorderStyle.solid)
                )
              ),
              onChanged: (value) {
                
                Provider.of<MapDatas>(context,listen: false).getListPerson_manualatt(value);

              },
            ),


                SizedBox(height: 5,),
         Container(
          decoration: BoxDecoration(
              border: Border.all(style: BorderStyle.solid)
          ),
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height/2.5,
              child: Consumer<MapDatas>(builder: (context, prov, child) {
               return  ListView.builder(
                  itemCount: prov.globalperson_manualatt.length,
                  itemBuilder: (context, i) {
                    return ListTile(
                        title: 
                        GestureDetector(
                         child: 
                                  Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(style: BorderStyle.solid,color: Colors.brown),
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.blue
                          ),
                  
                          child: Text
                        (prov.globalperson_manualatt[i].nama_person!+"("+prov.globalperson_manualatt[i].nik!+")",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold,color: Colors.white)),
                        ),

                          
                          onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Hrd_Data_Detail_Search(NIK: prov.globalperson_manualatt[i].nik!),));
                              // Navigator.pop(context);
                                                    //  setMessage2(prov.globalperson_manualatt[i].nik!);
                          },
                        
                        
                        ),
                        );
 
                },);
                
              },),
            ),
          ),
         )
          ],
        )
       ),
       );
     },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Personal Data",style: TextStyle(color: Colors.white,),),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        
        children: [
          GestureDetector(
            child: 
          MainMenu("personaldata.png", "Personal Data")      ,
          onTap: () {
            getSearchNIK();
          },
          )
        ],
      ),
    );
  }

  Widget MainMenu(String pict, String title) {
    return  
        Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            border: Border.all(style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(7)

          ),  
               
         child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
             // clipBehavior: Clip.antiAlias,
             decoration: BoxDecoration(
              border: Border.all(style: BorderStyle.solid,color: Colors.grey),
              shape: BoxShape.circle
             ),
              
             padding: EdgeInsets.all(1),
             
              child: 
               CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage("assets/images/$pict"),
              
               ),
            ),    
           

            SizedBox(height: 5,),
            Text(title,style: TextStyle(fontSize: 12),),
          ],
         ),

        
       
    );
  }
}
