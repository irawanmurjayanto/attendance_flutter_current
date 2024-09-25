import 'package:flutter/material.dart';
import 'package:flutter_attendance_current/components/hrd_data_detail.dart';
import 'package:flutter_attendance_current/provider/mapdatas.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

class Hrd_Data_Cari extends StatefulWidget {
  const Hrd_Data_Cari({super.key});

  @override
  State<Hrd_Data_Cari> createState() => _Hrd_Data_CariState();
}

class _Hrd_Data_CariState extends State<Hrd_Data_Cari> {

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
      appBar: AppBar(title: Text("Data Searching..",style: TextStyle(color: Colors.white),),
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      actions: [
         IconButton(onPressed: () async{
           await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => new Hrd_Data_Detail_Search(NIK: ''),));
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
              Provider.of<MapDatas>(context,listen: false).getListPerson_manualatt(_Text_Cari.text);
            },
          ),


          //result
          SingleChildScrollView(
            child: 
            Container(
              height: MediaQuery.of(context).size.height,
              child: 
          FutureBuilder(future: Provider.of<MapDatas>(context,listen: false).getListPerson_manualatt(_Text_Cari.text),
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
                        EasyLoading.show(status: 'Loading...');
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Hrd_Data_Detail_Search(NIK: provx.globalperson_manualatt[i].nik!)));
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