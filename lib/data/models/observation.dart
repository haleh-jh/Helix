import 'package:admin/data/models/data.dart';
import 'package:admin/data/models/filters.dart';
import 'package:admin/data/models/object.dart';
import 'package:admin/data/models/user.dart';

class ObservationsModel{
    
   String id;
   String dateTime;
   String status;
   String name;
   String type;
   String detectorName;
   String filterName;
   String telescopeName;
   String userName;
   SObjects? sObject;

  ObservationsModel({required this.id, required this.dateTime, required this.status, required this.name, required this.type, required this.filterName, required this.sObject
  , required this.telescopeName, required this.detectorName, required this.userName,});
  
  factory ObservationsModel.fromJson(Map<String, dynamic> json){
    return ObservationsModel(id: json['id'], dateTime: json['dateTime'], status: json['status'],
    filterName: json['filterName'].toString() ?? '',
    sObject: json['_SObject'] == null? null : SObjects.fromJson(json['_SObject']),
    telescopeName: json['telescopeName'].toString() ?? '',
    detectorName: json['detectorName'].toString() ??'',
    userName: json['userName'].toString() ??'', name: json['name'] ??'', type: json['type'] ??'',
      );
  }
  
  }