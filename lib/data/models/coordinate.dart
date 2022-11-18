class Coordinate{
   int id;
   String ra;
   String dec;

  Coordinate({required this.id, required this.ra, required this.dec});
  
  factory Coordinate.fromJson(Map<String, dynamic> json){
    return Coordinate(id: json['id'] , ra: json['ra']??"", dec: json['dec']??"");
  }
  
  }
