import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_attendance_current/components/server.dart';
import 'package:flutter_attendance_current/provider/mapdatas.dart';
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
  String? _temptgl1;
  String? _temptgl2;
  
  final String datenow = DateFormat("dd-MM-yyyy").format(DateTime.now());

 

  _getRefreshDataBySection() async{
  // final String tgl1=DateFormat('yyyy-MM-dd').format(DateTime.parse(_begDate.text)); 
  // final String tgl2=DateFormat('yyyy-MM-dd').format(DateTime.parse(_endDate.text)); 

  setState(() {
  _temptgl1=_begDate.text;
  _temptgl2=_endDate.text;
  });

   Provider.of<MapDatas>(context,listen: false).getDataBySection(_begDate.text, _endDate.text,_tempListSection.toString());
  }
  getDateNow() async {
    _begDate.text = datenow;
    _endDate.text = datenow;
  }

  getRefresh() async{
    Provider.of<MapDatas>(context,listen: false).getListSection();
  }

  String? _tempListSection;

  @override
  void initState() {
    getDateNow();
    getRefresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Attendance Report"),
        ),
        backgroundColor: Colors.grey,
        body: Container(
            margin: EdgeInsets.only(top:15,left:5,right:10),
            
            width: double.infinity,
           // height: MediaQuery.sizeOf(context).height,
            // decoration: BoxDecoration(
            //   color: Colors.white,
            //   border: Border.all(style: BorderStyle.solid,color: Colors.white),
            //   borderRadius: BorderRadius.circular(5),
             
            //   ),
            
            padding: EdgeInsets.only(top:15,left:5,right:5),
            child: Column(
             // mainAxisAlignment: MainAxisAlignment.center,
             // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //datepicker
                Container(
                    color: Colors.black87,
                  child: Column(
                    children: [

                             Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: 
                     
                         PickBegDate(),
                      
                    
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(" To ",style: TextStyle(color: Colors.black),),
                    SizedBox(
                      width: 10,
                    ),
                   Flexible(
                      child: PickEndDate(),
                    )
                  ],
                ),
                SizedBox(height: 55,
                child:  DropSection(),
                ),
               
                SizedBox(height: 5,),
                SizedBox(width: 150,
                  child: 
                ElevatedButton(
                  
                  onPressed: () {
                  
                        _getRefreshDataBySection();
                

                }, child:Row(
                   children: [
                    Icon(Icons.production_quantity_limits,size: 20,),
                    SizedBox(width: 5,),
                    Text("Process",style: TextStyle(fontSize: 8),)
                   ], 
                ))
                ),

                    ],
                  )
                )


             ,
               SizedBox(height: 5,),
               WdDataBySection(),
              ],
            )));
  }


Widget WdDataBySection() {
  return SingleChildScrollView(
    child: Container(
      color: Colors.amber,
        height: MediaQuery.of(context).size.height/1.7,

      child: 
      
       RefreshIndicator(
    onRefresh: () => _getRefreshDataBySection(),
    child: FutureBuilder(
      future: Provider.of<MapDatas>(context,listen: false).getDataBySection(_temptgl1.toString(), _temptgl2.toString(),_tempListSection.toString())
    , builder: (context, snapshot) {

      if (snapshot.connectionState==ConnectionState.waiting)
      {
        return Center(child: CircularProgressIndicator(),);
      }else{
        return Consumer<MapDatas>(builder: (context, prov, child) {
          return ListView.builder(
            itemCount: prov.getglobal_datasection.length,
            itemBuilder: (context, i) {
                return ListTile(
                  leading: 
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(style: BorderStyle.solid,color: Colors.white)
                        ),
                    child: 
                      
                     Image.network(
                      fit: BoxFit.cover,
                  NamaServer.server+'hrd/uploademp/'+prov.getglobal_datasection[i].pict_att!.toString()+'.jpg',
                  frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                    return child;
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress==null)
                    {
                      return child;
                    }else{  
                      return Center(child: CircularProgressIndicator(),);
                    }
                  },
                  )
                 
                  
                  ),
                  
                  title:Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(style: BorderStyle.solid)
                        ),
                        child: 
                        Column(
                          children: [

                      Text(prov.getglobal_datasection[i].nama!.toString()+" / "+prov.getglobal_datasection[i].nik!.toString(),style: TextStyle(fontSize: 8,fontWeight: FontWeight.bold),),
                      Text(prov.getglobal_datasection[i].absen!.toString()+" / "+prov.getglobal_datasection[i].tglrec!.toString(),style: TextStyle(fontSize: 7),),
                      Text(prov.getglobal_datasection[i].lokasi.toString(),style: TextStyle(fontSize: 7),),
                      
                          ],
                        )
                      )
                   
                    ],
                  ),
                ) ; 
          },);
        },);
      }
      
    },
    
    )
      
       )
    )

    
    
    
   
   
  );
}


  Widget PickBegDate() {
    return Container(
      margin: EdgeInsets.only(left: 5,right: 5),
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
        style: TextStyle(
          color: Colors.black,fontSize: 10
        ),
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
          }
        },
      ),
    );
  }

  Widget PickEndDate(){
   return Container(
      margin: EdgeInsets.only(left: 5,right: 5),
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
        style: TextStyle(
          color: Colors.black,fontSize: 10
        ),
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
          }
        },
      ),
    );
  }

  Widget DropSection() {
    return Container( 
   
      width: 265,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.only(left: 5,right: 5),
    // decoration: BoxDecoration(
    //   borderRadius: BorderRadius.circular(5),
    //   border: Border.all(style: BorderStyle.solid,color: Colors.white)
    // ),
    child:Consumer<MapDatas>(
      builder: (context, prov, child) {
        return DropdownButtonFormField(

              style: TextStyle(color: Colors.black),
           
          decoration: InputDecoration(
             label: Text("Pilih Section",style: TextStyle(fontSize: 6),),
        
             border: OutlineInputBorder(
                borderSide: BorderSide(style: BorderStyle.solid)
            )
           
          ),
          items: prov.globalhrdsection
              .map((e) => DropdownMenuItem(
                    child: Text(e.section.toString()),
                    value: e.section.toString(),
                  ))
              .toList(),
          onChanged: (value) {
            setState(() {
              _tempListSection = value;
            });
          },
        );
      },
    )
    );
  }
}
