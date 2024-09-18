import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_attendance_current/components/orientation.dart';
import 'package:flutter_attendance_current/message/warning.dart';
import 'package:flutter_attendance_current/provider/mapdatas.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/services.dart';
import 'dart:io';

class Hrd_Data_Detail_Search extends StatefulWidget {
  final String NIK;
  const Hrd_Data_Detail_Search({Key?key,required this.NIK}):super(key: key);

  @override
  State<Hrd_Data_Detail_Search> createState() => _Hrd_Data_Detail_SearchState(NIK:NIK);
}

class _Hrd_Data_Detail_SearchState extends State<Hrd_Data_Detail_Search> {
  final String NIK;
  _Hrd_Data_Detail_SearchState({required this.NIK});


@override
  void didChangeDependencies() {
   getCheck();
    final provx=Provider.of<MapDatas>(context,listen: false);
    setState(() {
       _Text_Nik.text = provx.getglobalhrddetail_personal[0].nik!;
      _Text_Nama.text = provx.getglobalhrddetail_personal[0].nama_person!;
      _Text_Email.text = provx.getglobalhrddetail_personal[0].email!;
      _Text_Jabatan.text = provx.getglobalhrddetail_personal[0].jabatan!;
      _Text_Section.text = provx.getglobalhrddetail_personal[0].section!;
      _Text_TempatLahir.text = provx.getglobalhrddetail_personal[0].tempat_lahir!;
     

      String _temp_TanggalLahir=DateFormat('dd-MMM-yyyy').format(provx.getglobalhrddetail_personal[0].tgl_lahir!);
       _Text_TanggalLahir.text = provx.getglobalhrddetail_personal[0].tgl_lahir!.toString();
      _Text_NoTelepon.text = provx.getglobalhrddetail_personal[0].no_telepon!; 
    });
   
    

    

                
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
 
  final _Text_Nik=TextEditingController();
  final _Text_Nama=TextEditingController();
  final _Text_Email=TextEditingController();
  final _Text_Jabatan=TextEditingController();
  final _Text_Section=TextEditingController();
  final _Text_TempatLahir=TextEditingController();
  final _Text_TanggalLahir=TextEditingController();
  //String ?_temp_TanggalLahir;
  final _Text_NoTelepon=TextEditingController();

  

  getCheck() async{
    await Provider.of<MapDatas>(context,listen: false).getListPersonAll(NIK);
    // final String x=Provider.of<MapDatas>(context,listen: false).getglobalhrddetail_personal[0].nama_person!;
    // setMessage2(x);
  }

  @override
  void initState() {
   
    getPortraitCentral();
     getCheck();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail DATA NIK : "+NIK,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),   
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(onPressed: () {
            getCheck();
          }, icon: Icon(Icons.abc_rounded))
        ],
      ),
      body:  Container(child: 
           SingleChildScrollView(
           child: Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.amber,
            child:  
               
               Consumer<MapDatas>(builder: (context, prov, child) {
                 return ListView.builder(
                  itemCount: prov.getglobalhrddetail_personal.length,
                  itemBuilder: (context, i) {
                   return Card(
                    child: Container(
                      child: Column(
                        children: [


                           //top header 
                              Row(
                                children: [
                            
                              SizedBox(width: 70,
                              child: 
                              TextField_HRD(_Text_Nik, "NIK"),
                              )
                              ,
                              SizedBox(width: 5,),
                              Expanded(child: 

                              TextField_HRD(_Text_Nama, "Nama"),
                              )
                                ]),


                          TextField_HRD(_Text_Email, "Email"),

                          Row(
                            children: [
                              SizedBox(width: 100,
                              child: 
                              TextField_HRD(_Text_Jabatan, "Jabatan"),
                              ),
                              SizedBox(width: 5,),
                              Expanded(child: 
                              TextField_HRD(_Text_Section, "Section"),
                              )
                            ],
                          ),


                            Row(
                            children: [
                              SizedBox(width: 100,
                              child: 
                              TextField_HRD(_Text_TempatLahir, "Tempat Lahir"),
                              ),
                              SizedBox(width: 5,),
                              SizedBox(width: 100,
                              child: 
                              TextField_HRD(_Text_TanggalLahir, "Tanggal Lahir"),
                              ),
                              SizedBox(width: 5,),
                              Expanded(child: 
                              TextField_HRD(_Text_Section, "Section"),
                              )
                            ],
                          )
  
                          
                        ],
                      )
                    )
                   );
                 },);
               },)
                
           
             
          ),
       
      
      )
      )
    );
  }

  Widget TextField_HRD(TextEditingController x,String hintT) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: TextField(
        style: TextStyle(fontSize: 12),
        controller: x,
        decoration: InputDecoration(
         hintText: hintT,
           border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(style: BorderStyle.solid)
           )  
        ),
      ),
    );
  }
}