
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

  //  String? status_emp;
  //  String? no_ktp;
  //  String? no_jkn;
  //  String? no_kpj;
  //  String? npwp;
  //  String? rekening;
  
  //  String? pendidikan;
  //  String? jurusan;
  //  String? status_pegawai;
  //  String? masa_kontrak1;
  //  String? masa_kontrak2;
 
  //  String? nama_contack;
  //  String? hubungan;
 
  //  String? resign_tgl;
  //  String? awal_masuk;
 
  //  String? remark_masakontrak;
  
  //  String? deptsal;
  //  String? No_BPJS;
  //  String? No_HP;
  //  String? Nama_Istrisuami;
  //  String? Nama_Anak1;
  //  String? Nama_Anak2;
  //  String? Nama_Anak3;
  //  String? email;
  //  String? pict_profile;


   HRD_Detail_Personal({
   this.nik,this.nama_person, this.email,this.section,this.jabatan,this.tempat_lahir,this.tgl_lahir,this.no_telepon,this.gender,this.marital_status,this.usia,this.alamatktp,this.alamatnow,
  //  
  //  this.status_emp,this.no_ktp,this.no_jkn,this.no_kpj,this.npwp,
  //  this.rekening,,this.pendidikan,this.jurusan,this.status_pegawai,this.masa_kontrak1,this.masa_kontrak2,
  //this.nama_contack,this.hubungan,this.resign_tgl,this.awal_masuk,
  //  ,this.remark_masakontrak,this.deptsal,
  //  this.No_BPJS,this.No_HP,this.Nama_Istrisuami,this.Nama_Anak1,this.Nama_Anak2,this.Nama_Anak3,this.email,this.pict_profile
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
    // status_emp = json['status_emp'];
    // no_ktp = json['no_ktp'] ?? 'X';
    // no_jkn = json['no_jkn'] ?? 'X';
    // no_kpj = json['no_kpj'] ?? 'X';
    // npwp = json['npwp'] ?? 'X';
    // rekening = json['rekening'] ?? 'X';
    
    // pendidikan = json['pendidikan'] ?? 'X';
    // jurusan = json['jurusan'] ?? 'X';
    // status_pegawai = json['status_pegawai'] ?? 'X';
    // masa_kontrak1 = json['masa_kontrak1'] ?? 'X';
    // masa_kontrak2 = json['masa_kontrak2'] ?? 'X';
    
    // nama_contack = json['nama_contack'] ?? 'X';
    // hubungan= json['hubungan'] ?? 'X';
   
    // resign_tgl = json['resign_tgl'] ?? 'X';
    // awal_masuk= json['awal_masuk'] ?? 'X';
    
    // remark_masakontrak = json['remark_masakontrak'] ?? 'X';
   
    // deptsal = json['deptsal'] ?? 'X';
    // No_BPJS= json['No_BPJS'] ?? 'X';
    // No_HP= json['No_HP'] ?? 'X';
    // Nama_Istrisuami= json['Nama_Istrisuami'] ?? 'X'; 
    // Nama_Anak1 = json['Nama_Anak1'] ?? 'X';
    // Nama_Anak2= json['Nama_Anak2'] ?? 'X';
    // Nama_Anak3 = json['Nama_Anak3'] ?? 'X';
    // email= json['email'] ?? 'X';
    // pict_profile= json['pict_profile'] ?? 'X';
    
    

 
  }


 

}
