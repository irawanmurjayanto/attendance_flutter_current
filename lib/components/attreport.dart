import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  final String datenow = DateFormat("dd-MM-yyyy").format(DateTime.now());
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
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white
              
              ),
            
            padding: EdgeInsets.all(5),
            child: Column(
              children: [
                //datepicker
                Row(
                  children: [
                    Flexible(
                      child: PictBegDate(),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(" To "),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: PictBegDate(),
                    )
                  ],
                ),
                SizedBox(height: 5,),
                DropSection(),
                SizedBox(height: 5,),
                SizedBox(width: 150,
                  child: 
                ElevatedButton(
                  
                  onPressed: () {
                  
                }, child:Row(
                   children: [
                    Icon(Icons.production_quantity_limits),
                    SizedBox(width: 5,),
                    Text("Process")
                   ], 
                ))
                ),

              ],
            )));
  }

  Widget PictBegDate() {
    return Container(
      margin: EdgeInsets.only(left: 5,right: 5),
      height: 30,
      decoration: BoxDecoration(
        
          border: Border.all(style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        textAlign: TextAlign.center,
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
      child: 
      TextFormField(

      )
    );
  }

  Widget DropSection() {
    return Container( 
      height: 35,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.only(left: 5,right: 5),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      border: Border.all(style: BorderStyle.solid)
    ),
    child:Consumer<MapDatas>(
      builder: (context, prov, child) {
        return DropdownButtonFormField(
          decoration: InputDecoration(
            labelText: "Pilih Section"
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
