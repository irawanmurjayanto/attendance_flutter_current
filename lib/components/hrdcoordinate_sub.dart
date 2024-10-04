import 'package:flutter/material.dart';
import 'package:flutter_attendance_current/components/hrdcoordinate.dart';
import 'package:flutter_attendance_current/message/warning.dart';
import 'package:flutter_attendance_current/provider/mapdatas.dart';
import 'package:provider/provider.dart';

class HrdcoordinateSub extends StatefulWidget {
  
  final int idno;
  final String homebase;

  const HrdcoordinateSub({Key?key,required this.idno,required this.homebase}):super(key:key);


  @override
  State<HrdcoordinateSub> createState() => _HrdcoordinateSubState(idno:idno,homebase:homebase);
}

class _HrdcoordinateSubState extends State<HrdcoordinateSub> {

  final int idno;
  final String homebase;

   _HrdcoordinateSubState({required this.idno,required this.homebase});

   final _Text_lat1=TextEditingController();
   final _Text_lat2=TextEditingController();
   final _Text_long1=TextEditingController();
   final _Text_long2=TextEditingController();
   final _Text_homebase=TextEditingController();
   String?_temp_t1;

   _getRefreshData() async{
   
    final provx=Provider.of<MapDatas>(context,listen: false) ;
    await Provider.of<MapDatas>(context,listen: false).getList_Coordinate_edit(idno.toString());
   // setMessageAll(context, provx.globallistgoogle_edit[0].lat1.toString());
    setState(() {
       _temp_t1=provx.globallistgoogle_edit[0].lat1.toString();
      _Text_lat1.text=provx.globallistgoogle_edit[0].lat1.toString()??'';
      _Text_lat2.text=provx.globallistgoogle_edit[0].lat2.toString()??'';
      _Text_long1.text=provx.globallistgoogle_edit[0].long1.toString()??'';
      _Text_long2.text=provx.globallistgoogle_edit[0].long2.toString()??'';
      _Text_homebase.text=provx.globallistgoogle_edit[0].homebase!;
    });
   }


   @override
  void initState() {
     
    _getRefreshData();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Home Base for '+homebase,style: TextStyle(fontSize: 16,color: Colors.white),),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(onPressed: ()async {
            Provider.of<MapDatas>(context,listen: false).getList_Coordinate_save( _Text_lat1.text, _Text_lat2.text, _Text_long1.text, _Text_long2.text,homebase);
            Navigator.pop(context);
            await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => new Hrd_Coordinate_set()));
          }, icon: Icon(Icons.save,size: 30,))
        ],
        ),
        body: Container(
          child: Column(
            children: [
             SizedBox(height: 10,),  
              WEntry_value(_Text_lat1, 'Latitude 1'),
             SizedBox(height: 5,),  
              WEntry_value(_Text_lat2, 'Latitude 2'),

              SizedBox(height: 10,),  
              WEntry_value(_Text_long1, 'Longitude 1'),
             SizedBox(height: 5,),  
              WEntry_value(_Text_long2, 'Longitude 2') 
            ],
          )
        ),
    );
  }

  Widget WEntry_value(TextEditingController str,String labelT){
    return Container(
      margin: EdgeInsets.all(5),
      child: TextFormField(
          controller: str,
         
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(style: BorderStyle.solid)
            
            ),
            labelText: labelT,
            hintText: 'Lat1',
            labelStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.black)
          ),
          onChanged: (value) {
            str.text=value;
          },
      )
    );
  }
}