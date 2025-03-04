 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_attendance_current/components/server.dart';
import 'package:flutter_attendance_current/message/warning.dart';
import 'package:flutter_attendance_current/provider/mapdatas.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

 class AttbySection2 extends StatefulWidget {
  final String idno;
  const AttbySection2({Key?key,required this.idno});

  @override
  State<AttbySection2> createState() => _AttbySection2State(idno:idno);
}

class _AttbySection2State extends State<AttbySection2> {

final String idno;
_AttbySection2State({required this.idno});


final _text_editdate=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail Data : '+idno),),
    
body: SingleChildScrollView(
        child: Center(child: WdLoadData(context))),
      );
    
  }

  Widget WdLoadData(BuildContext context){
    
    return   
    Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.amberAccent,
        borderRadius: BorderRadius.circular(10)
      ),
      height: MediaQuery.of(context).size.height,
        child:FutureBuilder(future:Provider.of<MapDatas>(context,listen: false).getDataBySection_idno(idno!),
         builder: (context, snapshot) {
           if (snapshot.connectionState==ConnectionState.waiting)
           {
            return Center(child: CircularProgressIndicator(),);
           }else{
            return Consumer<MapDatas>(builder: (context, prov, child) {
              return ListView.builder(
                itemCount: prov.getglobal_datasection_idno.length,
                itemBuilder: (context, i) {
                  return ListTile(
                      title:  Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                         crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(prov.getglobal_datasection_idno[i].nama!+' / '+prov.getglobal_datasection_idno[i].nik!+' / '+prov.getglobal_datasection_idno[i].section!,textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold),),
                          SizedBox(height: 10,),
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(10)
                            ),
                             height: 250,
                             width: 250,
                             child: Image.network(NamaServer.server+'hrd/uploademp/'+prov.getglobal_datasection_idno[i].pict_att!+'.jpg',
                             fit: BoxFit.cover,
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
                             ), 
                          ),
                            SizedBox(height: 10,),
                            Row(
                              children:[
                          Text(prov.getglobal_datasection_idno[i].absen!+' / '+prov.getglobal_datasection_idno[i].tglrec!,textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(height: 5,),
                            IconButton(onPressed: () {
                              //jam
                              setState(() {
                                _text_editdate.text=prov.getglobal_datasection_idno[i].tglrec!;
                              });
                              showDialog(context: context, builder: (context) {

                                return AlertDialog(
                                    title: Text("Edit Date "+prov.getglobal_datasection_idno[i].idno!.toString()),
                                    content: TextField(
                                      controller: _text_editdate,
                                      onChanged: (value) {
                                        // setState(() {
                                        //      _text_editdate.text=value;
                                        // });
                                     
                                      },
                                    ),
                                  actions: [
                                      Row(
                                        children: [
                                          IconButton(onPressed: () {
                                          Navigator.pop(context);
                                          }, icon: Icon(Icons.close)),

                                          IconButton(onPressed: ()async {
                                              getStatusInet(context);
                                            EasyLoading.show(status: 'Processing..');
                                            setMessage2(prov.getglobal_datasection_idno[i].idno!.toString()+'--'+_text_editdate.text);
                                            await Provider.of<MapDatas>(context,listen: false).saveDataBySectionbyDate(prov.getglobal_datasection_idno[i].idno!.toString(), _text_editdate.text);
                                            EasyLoading.dismiss();
                                            Navigator.pop(context);
                                          }, icon: Icon(Icons.save))
                                        ],
                                      )
                                  ],
                                  
                                );

                              },);
                            }, icon: Icon(Icons.edit),iconSize: 30),

                            ]),
                            SizedBox(height: 10,),
                          Text(prov.getglobal_datasection_idno[i].lokasi!,textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold)),

                        ],
                      )
                  );
                
              },);
              
            },);
           }

         },)
    
    );
  }


  
}