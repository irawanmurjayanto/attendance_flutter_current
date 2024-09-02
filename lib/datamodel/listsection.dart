class hrdsection {


  String?section;
  String?macadd;

  hrdsection({this.section,this.macadd});

  factory hrdsection.fromJson(Map <String,dynamic> json)
  {
    return hrdsection(
        section: json['section'],
        macadd: json['macadd'],

    );
  }
}