class hrdsection {


  String?section;
  

  hrdsection({this.section});

  factory hrdsection.fromJson(Map <String,dynamic> json)
  {
    return hrdsection(
        section: json['section'],
      

    );
  }
}