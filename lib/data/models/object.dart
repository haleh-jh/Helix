import 'package:admin/data/models/coordinate.dart';

class SObjects{
   int id;
   String name;
   Coordinate? coordinate;

  SObjects({required this.id, required this.name, required this.coordinate});
  
  factory SObjects.fromJson(Map<String, dynamic> json){
    return SObjects(id: json['id'], name: json['name'], coordinate: Coordinate(id: -1, ra: "", dec: ""));
  }
  
  }
