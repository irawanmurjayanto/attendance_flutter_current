import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_attendance_current/components/attreport2.dart';
import 'package:flutter_attendance_current/components/history.dart';
import 'package:flutter_attendance_current/components/server.dart';
import 'package:flutter_attendance_current/datamodel/history.dart';
import 'package:flutter_attendance_current/datamodel/listsection.dart';
import 'package:flutter_attendance_current/message/warning.dart';
import 'package:flutter_attendance_current/provider/mapdatas.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AttbySection extends StatefulWidget {
  const AttbySection({super.key});

  @override
  State<AttbySection> createState() => _AttbySectionState();
}

class _AttbySectionState extends State<AttbySection> {
  final _begDate = TextEditingController();
  final _endDate = TextEditingController();
  final _Text_Person=TextEditingController();
  final _Text_Section=TextEditingController();
  final _Text_Cari_Person=TextEditingController();

  final _Text_Cari_Section=TextEditingController();

  String? _temptgl1;
  String? _temptgl2;
  String? _tempListSection;
  String? _tempListSection2;
  String? _tempListPerson;
  String? _tempListPerson2;
  String? _tempList_NIK;
  

  final _TextCariName=TextEditingController();





  getSearchSection() async{
    // box.write("begdate", _begDate.text);
    // box.write("enddate", _endDate.text);
        setState(() {
      _tempListSection='xx';
      _tempListPerson='xx';
    _TextCariName.text='';
    });
     //_getRefreshDataBySection;
    
    Provider.of<MapDatas>(context,listen: false).getListSection(_Text_Cari_Section.text);
    showDialog(context: context,
     builder: (context) {
       return SingleChildScrollView(
        child: 
       
       AlertDialog(
        title: Text("Section"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _Text_Cari_Section,
              decoration: InputDecoration(
                hintText: "Type Section",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(style: BorderStyle.solid)
                )
              ),
              onChanged: (value) {
               _Text_Cari_Section.text=value; 
               Provider.of<MapDatas>(context,listen: false).getListSection(value);

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
                  itemCount: prov.globalhrdsection.length,
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
                        (prov.globalhrdsection[i].section!,style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold,color: Colors.white)),
                        ),

                          
                          onTap: () async {
                            
              setState(() {

                _Text_Section.text=prov.globalhrdsection[i].section!;
                _tempListSection=prov.globalhrdsection[i].section!;
                _Text_Person.text='';
                _tempListPerson='';
                

              });

              Navigator.pop(context);
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




  getSearchNIK() async{
    // box.write("begdate", _begDate.text);
    // box.write("enddate", _endDate.text);
    // setState(() {
    //   _Text_Cari_Section.text='';
    //   _tempListSection='xx';
    //   _tempListPerson='xx';
    //     _TextCariName.text='';
    // });
    //  _getRefreshDataBySection;
    setState(() {
      _TextCariName.text='';
    });
  
    Provider.of<MapDatas>(context,listen: false).getListPerson_manualatt_google(_TextCariName.text);
    showDialog(context: context,
     builder: (context) {
       return SingleChildScrollView(
        child: 
       
       AlertDialog(
        title: Text("Personal Name"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _TextCariName,
              decoration: InputDecoration(
                hintText: "Type Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(style: BorderStyle.solid)
                )
              ),
              onChanged: (value) {
                
               Provider.of<MapDatas>(context,listen: false).getListPerson_manualatt_google (value);

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

                          
                          onTap: () async {
                              
              setState(() {

                _Text_Person.text=prov.globalperson_manualatt[i].nama_person!;
                _tempListPerson=prov.globalperson_manualatt[i].nik!;
                //forsectio
                _tempListSection='';
                _Text_Section.text='';
                
              });
     
             //  _getRefreshDataBySection;
              Navigator.pop(context);                                     //  setMessage2(prov.globalperson_manualatt[i].nik!);
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


 

  final String datenow = DateFormat("dd-MM-yyyy").format(DateTime.now());

  _getRefreshDataBySection() async {
    // final String tgl1=DateFormat('yyyy-MM-dd').format(DateTime.parse(_begDate.text));
    // final String tgl2=DateFormat('yyyy-MM-dd').format(DateTime.parse(_endDate.text));

   EasyLoading.show(status: 'Processing');

    setState(() {
      _temptgl1 = _begDate.text;
      _temptgl2 = _endDate.text;
    });
    
    if (_Text_Cari_Section.text==null)
    {
      setState(() {
        _tempListSection='';
      });
      
    }

     if (_Text_Cari_Person.text==null)
    {
      setState(() {
         _tempListPerson='';
      });
     
    }

    Provider.of<MapDatas>(context, listen: false).getDataBySection(context,
        _begDate.text, _endDate.text, _tempListSection!.toString(),_tempListPerson!.toString());
  }



  getDateNow() async {
    _begDate.text = datenow;
    _endDate.text = datenow;
  }

  getRefresh() async {
    Provider.of<MapDatas>(context, listen: false).getListSection(_TextCariName.text);
  }

 
  
   

  getRefreshDrop1() async {
    await  Provider.of<MapDatas>(context, listen: false).getListPerson("");              
  }

  getRefreshDrop2(String datax) async{
    await Provider.of<MapDatas>(context, listen: false).getListPerson(datax); 
    DropPerson();
  }

  getHit() async{
   final int hitx=_tempListPerson!.length;
   return hitx;
  }

  @override
  void didChangeDependencies() {

     
    //    if (_tempListSection==null)
    // {
    //   _tempListSection='xx';
    //   _tempListPerson='';
    // } 
  
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  getProtrait() async{
      await SystemChrome.setPreferredOrientations([
         DeviceOrientation.portraitDown,
         DeviceOrientation.portraitUp 
      ]
        

        
      );
  }
  final box=GetStorage();

  @override
  void initState() {


     

    getProtrait();
     if (_tempListSection==null)
    {
      _tempListSection='x';
      _tempListPerson='xx';
    } 
   // _getRefreshDataBySection();
    
    getDateNow();
   // getRefresh();

   

    // if (box.read("begdate")==null){
    //   setState(() {
    //     _begDate.text=DateFormat('dd-MM-yyyy').format(DateTime.now());
    //   });
      
    // }else{
    //   setState(() {
    //    _begDate.text=box.read("begdate"); 
    //   });
       
    // }

    // if (box.read("enddate")==null){
    //   setState(() {
    //      _endDate.text=DateFormat('dd-MM-yyyy').format(DateTime.now());
    //   });
     
    // }else{
    //   setState(() {
    //    _begDate.text=box.read("enddate"); 
    //   });
       
    // }
        
    // Provider.of<MapDatas>(context, listen: false).getDataBySection(
    //     box.read('begdate'), box.read('enddate'),'',box.read('nik')); 
    EasyLoading.dismiss();
    super.initState();
  }

  getMessage(String msg) async{


    Fluttertoast.showToast(
                          msg:msg,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0
                        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Attendance By Section"),
          actions: [
            IconButton(onPressed: () {
              Navigator.pop(context);
            }, icon: Icon(Icons.close))
          ],
        ),
        backgroundColor: Colors.grey,
        body: Container(
            margin: EdgeInsets.only(top: 5, left: 5, right: 10),
            width: double.infinity,
            // height: MediaQuery.sizeOf(context).height,
            // decoration: BoxDecoration(
            //   color: Colors.white,
            //   border: Border.all(style: BorderStyle.solid,color: Colors.white),
            //   borderRadius: BorderRadius.circular(5),

            //   ),

            padding: EdgeInsets.only(top: 5, left: 5, right: 5),
            child: 
            
            SingleChildScrollView(child: 
            
            Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //datepicker

                WdColumnDate(),
                SizedBox(
                  height: 5,
                ),
               WdDataBySection_2(),
              ],
            ),
            )));
  }

  Widget WdColumnDate() {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(style: BorderStyle.solid, color: Colors.black54)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: PickBegDate(),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                " To ",
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                child: PickEndDate(),
              )
            ],
          ),
          SizedBox(
            height: 40,
            child: 
            
            //DropSection(),
            AllSectionNew(),
          ),
          SizedBox(
            height:35,
            child: 
            
              
            // DropPerson(),
            AllPersonNew(),
          
            
              
          
           
          ),
           
          SizedBox(
              width: 120,
              child: ElevatedButton(
                  onPressed: () {
                //    EasyLoading.show(status: 'Processing');   
                    _getRefreshDataBySection();
                   

                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.production_quantity_limits,
                        size: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Process",
                        style: TextStyle(fontSize: 8),
                      )
                    ],
                  ))),
        ],
      ),
    );
  }

 

  Widget WdDataBySection() {
    return SingleChildScrollView(
        child: Container(
            decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                style: BorderStyle.solid, color: Colors.black54)),
            height: MediaQuery.of(context).size.height / 1.65,
            child: RefreshIndicator(
                onRefresh: () => _getRefreshDataBySection(),
                child: FutureBuilder(
                  future: Provider.of<MapDatas>(context, listen: false)
                      .getDataBySection(context,_temptgl1.toString(),
                          _temptgl2.toString(), _tempListSection!.toString(),_tempListPerson!.toString()),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return Consumer<MapDatas>(
                        builder: (context, prov, child) {
                          return ListView.builder(
                            itemCount: prov.getglobal_datasection.length,
                            itemBuilder: (context, i) {
                              return Card(
                               child:
                                Row(children: [

                                    Container(
                            
                                    padding: EdgeInsets.all(3),
                                    height: 50,
                                    width: 50,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            style: BorderStyle.solid,
                                            color: Colors.black,
                                            width: 1),
                                            
                                            
                                            ),

                                    child: Image.network(
                                       
                                      fit: BoxFit.cover,
                                      NamaServer.server +
                                          'hrd/uploademp/' +
                                          prov.getglobal_datasection[i]
                                              .pict_att!
                                              .toString() +
                                          '.jpg',
                                      frameBuilder: (context, child, frame,
                                          wasSynchronouslyLoaded) {
                                        return child;
                                      },
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        } else {
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                      },
                                    )),
                                  
                                Expanded(
                                    child:
                                    GestureDetector(
                                      child: 
                                     Container(
                                      margin: EdgeInsets.only(left: 5),
                                        padding: EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                                style: BorderStyle.solid)),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Text(
                                                      prov
                                                              .getglobal_datasection[
                                                                  i]
                                                              .nama!
                                                              .toString() +
                                                          " / " +
                                                          prov
                                                              .getglobal_datasection[
                                                                  i]
                                                              .nik!
                                                              .toString(),
                                                      style: TextStyle(
                                                          fontSize: 8,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      textAlign:
                                                          TextAlign.center),
                                                  Text(
                                                      prov
                                                              .getglobal_datasection[
                                                                  i]
                                                              .absen!
                                                              .toString() +
                                                          " / " +
                                                          prov
                                                              .getglobal_datasection[
                                                                  i]
                                                              .tglrec!
                                                              .toString(),
                                                      style: TextStyle(
                                                          fontSize: 7),
                                                      textAlign:
                                                          TextAlign.center),
                                                  Text(
                                                    prov
                                                        .getglobal_datasection[
                                                            i]
                                                        .lokasi
                                                        .toString(),
                                                    style:
                                                        TextStyle(fontSize: 7),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Icon(Icons.arrow_right)
                                          ],
                                        )
                                        ),
                                         onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AttbySection2(
                                              idno: prov
                                                  .getglobal_datasection[i].idno
                                                  .toString()),
                                        ));
                                  },    
                                    )

                                  ),
                                 
                            
                                ]
                                ),
                                
                              );
                            },
                          );
                        },
                      );
                    }
                  },
                )
                )
                )
                );
  }




Widget WdDataBySection_2() {
    return SingleChildScrollView(
        child: Container(
            decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                style: BorderStyle.solid, color: Colors.black54)),
            height: MediaQuery.of(context).size.height / 1.65,
            child:  
              
                       Consumer<MapDatas>(
                        builder: (context, prov, child) {
                          return ListView.builder(
                            itemCount: prov.getglobal_datasection.length,
                            itemBuilder: (context, i) {
                              return Card(
                               child:
                                Row(children: [

                                    Container(
                            
                                    padding: EdgeInsets.all(3),
                                    height: 50,
                                    width: 50,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            style: BorderStyle.solid,
                                            color: Colors.black,
                                            width: 1),
                                            
                                            
                                            ),

                                    child: Image.network(
                                       
                                      fit: BoxFit.cover,
                                      NamaServer.server +
                                          'hrd/uploademp/' +
                                          prov.getglobal_datasection[i]
                                              .pict_att!
                                              .toString() +
                                          '.jpg',
                                      frameBuilder: (context, child, frame,
                                          wasSynchronouslyLoaded) {
                                        return child;
                                      },
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        } else {
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                      },
                                    )),
                                  
                                Expanded(
                                    child:
                                    GestureDetector(
                                      child: 
                                     Container(
                                      margin: EdgeInsets.only(left: 5),
                                        padding: EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                                style: BorderStyle.solid)),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Text(
                                                      prov
                                                              .getglobal_datasection[
                                                                  i]
                                                              .nama!
                                                              .toString() +
                                                          " / " +
                                                          prov
                                                              .getglobal_datasection[
                                                                  i]
                                                              .nik!
                                                              .toString(),
                                                      style: TextStyle(
                                                          fontSize: 8,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      textAlign:
                                                          TextAlign.center),
                                                  Text(
                                                      prov
                                                              .getglobal_datasection[
                                                                  i]
                                                              .absen!
                                                              .toString() +
                                                          " / " +
                                                          prov
                                                              .getglobal_datasection[
                                                                  i]
                                                              .tglrec!
                                                              .toString(),
                                                      style: TextStyle(
                                                          fontSize: 7),
                                                      textAlign:
                                                          TextAlign.center),
                                                  Text(
                                                    prov
                                                        .getglobal_datasection[
                                                            i]
                                                        .lokasi
                                                        .toString(),
                                                    style:
                                                        TextStyle(fontSize: 7),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Icon(Icons.arrow_right)
                                          ],
                                        )
                                        ),
                                         onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AttbySection2(
                                              idno: prov
                                                  .getglobal_datasection[i].idno
                                                  .toString()),
                                        ));
                                  },    
                                    )

                                  ),
                                 
                            
                                ]
                                ),
                                
                              );
                            },
                          );
                     
                        }
              
                       ),
                          )             
                       ); 
  }


  Widget PickBegDate() {
    return Container(
      margin: EdgeInsets.only(left: 5, right: 5),
      height: 30,
      width: 100,
      padding: EdgeInsets.only(bottom: 10),

      // decoration: BoxDecoration(

      //     border: Border.all(style: BorderStyle.solid,color: Colors.black),
      //     borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
        ),
        style: TextStyle(color: Colors.black, fontSize: 10),
        textAlign: TextAlign.center,
        // textAlignVertical: TextAlignVertical.top,
        controller: _begDate,
        
       

        onTap: () async {
          DateTime? pickdate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2020),
              lastDate: DateTime(2035));

          if (pickdate != null) {
            final String formatdate = DateFormat("dd-MM-yyyy").format(pickdate);
            setState(() {
              _begDate.text = formatdate;
            });

           //  _getRefreshDataBySection();
          }
        },
      ),
    );
  }

  Widget PickEndDate() {
    return Container(
      margin: EdgeInsets.only(left: 5, right: 5),
      height: 30,
      width: 100,
      padding: EdgeInsets.only(bottom: 10),

      // decoration: BoxDecoration(

      //     border: Border.all(style: BorderStyle.solid,color: Colors.black),
      //     borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
        ),
        style: TextStyle(color: Colors.black, fontSize: 10),
        textAlign: TextAlign.center,
        // textAlignVertical: TextAlignVertical.top,
        controller: _endDate,
        
        
        
        onTap: () async {
          DateTime? pickdate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2020),
              lastDate: DateTime(2035));

          if (pickdate != null) {
            final String formatdate = DateFormat("dd-MM-yyyy").format(pickdate);
            setState(() {
              _endDate.text = formatdate;
            });

          //   _getRefreshDataBySection();
          }
        },
      ),
    );
  }

  Widget DropSection() {
    return Container(
        
        width: 300,
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.only(left: 5, right: 5),
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(5),
        //   border: Border.all(style: BorderStyle.solid,color: Colors.white)
        // ),
        child: Consumer<MapDatas>(
          builder: (context, prov, child) {
            return DropdownButtonFormField(
              
              iconSize: 10,
              style: TextStyle(color: Colors.black, fontSize: 6),
              decoration: InputDecoration(
                labelStyle: TextStyle(fontSize: 6),
                  label: Text(
                    "Section",
                    style: TextStyle(fontSize: 6, fontWeight: FontWeight.bold),
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(style: BorderStyle.solid))),
              items: prov.globalhrdsection
                  .map((e) => DropdownMenuItem(
                        child: Text(e.section.toString()),
                        value: e.section.toString(),
                      ))
                  .toList(),

                  onTap: () {
                     
                    
                    if (_tempListPerson=='')
                    {
                       //getMessage('null'); 
                    }else
                    {
                        getMessage('You will reset this'); 
                        Navigator.push(context, MaterialPageRoute(builder: (context) => new AttbySection(),));
                    }
                                
                  },
                 
              onChanged: (value) {
                setState(() {
                  _tempListSection = value;
                  // _tempListPerson = null;
                   
                });

                
                 getRefreshDrop2( _tempListSection!.toString());

                   //    _getRefreshDataBySection();
            
              
            
              },
            );
          },
        ));
  }

  Widget AllSectionNew() {
    return Container(
      width: 290,
     
      child:TextFormField(
        controller: _Text_Section,
        style: TextStyle(fontSize: 10),
        
        decoration: InputDecoration(
          suffixIcon: Icon(Icons.security),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(style: BorderStyle.solid),
          
         
          
          ),
          hintText: "Section"

        ),
        onChanged: (value) {
          _Text_Section.text=value;
          
        },
        onTap: () {
          getSearchSection();
        },
      )
    );
  }


   Widget AllPersonNew() {
    return Container(
      width: 290,
     
      child:TextField(
        
        controller: _Text_Person,
        style: TextStyle(fontSize: 10),
        
        decoration: InputDecoration(
          suffixIcon: Icon(Icons.person),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(style: BorderStyle.solid),
             
          
          ),
          hintText: "All Person"

        ),
         onChanged: (value) {
          _Text_Person.text=value;
        },
        onTap: () {
          setState(() {
              _tempListPerson='xx';
              _tempListSection='xx';
              //akhiri
             // _getRefreshDataBySection();
          });
        
            getSearchNIK();
        },
      )
    );
  }

  Widget DropPerson() {
    return Container(
        width: 300,
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.only(left: 5, right: 5),
        child:  Consumer<MapDatas>(
                builder: (context, prov, child) {
                  return DropdownButtonFormField(
                    iconSize: 8,
                    style: TextStyle(color: Colors.black,fontSize: 8),
                    decoration: InputDecoration(
                     
                        label: Text(
                          "All Person",
                          style: TextStyle(
                              fontSize: 8, fontWeight: FontWeight.bold),
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(style: BorderStyle.solid))),
                    items: prov.globalpersonsection
                        .map((e) => DropdownMenuItem(
                              child: Text(e.nama_person.toString()),
                              value: e.nik.toString(),
                            ))
                        .toList(),
                  //  value:_tempListSection,
               
                    //value: null,
                    onChanged: (value) {
                      setState(() {
                        _tempListPerson = value;
                      });
                    
                          //   _getRefreshDataBySection();
                    },
                  );
               
               
            }
        
        ));
  }
}
