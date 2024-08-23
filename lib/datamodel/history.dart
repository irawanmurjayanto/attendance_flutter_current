class DataModel{

 

   int? idno;
   String? nik;
   String? nama;
   String? tglrec;
   String? absen;
   String? lokasi;
   String? section;
   String? pict_att;
   

DataModel({
  this.idno,
  this.nik,
  this.nama,
  this.tglrec,
  this.absen,
  this.lokasi,
  this.section,
  this.pict_att,
 
 
});


 DataModel.fromJson(Map<String, dynamic> json) {
    idno = json['idno'];
    nik = json['nik'];
    nama = json['nama'];
    tglrec = json['tglrec'];
    absen = json['absen'];
    lokasi = json['lokasi'];
    section = json['section'];
    pict_att = json['pict_att']; 
  }


 

}