 // ignore_for_file: unused_import, use_key_in_widget_constructors, unused_local_variable, prefer_const_literals_to_create_immutables, prefer_const_constructors, deprecated_member_use, sized_box_for_whitespace, avoid_print, unused_field, prefer_is_empty

    import 'dart:convert';
    import 'dart:io';
    import 'package:flutter/material.dart';
    import 'package:image_picker/image_picker.dart';
    import 'package:http/http.dart' as http;
    
    class Camera2 extends StatefulWidget {
  // Camera2({super.key});

  @override
  State<Camera2> createState() => _CameraState();
}

class _CameraState extends State<Camera2> {

 File? image;
    
      List _images = [];
    
      final ImagePicker picker = ImagePicker();

//cara lain
     Future<void> uploadImage() async {
    var uploadurl = Uri.parse('https://irawan.angsoft.info/tests/flutter/image/test/image_upload.php');
    try{
      List<int> imageBytes = image!.readAsBytesSync();
      String baseimage = base64Encode(imageBytes);
      var response = await http.post(
          uploadurl,
          body: {
            'image': baseimage,
          }
      );
      if(response.statusCode == 200){
        var jsondata = json.decode(response.body);
        if(jsondata["error"]){
          print(jsondata["msg"]);
        }else{
          print("Upload successful");
        }
      }else{
        print("Error during connection to server");
      }
    }catch(e){
      print("Error during converting to Base64");
    }
  }




 Future sendImage2(ImageSource media) async {
   
       // var img = await picker.pickImage(source: media);
          var choosedimage = await picker.pickImage(source: media,imageQuality: 5) ;
        //set source: ImageSource.camera to get image from camera
       setState(() {
       image = File(choosedimage!.path);
    });
    
       var uploadurl = Uri.parse('https://irawan.angsoft.info/tests/flutter/image/test/image_upload.php');
    try{
      List<int> imageBytes = image!.readAsBytesSync();
      String baseimage = base64Encode(imageBytes);
      var response = await http.post(
          uploadurl,
          body: {
            'image': baseimage,
          }
      );
      if(response.statusCode == 200){
        var jsondata = json.decode(response.body);
        if(jsondata["error"]){
          print(jsondata["msg"]);
        }else{
         // print("Upload successful");
             var message = jsonDecode(response.body);
    
              // show snackbar if input data successfully
              final snackBar = SnackBar(content: Text(message['message']));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
    
        }
      }else{
        print("Error during connection to server");
      }
    }catch(e){
      print("Error during converting to Base64");
    }
    
      }


    
      //we can upload image from camera or from gallery based on parameter
      Future sendImage(ImageSource media) async {
    
        var img = await picker.pickImage(source: media);
    
        var uri = "https://irawan.angsoft.info/tests/flutter/image/test/image_upload.php";
    
        var request = http.MultipartRequest('POST', Uri.parse(uri));
    
        if(img != null){
    
          var pic = await http.MultipartFile.fromPath("image", img.path);

         // request.files.add(http.MultipartFile.fromBytes("image", File(img.path).readAsBytesSync(),filename: img.path));
    
         request.files.add(pic);
    
          await request.send().then((result) {
    
            http.Response.fromStream(result).then((response) {
    
              var message = jsonDecode(response.body);
    
              // show snackbar if input data successfully
              final snackBar = SnackBar(content: Text(message['message']));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
    
              //get new list images 
              getImageServer();
            });
    
          }).catchError((e) {
    
            print(e);
    
          });
        }
    
      }
    
      Future getImageServer() async {
        try{
    
          final response = await http.get(Uri.parse('https://irawan.angsoft.info/tests/flutter/image/test/list.php'));
    
          if(response.statusCode == 200){
            final data = jsonDecode(response.body);
    
            setState(() {
              _images = data;
            });
          }
    
        }catch(e){
    
          print(e);
          
        }
      }
    

  
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}