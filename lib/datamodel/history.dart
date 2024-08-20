class DataModel{

   int? idno;
   String? title;
   String? imei_no; 
   String? keyno;
   double? map_lat;
   double? map_long;
   String? image;
   String? tgl_rec;

DataModel({
  this.idno,
  this.title,
  this.imei_no,
  this.keyno,
  this.map_lat,
  this.map_long,
  this.image, 
  this.tgl_rec, 

});


 DataModel.fromJson(Map<String, dynamic> json) {
    idno = json['idno'];
    title = json['title'];
    imei_no = json['imei_no'];
    keyno = json['keyno'];
    map_lat = json['map_lat'];
    map_long = json['map_long'];
    image = json['image'];
    tgl_rec = json['tgl_rec'];
   
    
  }


 

}