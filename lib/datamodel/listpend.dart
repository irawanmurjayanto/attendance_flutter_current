 

class Pendidikan{

String? idno;
String? title;
String? pendidikan;

Pendidikan({this.idno,this.title,this.pendidikan});

factory Pendidikan.fromJson(Map<String,dynamic>json)
{
return Pendidikan(
    idno: json['idno'],
    title: json['title'],
    pendidikan: json['pendidikan'],
);


}
}