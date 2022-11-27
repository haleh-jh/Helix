import 'dart:convert';
import 'package:admin/common/custom_snackbar.dart';
import 'package:admin/common/exception.dart';
import 'package:admin/common/pref.dart';
import 'package:admin/data/models/data.dart';
import 'package:admin/data/models/frames.dart';
import 'package:admin/data/models/object.dart';
import 'package:admin/data/models/observation.dart';
import 'package:admin/data/models/user.dart';
import 'package:admin/data/repo/service_repository.dart';
import 'package:flutter/material.dart';

class DataController with ChangeNotifier {
  static List<Data> _dataList = [];
  List<Data> get getList => _dataList;

  static List<Data> _TelescopeList = [];
  List<Data> get getTelescopeList => _TelescopeList;

  static List<Data> _DetectorsList = [];
  List<Data> get getDetectorsList => _DetectorsList;

  static List<SObjects> _SObjectsList = [];
  List<SObjects> get getSObjectsList => _SObjectsList;

  static List<FramesModel> _FramesList = [];
  List<FramesModel> get getFramesList => _FramesList;

   static List<ObservationsModel> _ObservationsList = [];
  List<ObservationsModel> get getObservationsList => _ObservationsList;

  static List<User> _UsersList = [];
  List<User> get getUsersList => _UsersList;

  static late ValueNotifier<bool> ProgressNotifier;

  addList(BuildContext context) async {
    _dataList.clear();
//    _dataList = await getAll(context);
    notifyListeners();
  }

  addData(var data, List list) {
    list.insert(0, data);
    notifyListeners();
  }

  updateList(var data, List list) {
    var updatedData = list.firstWhere((element) => element.id == data.id);
    if (list is List<Data>) {
      updatedData.name = data.name;
      updatedData.type = data.type;
    } else if (list is List<SObjects>) {
      updatedData.name = data.name;
      updatedData.coordinate = data.coordinate;
    } else if (list is List<FramesModel>) {
      updatedData.name = data.name;
      updatedData.type = data.type;
      updatedData.filter = data.filter;
    }else if (list is List<User>) {
      updatedData.userName = data.userName;
      updatedData.phoneNumber = data.phoneNumber;
    }
    notifyListeners();
  }

  deleteList(var data, List list) {
    var deletedData = list.firstWhere((element) => element.id == data.id);
    list.remove(deletedData);
    notifyListeners();
  }

  Future<void> getAll(
    BuildContext context,
    List list,
    String path,
  ) async {
    try {
      ProgressNotifier.value = true;
      if (list.length == 0) {
        await serviceRepository.getAll(path).then((value) {
          if (list is List<Data>) {
            final data = <Data>[];
            value.forEach((element) {
              data.add(Data.fromJson(element));
            });
            list.addAll(data);
          } else if (list is List<SObjects>) {
            final data = <SObjects>[];
            value.forEach((element) {
              data.add(SObjects.fromJson(element));
            });
            list.addAll(data);
          } else if (list is List<FramesModel>) {
            final data = <FramesModel>[];
            value.forEach((element) {
              data.add(FramesModel.fromJson(element));
            });
            list.addAll(data);
          }else if (list is List<User>) {
            final data = <User>[];
            value.forEach((element) {
              data.add(User.fromJson(element));
            });
            list.addAll(data);
          }
          ProgressNotifier.value = false;
          if (list.length != 0) notifyListeners();
        });
      }
    } catch (e) {
      print("e: {$e}");
      ProgressNotifier.value = false;
      ScaffoldMessenger.of(context).showSnackBar(
          CustomSnackbar.customErrorSnackbar("An error has occurred", context));
    }
  }

  Future<dynamic> addNew(String path, var formData) async {
    try {
      var data = await serviceRepository.add(path, formData);
      return data;
    } catch (e) {
      print("e22: ${e.toString()} ");
      throw AppException();
    }
  }

  Future<dynamic> updateData(String path, var data, var formData) async {
    try {
      final d = await serviceRepository.edit(data, path, formData);
      return d;
    } catch (e) {
      print(e.toString());
      throw AppException(message: "An error has occurred");
    }
  }

  Future<dynamic> deleteData(
    String path,
    int id,
  ) async {
    try {
      final d = await serviceRepository.delete(id, path);
      return d;
    } catch (e) {
      print(e.toString());
      throw AppException(message: "An error has occurred");
    }
  }
}
