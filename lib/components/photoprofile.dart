import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_attendance_current/components/server.dart';
import 'package:flutter_attendance_current/provider/mapdatas.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

class PhotoProfile extends StatefulWidget {
  const PhotoProfile({super.key});

  @override
  State<PhotoProfile> createState() => _PhotoProfileState();
}

class _PhotoProfileState extends State<PhotoProfile> {

  final box=GetStorage();

    String? imageCheck;
 
  Future  validateImage() async {
    http.Response res;
    try {
      res = await http.get(Uri.parse(NamaServer.server+'hrd/pictprofile/'+box.read('imei')+'.jpg'));
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
    Future.delayed(Duration(seconds: 2));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => new PhotoProfile()),);
  
      
                           
   // EasyLoading.show(status: "Getting Image");
      EasyLoading.dismiss();
 }

 Future uploadImage() async{
List<int> imageBytes = image!.readAsBytesSync();
String baseimage = base64Encode(imageBytes);
imageCache.clear();
imageCache.clearLiveImages();

await Provider.of<MapDatas>(context,listen: false).saveImageByNIK(context,box.read('imei'),baseimage);

 }



   @override
  void initState() {
    validateImage();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text("Photo Profile"),),
      body: Container(
        color: Colors.grey,
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width/1.2,
            height: MediaQuery.of(context).size.height/1.8,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(10),
            
            ),
            child: GestureDetector(
              child:   imageCheck=="noImage"?Icon(Icons.photo_camera,size: 50,):
             Image.network(NamaServer.server+'hrd/pictprofile/'+box.read('imei')+'.jpg',fit:BoxFit.cover,
             frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
               return child;
             },
             loadingBuilder: (context, child, loadingProgress) {
               if (loadingProgress==null)
               {
                return child;
              
               }else
               {
                return Center(child:CircleAvatar());
               }

             },
             ),
             onTap: () {
               takePicture(ImageSource.camera);
             },
            
            ),
            //child: Text(box.read('imei')),
          ),
        ),
      ),
    );
  }
}