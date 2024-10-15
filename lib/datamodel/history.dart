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
    section = json['section'] ?? "x";
    pict_att = json['pict_att'] ?? "x" ; 
  }


 

}


class DataBySection{

 

 
   String? nik;
   String? nama;
   String? tglrec;
   String? absen;
   String? lokasi;
   String? section;
   String? pict_att;
   int? idno;
   

DataBySection({
 
  this.nik,
  this.nama,
  this.tglrec,
  this.absen,
  this.lokasi,
  this.section,
  this.pict_att,
   this.idno,
 
 
});


 DataBySection.fromJson(Map<String, dynamic> json) {
  
    nik = json['nik'];
    nama = json['nama'];
    tglrec = json['tglrec'];
    absen = json['absen'];
    lokasi = json['lokasi'];
    section = json['section'] ?? "x";
    pict_att = json['pict_att'] ?? "x" ; 
     idno = json['idno'];
  }


 

}

class DataBySection_idno{

 

 
   String? nik;
   String? nama;
   String? tglrec;
   String? absen;
   String? lokasi;
   String? section;
   String? pict_att;
   int? idno;
   

DataBySection_idno({
 
  this.nik,
  this.nama,
  this.tglrec,
  this.absen,
  this.lokasi,
  this.section,
  this.pict_att,
  this.idno,
 
 
});


 DataBySection_idno.fromJson(Map<String, dynamic> json) {
  
    nik = json['nik'];
    nama = json['nama'];
    tglrec = json['tglrec'];
    absen = json['absen'];
    lokasi = json['lokasi'];
    section = json['section'] ?? "x";
    pict_att = json['pict_att'] ?? "x" ; 
     idno = json['idno'];
  }


 

}




class DataBySection_person{

 

   String? nik;
   String? nama_person;
   String? homebase;
    

DataBySection_person({
  this.nik,
  this.nama_person,
  this.homebase,
});


 DataBySection_person.fromJson(Map<String, dynamic> json) {
  
    nik = json['nik'];
    nama_person = json['nama_person'];
    homebase = json['homebase']??'-';
  
  }


 

}





class DataNama_person_NIK{

 

   String? nik;
   String? nama_person;
   String? homebase;
   String? deptsal;
    

DataNama_person_NIK({
  this.nik,
  this.nama_person,
  this.homebase,
  this.deptsal,
});


 DataNama_person_NIK.fromJson(Map<String, dynamic> json) {
  
    nik = json['nik'];
    nama_person = json['nama_person']??'-';
    homebase = json['homebase']??'-';
    deptsal = json['deptsal']??'-';
  
  }


 

}