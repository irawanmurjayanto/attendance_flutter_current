import 'package:flutter/cupertino.dart';
import 'package:flutter_attendance_current/components/hrd_data_detail.dart';
import 'package:flutter_attendance_current/components/server.dart';
import 'package:flutter_attendance_current/message/warning.dart';
import 'package:flutter_attendance_current/provider/mapdatas.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

class PhotoData extends StatefulWidget {
  const PhotoData({super.key});

  @override
  State<PhotoData> createState() => _PhotoDataState();
}

class _PhotoDataState extends State<PhotoData> {

 final box=GetStorage(); 


 String? imageCheck;
 String? _NIK_Temp;

 
  Future  validateImage() async {
    http.Response res;
    try {
      res = await http.get(Uri.parse(NamaServer.server+'hrd/pictprofile/'+box.read("NIK")+'.jpg'));
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
    setState(() {
      
    });
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>new  Hrd_Data_Detail_Search(NIK: box.read("NIK"),),));
       
                           
   // EasyLoading.show(status: "Getting Image");
      EasyLoading.dismiss();
 }


 Future uploadImage() async{
List<int> imageBytes = image!.readAsBytesSync();
String baseimage = base64Encode(imageBytes);


 
await Provider.of<MapDatas>(context,listen: false).saveImageByNIK(context,box.read("NIK"),baseimage);

 }

    @override
  void initState() {
    _NIK_Temp=box.read("NIK");
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(5),
    
    );
  }



}