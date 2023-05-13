import 'package:helix_with_clean_architecture/src/data/models/object.dart';

class ObservationsModel {
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

  ObservationsModel({
    required this.id,
    required this.dateTime,
    required this.status,
    required this.name,
    required this.type,
    required this.filterName,
    required this.sObject,
    required this.telescopeName,
    required this.detectorName,
    required this.userName,
  });

  // {
  //       "id": "0dd43551-b6e9-458d-8132-de12f9d07577",
  //       "dateTime": "2022-09-03T04:01:03.423",
  //       "status": "True",
  //       "name": "Unknown",
  //       "type": "Light",
  //       "_Filter": null,
  //       "_SObject": null,
  //       "_Telescope": null,
  //       "_Detector": null,
  //       "_User": null
  //   }

  factory ObservationsModel.fromJson(Map<String, dynamic> json) {
    return ObservationsModel(
      id: json['id'],
      dateTime: json['dateTime'],
      status: json['status'],
      filterName: json['filterName'].toString() ?? '',
      sObject: json['_SObject'] == null
          ? SObjects(id: 0, dec: '', name: '', ra: '')
          : SObjects.fromJson(json['_SObject']),
      telescopeName:
          json['telescopeName'] == null ? '' : json['telescopeName'].toString(),
      detectorName: json['detectorName'] == null
          ? ''
          : json['detectorName'].toString() ?? '',
      userName:
          json['userName'] == null ? '' : json['userName'].toString() ?? '',
      name: json['name'] ?? '',
      type: json['type'] ?? '',
    );
  }
}
