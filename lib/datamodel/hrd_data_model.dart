
class HRD_Detail_Personal{

   String? nik;
   String? nama_person;
   String? email;
   String? section;
   String? jabatan;
   String? tempat_lahir;
   String? tgl_lahir;
   String? no_telepon;
   String? gender;
   String? marital_status;
   int? usia;
   String? alamatktp;
   String? alamatnow;
   String? nama_contack;
   String? hubungan;
   String? pendidikan;
   String? jurusan;
   int? status_emp;
   String? status_pegawai;
   String? awal_masuk;
   String? resign_tgl;
   String? masa_kontrak1;
   String? masa_kontrak2;
   String? remark_masakontrak;

   String? no_ktp;
   String? no_jkn;
   String? no_kpj;
   String? No_BPJS;
   String? npwp;
   String? rekening;

   String? No_HP;
   String? Nama_Istrisuami;
   String? Nama_Anak1;
   String? Nama_Anak2;
   String? Nama_Anak3;
 
   String? pict_profile;

 
  

  

 
 
 
  

 
  
  
  //  String? deptsal;
 



   HRD_Detail_Personal({
   this.nik,this.nama_person, this.email,this.section,this.jabatan,this.tempat_lahir,this.tgl_lahir,this.no_telepon,this.gender,this.marital_status,this.usia,this.alamatktp,this.alamatnow,this.nama_contack,this.hubungan,this.pendidikan,this.jurusan,this.status_emp,this.status_pegawai,this.awal_masuk,this.resign_tgl,this.masa_kontrak1,this.masa_kontrak2,this.remark_masakontrak,this.no_ktp,this.no_jkn,this.no_kpj,this.No_BPJS,this.npwp,this.rekening,this.No_HP,this.Nama_Istrisuami,this.Nama_Anak1,this.Nama_Anak2,this.Nama_Anak3,this.pict_profile
  //  
  //  ,
  //  ,, 
  //,
  //  ,this.deptsal,
  // 
   });
 


 HRD_Detail_Personal.fromJson(Map<String, dynamic> json) {
  
    nik = json['nik'] ?? '-';
    nama_person = json['nama_person'] ?? '-';
    email= json['email'] ?? '-';
    section= json['section'] ?? '-';
    jabatan = json['jabatan'] ?? '-';
    tempat_lahir = json['tempat_lahir'] ?? '-';
    tgl_lahir = json['tgl_lahir'] ?? '-';
    no_telepon = json['no_telepon'] ?? '-';
    gender = json['gender'] ?? '-';
    marital_status = json['marital_status'] ?? '-';
    usia = json['usia'] ?? 0;
    alamatktp = json['alamatktp'] ?? '-';
    alamatnow = json['alamatnow'] ?? '-';
    nama_contack = json['nama_contack'] ?? '-';
    hubungan= json['hubungan'] ?? '-';
    pendidikan = json['pendidikan'] ?? '-';
    jurusan = json['jurusan'] ?? '-';
    status_emp = json['status_emp'] ?? '-';
    status_pegawai = json['status_pegawai'] ?? '-';
    awal_masuk= json['awal_masuk'] ?? '-';
    resign_tgl = json['resign_tgl'] ?? '-';
    masa_kontrak1 = json['masa_kontrak1'] ?? '-';
    masa_kontrak2 = json['masa_kontrak2'] ?? '-';
    remark_masakontrak = json['remark_masakontrak'] ?? '-';

    no_ktp = json['no_ktp'] ?? '-';
    no_jkn = json['no_jkn'] ?? '-';
    no_kpj = json['no_kpj'] ?? '-';
    No_BPJS= json['No_BPJS'] ?? '-';
    npwp = json['npwp'] ?? '-';
    rekening = json['rekening'] ?? '-';
    
    No_HP= json['No_HP'] ?? '-';
    Nama_Istrisuami= json['Nama_Istrisuami'] ?? '-'; 
    Nama_Anak1 = json['Nama_Anak1'] ?? '-';
    Nama_Anak2= json['Nama_Anak2'] ?? '-';
    Nama_Anak3 = json['Nama_Anak3'] ?? '-';
 
    pict_profile= json['pict_profile'] ?? '-';
    
    

    
   
    

   
   
  
    
   
   
    // deptsal = json['deptsal'] ?? 'X';
   
 
    

 
  }


 

}

class Status_HRD {

  String? status;
  int? stat_val;

  Status_HRD({this.status,this.stat_val});

  factory Status_HRD.fromJson(Map<String,dynamic> json){
    return Status_HRD(
      status: json['status'],
      stat_val: json['stat_val'],
    );
  }

}


class List_NIK {

  String? nik;
  String? nama_person;
  String? deptsal;


  List_NIK({this.nik,this.nama_person,this.deptsal});

  factory List_NIK.fromJson(Map<String,dynamic> json){
    return List_NIK(
      nik: json['nik'],
      nama_person: json['nama_person'],
      deptsal: json['deptsal'],
    );
  }

}