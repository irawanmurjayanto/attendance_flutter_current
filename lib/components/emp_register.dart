import 'package:flutter/material.dart';
import 'package:flutter_attendance_current/provider/mapdatas.dart';
import 'package:provider/provider.dart';

class Emp_Register_NIK extends StatefulWidget {
  const Emp_Register_NIK({super.key});

  @override
  State<Emp_Register_NIK> createState() => _Emp_Register_NIKState();
}

class _Emp_Register_NIKState extends State<Emp_Register_NIK> {




  getSearchNIK2() async{
    // box.write("begdate", _begDate.text);
    // box.write("enddate", _endDate.text);
    // setState(() {
    //   _Text_Cari_Section.text='';
    //   _tempListSection='xx';
    //   _tempListPerson='xx';
    //     _TextCariName.text='';
    // });
    //  _getRefreshDataBySection;

  
    Provider.of<MapDatas>(context,listen: false).getListPerson_manualatt(_empregnik.text);
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
              controller: _empregnik,
              decoration: InputDecoration(
                hintText: "Type Name",
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

                          
                          onTap: () async {
                              
              setState(() {

                // _Text_Person.text=prov.globalperson_manualatt[i].nama_person!;
                // _tempListPerson=prov.globalperson_manualatt[i].nik!;
                // //forsectio
                // _tempListSection='';
                // _Text_Section.text='';
                
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






 final _empregnik=TextEditingController();
 final _NameType=TextEditingController();
getCariNIK() async {
  setState(() {
    _empregnik.text='';
  });
      Provider.of<MapDatas>(context,listen: false).getListPerson_manualatt(_empregnik.text);
  showDialog(context: context, builder: (context) {
    return SingleChildScrollView(

    child: 
    AlertDialog(
          title: Text('Name by NIK'),
          content: 
          
          Column(
          
            children: [
            //Name Type    
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Ketik Name',
                border: OutlineInputBorder(
                  borderSide: BorderSide(style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(5)
                )
              ),
            controller: _NameType,
            onChanged: (value) {
              setState(() {
              _NameType.text=value;  
              });
              
                 Provider.of<MapDatas>(context,listen: false).getListPerson_manualatt(value);
            },
          ),
          //Detail Data
           Container(
             decoration: BoxDecoration(
              border: Border.all(style: BorderStyle.solid)
          ),
            child: SingleChildScrollView(
             child:  Container(
                   height: MediaQuery.of(context).size.height/2.5,
child: 
              Consumer<MapDatas>(builder: (context, provx, child) {
                 return ListView.builder(
                  itemCount: provx.globalperson_manualatt.length,
                  itemBuilder: (context, i) {
                   return Container(
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(style: BorderStyle.solid,color: Colors.white),
                      color: Colors.black
                    ),
                       child: 
                          Text(provx.globalperson_manualatt[i].nama_person!+'('+provx.globalperson_manualatt[i].nik!+')',style: TextStyle(color: Colors.white,fontSize: 10),),
                        
                      );
                   
                 },);
              },)
             )
                
             ) 

            
           ) 


            ],
          )
    )

    );
  },);
} 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Employee Register'),
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      actions: [
        IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(Icons.close,size: 25,)),
        SizedBox(width: 10,)
      ],
      ),
      body: Container(
        margin: EdgeInsets.all(5),
        child: 
        Column(
        children: [
          TextField(
            controller: _empregnik,
            decoration: InputDecoration(
              hintText: 'Ketik NIK',
              border: OutlineInputBorder(
                borderSide: BorderSide(style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(5)
              )
            ),
          ),
          SizedBox(height: 10,),
         
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               SizedBox(width: 100,
               child: 
              ElevatedButton(onPressed: () {
                
              }, child: Button_car(Icons.save, 'Save')),
               ),
             
                
                  SizedBox(width: 10,),
                  SizedBox(width: 140,
               child:
                           ElevatedButton(onPressed: () {
                getCariNIK();
              //  getSearchNIK2();
                
              }, child: Button_car(Icons.cancel, 'Search NIK')),  
                )
            ],
          )
         
        ],
      ),
      )
    );
  }

 Widget Button_car(IconData icn,String ttle){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(icn,size: 20,),
      SizedBox(width: 5,),

      Text(ttle,style: TextStyle(fontSize: 10),),
    ],
  );
 }
}