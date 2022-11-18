import 'package:flutter/cupertino.dart';

class Data{
   int id;
   String name;
   String type;

  Data({required this.id, required this.name, required this.type});
  
  factory Data.fromJson(Map<String, dynamic> json){
    return Data(id: json['id'], name: json['name'], type: json['type']);
  }
  
  }

