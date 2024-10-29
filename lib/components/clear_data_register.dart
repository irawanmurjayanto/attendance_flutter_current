import 'package:flutter/material.dart';
import 'package:flutter_attendance_current/components/hrd_data_detail.dart';
import 'package:flutter_attendance_current/provider/mapdatas.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

class Clear_Data_Register extends StatefulWidget {
  const Clear_Data_Register({super.key});

  @override
  State<Clear_Data_Register> createState() => _Clear_Data_RegisterState();
}

class _Clear_Data_RegisterState extends State<Clear_Data_Register> {

  final _Text_Cari=TextEditingController();
  @override
  void initState() {
    setState(() {
    _Text_Cari.text='';  
    });
    
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Clear Data Register",style: TextStyle(color: Colors.white),),
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      actions: [
         IconButton(onPressed: () async{
           await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => new Hrd_Data_Detail_Search(NIK: '',Tipe: 'insert',),));
           //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Test));
          }, icon: Icon(Icons.add))
      ],
      ),
    body:    SingleChildScrollView(
      child: 
     Container(
      margin: EdgeInsets.all(5),
        child: Column(
          children: [
             //Text Searching 
            TextFormField(
          controller: _Text_Cari,
          autofocus: true,
          decoration: InputDecoration(
            hintText: "Name Search",
            border:OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(style: BorderStyle.solid)
            )

            ),
            onChanged: (value) {
              _Text_Cari.text=value;
              Provider.of<MapDatas>(context,listen: false).getListPerson_manualatt_google(_Text_Cari.text);
            },
          ),


          //result
          SingleChildScrollView(
            child: 
            Container(
              height: MediaQuery.of(context).size.height,
              child: 
          FutureBuilder(future: Provider.of<MapDatas>(context,listen: false).getListPerson_manualatt_google(_Text_Cari.text),
          builder: (context, snapshot) {
            if (snapshot.connectionState==ConnectionState.waiting)
            {
              return Center(child: CircularProgressIndicator(),);

            } else
            {
              return  Consumer<MapDatas>(builder: (context, provx, child) {
                return ListView.builder(
                  itemCount: provx.globalperson_manualatt.length,
                  itemBuilder: (context, i) {
                  return Card(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(5)  
                        ),
                        child: 
                        GestureDetector(child: 
                        Row(children: [
                          Expanded(child:
                          Text(provx.globalperson_manualatt[i].nama_person!,style: TextStyle(color: Colors.white),),
                          ),
                          SizedBox(width: 5,),
                          Icon(Icons.arrow_right,color: Colors.white,size: 30,) 
                          
                        ]
                        
                      ),
                      onTap: () {
                        // EasyLoading.show(status: 'Loading...');
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => Hrd_Data_Detail_Search(NIK: provx.globalperson_manualatt[i].nik!,Tipe: 'edit',)));
                        showDialog(context: context, builder: (context) {
                          return AlertDialog(
                              title: Text('Delete Register : '+provx.globalperson_manualatt[i].nama_person!+'-'+provx.globalperson_manualatt[i].nik!,style: TextStyle(fontSize: 12),),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('Ada ingin delete data ini ?'),
                                  SizedBox(height: 5,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(onPressed: () {
                                        Navigator.pop(context);
                                      }, child: Text('No')),
                                      SizedBox(width: 5,),
                                      ElevatedButton(onPressed: () async {
                                        await Provider.of<MapDatas>(context,listen: false).provEmpReg_Del_Register(context, provx.globalperson_manualatt[i].nik!);
                                        Navigator.pop(context);
                                      }, child: Text('Yes')),
                                        
                                    ],
                                  )
                                  
                                ],
                              ),


                          );
                        },);
                      },
                        )
                      )
                  );
                  
                },);
              },);
            } 
          }, 
)
            )
          )
          ],
        )
    
        ),
    ) 
    );
  }
}