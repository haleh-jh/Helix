import 'package:admin/data/models/data.dart';
import 'package:admin/data/models/frames.dart';
import 'package:admin/data/models/object.dart';
import 'package:admin/data/models/user.dart';

class ObservationsModel{
   int id;
   String dateTime;
   String status;
   FramesModel frame;
   SObjects sObject;
   Data telescope;
   Data detector;
   User user;

  ObservationsModel({required this.id, required this.dateTime, required this.status, required this.frame, required this.sObject
  , required this.telescope, required this.detector, required this.user,});
  
  factory ObservationsModel.fromJson(Map<String, dynamic> json){
    return ObservationsModel(id: json['id'], dateTime: json['dateTime'], status: json['status'], frame: FramesModel.fromJson(json['_Frame']), sObject: SObjects.fromJson(json['_SObject']),
    telescope: Data.fromJson(json['_Telescope']), detector: Data.fromJson(json['_Detector']), user: User.fromJson(json['_User']),);
  }
  
  }