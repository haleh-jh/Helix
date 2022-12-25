
class SObjects{
   int id;
   String name;
   String ra;
   String dec;

  SObjects({required this.id, required this.name, required this.ra, required this.dec});
  
  factory SObjects.fromJson(Map<String, dynamic> json){
    return SObjects(id: json['id'], name: json['name'], ra: json['ra'], dec: json['dec'],);
  }
  
  }
