import 'package:flutter/material.dart';
import 'package:flutter_attendance_current/components/hrd_data_detail.dart';
import 'package:flutter_attendance_current/message/warning.dart';
import 'package:flutter_attendance_current/provider/mapdatas.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

class HrdCoordinat_cari extends StatefulWidget {
  const HrdCoordinat_cari({super.key});

  @override
  State<HrdCoordinat_cari> createState() => _HrdCoordinat_cariState();
}

class _HrdCoordinat_cariState extends State<HrdCoordinat_cari> {

  String? _tempHomebase;

 getSetLocalToPerson(String homebase,String nikperson) async{
  await Provider.of<MapDatas>(context,listen: false).getList_Location_Only();
  showDialog(context: context, builder: (context) {
    return AlertDialog(
      title: Text("Location To Person"),
      content: Consumer<MapDatas>(builder: (context, provx, child) {
        return  DropdownButtonFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(style: BorderStyle.solid)
            )
          ),
          hint: Text(homebase),
          items: provx.globallist_location_only.map((e) => DropdownMenuItem(child: 
         Text(e.homebase!),value: e.homebase!),
        ).toList(),
          onChanged: (value) {
            setState(() {
               _tempHomebase=value;
            });
         
        },);
        
      },),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(onPressed: () {
              Navigator.pop(context);
              //Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) =>new HrdCoordinat_cari() ));
            }, icon: Icon(Icons.cancel,size: 35,)),

            SizedBox(width: 5,),

               IconButton(onPressed: () async{
               // setMessage2(_tempHomebase!+'-'+nikperson);
             EasyLoading.show(status: 'Processing..')  ;
             await  Provider.of<MapDatas>(context,listen: false).setList_Location_Only(_tempHomebase!, nikperson);
             Navigator.pop(context);
             
               //Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) =>new HrdCoordinat_cari() ));
            }, icon: Icon(Icons.save,size: 35,))
          ],
        )
      ],
    );
  },);

 }

 getCari_location() async{
  Provider.of<MapDatas>(context,listen:false).getList_Location_Only();
  showDialog(context: context, builder: (context) {
    return AlertDialog(
          title: Text("List Location Target"),

    );
  },);
 }

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
      appBar: AppBar(title: Text("Coodinate Person",style: TextStyle(color: Colors.white),),
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      // actions: [
      //    IconButton(onPressed: () async{
      //      await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => new Hrd_Data_Detail_Search(NIK: '',Tipe: 'insert',),));
      //      //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Test));
      //     }, icon: Icon(Icons.add))
      // ],
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
                          Text(provx.globalperson_manualatt[i].nama_person!+'   ('+provx.globalperson_manualatt[i].homebase!+')',style: TextStyle(color: Colors.white,fontSize: 10),),
                          ),
                          SizedBox(width: 5,),
                          Icon(Icons.arrow_right,color: Colors.white,size: 30,) 
                          
                        ]
                        
                      ),
                      onTap: () async {
                        EasyLoading.show(status: 'Loading...');
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => Hrd_Data_Detail_Search(NIK: provx.globalperson_manualatt[i].nik!,Tipe: 'edit',)));
                        await getSetLocalToPerson(provx.globalperson_manualatt[i].homebase!,provx.globalperson_manualatt[i].nik!);
                       
                        EasyLoading.show(status: 'Loading...');
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