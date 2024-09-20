import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_attendance_current/components/orientation.dart';
import 'package:flutter_attendance_current/components/refresh/testrefresh.dart';
import 'package:flutter_attendance_current/components/server.dart';
import 'package:flutter_attendance_current/message/warning.dart';
import 'package:flutter_attendance_current/provider/mapdatas.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/services.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Hrd_Data_Detail_Search extends StatefulWidget {
  final String NIK;
  const Hrd_Data_Detail_Search({Key?key,required this.NIK}):super(key: key);

  @override
  State<Hrd_Data_Detail_Search> createState() => _Hrd_Data_Detail_SearchState(NIK:NIK);
}

class _Hrd_Data_Detail_SearchState extends State<Hrd_Data_Detail_Search> {
  final String NIK;
  _Hrd_Data_Detail_SearchState({required this.NIK});
  final box=GetStorage();


@override
  void didChangeDependencies() {
  // getCheck();
    
    // setState(() {
    //   _Text_Nik.text = provx.getglobalhrddetail_personal[0].nik!;
    //   _Text_Nama.text = provx.getglobalhrddetail_personal[0].nama_person!;
    //   // _Text_Email.text = provx.getglobalhrddetail_personal[0].email!;
    //   // _Text_Jabatan.text = provx.getglobalhrddetail_personal[0].jabatan!;
    //   // _Text_Section.text = provx.getglobalhrddetail_personal[0].section!;
    // //   _Text_TempatLahir.text = provx.getglobalhrddetail_personal[0].tempat_lahir!;
     

    // //  // String _temp_TanggalLahir=DateFormat('dd-MMM-yyyy').format(provx.getglobalhrddetail_personal[0].tgl_lahir!);
    // //    _Text_TanggalLahir.text = provx.getglobalhrddetail_personal[0].tgl_lahir!;
    // //   _Text_NoTelepon.text = provx.getglobalhrddetail_personal[0].no_telepon!; 
    // });
   
    
    
    

                
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
  final _Text_NoTelepon=TextEditingController();
  final _Text_Gender=TextEditingController();
  final _Text_Marital_Status=TextEditingController();
  final _Text_Usia=TextEditingController();
  final _Text_Alamat_Ktp=TextEditingController();
  final _Text_Alamat_Now=TextEditingController();
  final _Text_NamaContact=TextEditingController();
  final _Text_HubunganKeluarga=TextEditingController();
  final _Text_Pendidikan=TextEditingController();
  final _Text_Jurusan=TextEditingController();

  final _Text_Emp_Status=TextEditingController();
  final _Text_Status_Pegawai=TextEditingController();
  final _Text_Tgl_Masuk=TextEditingController();
  final _Text_Tgl_Resign=TextEditingController();

  final _Text_MasaKontrak1=TextEditingController();
  final _Text_MasaKOntrak2=TextEditingController();
  final _Text_RemarksMasaKontrak=TextEditingController();


   final _Text_KTP=TextEditingController();
  final _Text_JKN=TextEditingController();
  final _Text_KPJ=TextEditingController();
   final _Text_BPJS=TextEditingController();
  final _Text_NPWP=TextEditingController();
  final _Text_Rekening=TextEditingController();


  final _Text_NOHP=TextEditingController();
  final _Text_IstriSuami=TextEditingController();
  final _Text_anak1=TextEditingController();
  final _Text_anak2=TextEditingController();
  final _Text_anak3=TextEditingController();
 String _temp_image='';
 
 
  String?_temp_gender;
  String?_temp_gender_val;
  
  getStatusMale(){
 

    showDialog(context: context,
     builder: (context) {
       return AlertDialog(
        content: 
          FutureBuilder(future: Provider.of<MapDatas>(context,listen: false).getStatus_HRD(context,'gender'), 
          builder: (context, snapshot) {
            if (snapshot.connectionState==ConnectionState.waiting)
            {
              return Center(child: CircularProgressIndicator(),);
            }else
            {
              return Consumer<MapDatas>(builder: (context, provgender, child) {
                return ListView.builder(
                  itemCount: provgender.globalstatushrd.length,
                  itemBuilder: (context, i) {
                    return Card(
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white
                        ),
                        child: GestureDetector(
                          child: Text(provgender.globalstatushrd[i].status!,style: TextStyle(color: Colors.white),),
                          onTap: () {
                            
                          },
                        )
                      )
                    );
                  
                },);
              },);
            }
          },)
       );
     },);
  }

  getCheck() async{
    
    await Provider.of<MapDatas>(context,listen: false).getListPersonAll(context,NIK);
    final provx=Provider.of<MapDatas>(context,listen: false);

  //  setMessage2(provx.getglobalhrddetail_personal[0].nama_person!);

   
     setState(() {
      _Text_Nik.text = provx.getglobalhrddetail_personal[0].nik!;
      _Text_Nama.text = provx.getglobalhrddetail_personal[0].nama_person!;
      _Text_Email.text = provx.getglobalhrddetail_personal[0].email!;
      _Text_Jabatan.text = provx.getglobalhrddetail_personal[0].jabatan!;
      _Text_Section.text = provx.getglobalhrddetail_personal[0].section!;
      _Text_TempatLahir.text = provx.getglobalhrddetail_personal[0].tempat_lahir!;  
      _Text_TanggalLahir.text = provx.getglobalhrddetail_personal[0].tgl_lahir!;
      _Text_NoTelepon.text = provx.getglobalhrddetail_personal[0].no_telepon!; 
      _Text_Gender.text = provx.getglobalhrddetail_personal[0].gender!;  
      _Text_Marital_Status.text = provx.getglobalhrddetail_personal[0].marital_status!;
      _Text_Usia.text = provx.getglobalhrddetail_personal[0].usia!.toString(); 
      _Text_Alamat_Ktp.text = provx.getglobalhrddetail_personal[0].alamatktp!;
      _Text_Alamat_Now.text = provx.getglobalhrddetail_personal[0].alamatnow!; 
      _Text_NamaContact.text = provx.getglobalhrddetail_personal[0].nama_contack!;
      _Text_HubunganKeluarga.text = provx.getglobalhrddetail_personal[0].hubungan!; 
      _Text_Pendidikan.text = provx.getglobalhrddetail_personal[0].pendidikan!;
      _Text_Jurusan.text = provx.getglobalhrddetail_personal[0].jurusan!; 

       _Text_Emp_Status.text = provx.getglobalhrddetail_personal[0].status_emp!.toString()=='1'?'Active':'Non Active';
      _Text_Status_Pegawai.text = provx.getglobalhrddetail_personal[0].status_pegawai!; 
      _Text_Tgl_Masuk.text = provx.getglobalhrddetail_personal[0].awal_masuk!;
      _Text_Tgl_Resign.text = provx.getglobalhrddetail_personal[0].resign_tgl!; 
      _Text_MasaKontrak1.text = provx.getglobalhrddetail_personal[0].masa_kontrak1!; 
      _Text_MasaKOntrak2.text = provx.getglobalhrddetail_personal[0].masa_kontrak2!;
      _Text_RemarksMasaKontrak.text = provx.getglobalhrddetail_personal[0].remark_masakontrak!; 
      _Text_KTP.text = provx.getglobalhrddetail_personal[0].no_ktp!; 
      _Text_JKN.text = provx.getglobalhrddetail_personal[0].no_jkn!;
      _Text_KPJ.text = provx.getglobalhrddetail_personal[0].no_kpj!;     
      _Text_BPJS.text = provx.getglobalhrddetail_personal[0].No_BPJS!; 
      _Text_NPWP.text = provx.getglobalhrddetail_personal[0].npwp!;
      _Text_Rekening.text = provx.getglobalhrddetail_personal[0].rekening!; 


   
      _Text_NOHP.text = provx.getglobalhrddetail_personal[0].No_HP!;
      _Text_IstriSuami.text = provx.getglobalhrddetail_personal[0].Nama_Istrisuami!;     
      _Text_anak1.text = provx.getglobalhrddetail_personal[0].Nama_Anak1!; 
      _Text_anak2.text = provx.getglobalhrddetail_personal[0].Nama_Anak2!;
      _Text_anak3.text = provx.getglobalhrddetail_personal[0].Nama_Anak3!; 
      _temp_image=provx.getglobalhrddetail_personal[0].pict_profile!;

    });
   EasyLoading.dismiss();
  }



  File?image;
  final ImagePicker picker = ImagePicker();
  

   Future takePicture(ImageSource media) async {
   
       // var img = await picker.pickImage(source: media);
          var choosedimage = await picker.pickImage(source: media,imageQuality: 4,preferredCameraDevice: CameraDevice.rear) ;
        //set source: ImageSource.camera to get image from camera
       setState(() {
       image = File(choosedimage!.path);
    });
    uploadImage();
    Future.delayed(Duration(seconds: 2));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => new Hrd_Data_Detail_Search(NIK: NIK),));
  
    
 

     
    
         
       
                           
   // EasyLoading.show(status: "Getting Image");
      EasyLoading.dismiss();
 }


 Future uploadImage() async{
List<int> imageBytes = image!.readAsBytesSync();
String baseimage = base64Encode(imageBytes);
imageCache.clear();
imageCache.clearLiveImages();
 
await Provider.of<MapDatas>(context,listen: false).saveImageByNIK(context,NIK,baseimage);

 }

  String? imageCheck;
 
  Future  validateImage() async {
    http.Response res;
    try {
      res = await http.get(Uri.parse(NamaServer.server+'hrd/pictprofile/'+NIK+'.jpg'));
    } catch (e) {
      return false;
    }
    if (res.statusCode != 200) 
    {
      setState(() {
        imageCheck="noImage";
      });
    }
    
    //return imageCheck;
    
  } 

  
 
  @override
  void initState() {
    
   validateImage();
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
           Navigator.push(context,MaterialPageRoute(builder: (context) => new Hrd_Data_Detail_Search(NIK: ''),));
          }, icon: Icon(Icons.save)),

          IconButton(onPressed: () {
           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => new Hrd_Data_Detail_Search(NIK: ''),));
           //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Test));
          }, icon: Icon(Icons.add))
        ],
      ),
      body:  Container(
        height: MediaQuery.of(context).size.height/1.2,
        child: 
           SingleChildScrollView(
           child: Container(
          
            color: Colors.amber,
            child:  
                Container(
               
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)

                  ),
                  child: 
                
                 Column(
                        children: [

                              
                              SizedBox(height: 10,),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(style: BorderStyle.solid)
                                  ),
                                  child: 
                                
                                Text("Detail Data "+_Text_Nama.text,style: TextStyle(color: Colors.white,),textAlign: TextAlign.center,),
                                ),
                                
                                
                                SizedBox(height: 5,),  
                                
                                 Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 150,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          style: BorderStyle.solid
                                          
                                        )
                                      ),

                                     child:
                                     
                                     GestureDetector(
                                     child: imageCheck=='noImage'?
                                      Icon(Icons.photo_camera,size: 50,)
                                      :
                                     Image.network(
                                      
                                      fit: BoxFit.cover,
                                      NamaServer.server+'hrd/pictprofile/'+NIK+".jpg",
                                      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                                        return child;
                                      },
                                      loadingBuilder: (context, child, loadingProgress) {
                                        if (loadingProgress==null){
                                          return child;
                                        }else{
                                          return Center(child: CircularProgressIndicator(),);
                                        }
                                      },
                                      
                                      ),
                                      
                                    // _temp_image=='-'?Icon(Icons.photo_camera,size: 50,):Image.network(NamaServer.server+'hrd/pictprofile/'+_temp_image!+".jpg"),
                                     onTap: () {

                                     if (_Text_Nik.text.isEmpty)
                                     {
                                      setMessage2("NIK Must be available");
                                     }else{ 
                                     
                                     takePicture(ImageSource.camera);
                                     }

                                     },
                                     )
                                  //  child:Icon(Icons.photo_camera,size: 50,)
                                    ),
                                  ],
                                ),

                                

                           //top header 
                            SizedBox(height: 15,),  
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

                          SizedBox(height: 5,),  
                          TextField_HRD(_Text_Email, "Email"),
                          SizedBox(height: 5,), 
                          Row(
                            children: [
                              SizedBox(width: 170,
                              child: 
                              TextField_HRD(_Text_Jabatan, "Jabatan"),
                              ),
                              SizedBox(width: 5,),
                              Expanded(child: 
                              TextField_HRD(_Text_Section, "Section"),
                              )
                            ],
                          ),

                             SizedBox(height: 5,),
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
                              TextField_HRD(_Text_NoTelepon, "No Telepon"),
                              )
                            ],
                          ),
  
                          
                           SizedBox(height: 5,),
                            Row(
                            children: [
                              SizedBox(width: 100,
                              child: 
                              // TextField_HRD(_Text_Gender, "Gender"),
                                                        Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: TextField(
                                    
                                    style: TextStyle(fontSize: 10),
                                    controller: _Text_Gender,
                                    decoration: InputDecoration(
                                      labelStyle: TextStyle(fontSize: 12),
                                    labelText: 'Gender Status',
                                    hintText: 'Gender',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide(style: BorderStyle.solid)
                                      )  
                                    ),
                                  ),
                                )
                              ),
                              SizedBox(width: 5,),
                              SizedBox(width: 100,
                              child: 
                              TextField_HRD(_Text_Marital_Status, "Marital Status"),
                              ),
                              SizedBox(width: 5,),
                              Expanded(child: 
                              TextField_HRD(_Text_Usia, "Usia"),
                              )
                            ],
                          ),


                              SizedBox(height: 5,),
                              

                              TextField_HRD_Memo(_Text_Alamat_Ktp, "Alamat KTP"),
                             

                             SizedBox(height: 5,),
                              

                              TextField_HRD_Memo(_Text_Alamat_Ktp, "Alamat Tempat Tinggal"),
                               



                               SizedBox(height: 8,),
                            Row(
                            children: [
                              SizedBox(width: 170,
                              child: 
                              TextField_HRD(_Text_NamaContact, "Nama Contact"),
                              ),
                              SizedBox(width: 5,),
                              Expanded( 
                              child: 
                              TextField_HRD(_Text_HubunganKeluarga, "Hubungan Keluarga"),
                              ),
                              
                            ],
                          ), 


                          
                               SizedBox(height: 5,),
                            Row(
                            children: [
                              SizedBox(width: 170,
                              child: 
                              TextField_HRD(_Text_Pendidikan, "Pendidikan"),
                              ),
                              SizedBox(width: 5,),
                              Expanded( 
                              child: 
                              TextField_HRD(_Text_Jurusan, "Jurusan"),
                              ),
                              
                            ],
                          ),   
                                SizedBox(height: 10,),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(style: BorderStyle.solid)
                                  ),
                                  child: 
                                
                                Text("Employee Status",style: TextStyle(color: Colors.white,),textAlign: TextAlign.center,),
                                ),
                                 SizedBox(height: 5,),
                            Row(
                            children: [
                              SizedBox(width: 170,
                              child: 
                              TextField_HRD(_Text_Emp_Status, "Employes Status"),
                              ),
                              SizedBox(width: 5,),
                              Expanded( 
                              child: 
                              TextField_HRD(_Text_Status_Pegawai, "Status Pegawai"),
                              ),
                              
                            ],
                          ), 

                          
                             SizedBox(height: 5,),
                            Row(
                            children: [
                              SizedBox(width: 170,
                              child: 
                              TextField_HRD(_Text_Tgl_Masuk, "Tanggal Masuk"),
                              ),
                              SizedBox(width: 5,),
                              Expanded( 
                              child: 
                              TextField_HRD(_Text_Tgl_Resign, "Tanggal Resign"),
                              ),
                              
                            ],
                          ),



                          
                             SizedBox(height: 5,),
                            Row(
                            children: [
                              SizedBox(width: 170,
                              child: 
                              TextField_HRD(_Text_MasaKontrak1, "Awal Kontrak"),
                              ),
                              SizedBox(width: 5,),
                              Expanded( 
                              child: 
                              TextField_HRD(_Text_MasaKOntrak2, "Akhir Kontrak"),
                              ),
                              
                            ],
                          ),

                          SizedBox(height: 5,),

                          TextField_HRD(_Text_RemarksMasaKontrak, "Remarks Masa Kontrak"), 


                          SizedBox(height: 10,),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(style: BorderStyle.solid)
                                  ),
                                  child: 
                                
                                Text("Document Number",style: TextStyle(color: Colors.white,),textAlign: TextAlign.center,),
                                ),
                                

                               
                          
                             SizedBox(height: 5,),
                            Row(
                            children: [
                              SizedBox(width: 170,
                              child: 
                              TextField_HRD(_Text_KTP, "NO. KTP"),
                              ),
                              SizedBox(width: 5,),
                              Expanded( 
                              child: 
                              TextField_HRD(_Text_JKN, "NO. JKN"),
                              ),
                              
                            ],
                          ), 

                              SizedBox(height: 5,),
                            Row(
                            children: [
                              SizedBox(width: 170,
                              child: 
                              TextField_HRD(_Text_KPJ, "NO. KPJ"),
                              ),
                              SizedBox(width: 5,),
                              Expanded( 
                              child: 
                              TextField_HRD(_Text_BPJS, "NO. BPJS"),
                              ),
                              
                            ],
                          ), 

                             SizedBox(height: 5,),
                            Row(
                            children: [
                              SizedBox(width: 170,
                              child: 
                              TextField_HRD(_Text_NPWP, "NO. NPWP"),
                              ),
                              SizedBox(width: 5,),
                              Expanded( 
                              child: 
                              TextField_HRD(_Text_Rekening, "NO. REKENING"),
                              ),
                              
                            ],
                          ),  


                          
                          SizedBox(height: 10,),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(style: BorderStyle.solid)
                                  ),
                                  child: 
                                
                                Text("Keluarga",style: TextStyle(color: Colors.white,),textAlign: TextAlign.center,),
                                ),

                                
                             SizedBox(height: 5,),
                            Row(
                            children: [
                              SizedBox(width: 170,
                              child: 
                              TextField_HRD(_Text_NOHP, "NO. Handphone"),
                              ),
                              SizedBox(width: 5,),
                              Expanded( 
                              child: 
                              TextField_HRD(_Text_IstriSuami, "Nama Istri/Suami"),
                              ),
                              
                            ],
                          ),  

                                  SizedBox(height: 5,),
                            Row(
                            children: [
                              SizedBox(width: 170,
                              child: 
                              TextField_HRD(_Text_anak1, "Anak 1"),
                              ),
                              SizedBox(width: 5,),
                              Expanded( 
                              child: 
                              TextField_HRD(_Text_anak2, "Anak 2"),
                              ),
                               SizedBox(width: 5,),
                              Expanded( 
                              child: 
                              TextField_HRD(_Text_anak3, "Anak 3"),
                              ),
                              
                              
                            ],
                          ),  

                                     
                          

                        ],
                      )
                     )
                    )
                    
               
                )
                
           
             
          ),
       
      
      );
   
    
  }


  Widget TextField_HRD_Memo(TextEditingController x,String hintT) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: TextFormField(
        maxLines: 2,
        style: TextStyle(fontSize: 10),
        controller: x,
        decoration: InputDecoration(
          labelStyle: TextStyle(fontSize: 12),
          
        labelText: hintT,
         hintText: hintT,
           border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(style: BorderStyle.solid)
           )  
        ),
      ),
    );
  }

  Widget TextField_HRD(TextEditingController x,String hintT) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: TextField(
        
        style: TextStyle(fontSize: 10),
        controller: x,
        decoration: InputDecoration(
          labelStyle: TextStyle(fontSize: 12),
        labelText: hintT,
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