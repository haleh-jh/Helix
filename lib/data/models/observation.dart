import 'package:admin/data/models/data.dart';
import 'package:admin/data/models/frames.dart';
import 'package:admin/data/models/object.dart';
import 'package:admin/data/models/user.dart';

class ObservationsModel{
    
   int id;
   String dateTime;
   String status;
   String detectorName;
   String frameName;
   String telescopeName;
   String userName;
   SObjects? sObject;

  ObservationsModel({required this.id, required this.dateTime, required this.status, required this.frameName, required this.sObject
  , required this.telescopeName, required this.detectorName, required this.userName,});
  
  factory ObservationsModel.fromJson(Map<String, dynamic> json){
    return ObservationsModel(id: json['id'], dateTime: json['dateTime'], status: json['status'],
    frameName: json['frameName'].toString() ?? '',
    sObject: json['_SObject'] == null? null : SObjects.fromJson(json['_SObject']),
    telescopeName: json['telescopeName'].toString() ?? '',
    detectorName: json['detectorName'].toString() ??'',
    userName: json['userName'].toString() ??'',
      );
  }
  
  }