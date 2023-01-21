import 'dart:convert';
import 'package:admin/common/custom_snackbar.dart';
import 'package:admin/common/exception.dart';
import 'package:admin/common/pref.dart';
import 'package:admin/constants.dart';
import 'package:admin/data/models/data.dart';
import 'package:admin/data/models/filters.dart';
import 'package:admin/data/models/general_model.dart';
import 'package:admin/data/models/object.dart';
import 'package:admin/data/models/observation.dart';
import 'package:admin/data/models/user.dart';
import 'package:admin/data/repo/service_repository.dart';
import 'package:admin/screens/login/login_screen.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class DataController with ChangeNotifier {
  static List<Data> _dataList = [];
  List<Data> get getList => _dataList;

  //drop down list

  static List<GeneralModel> _TelescopeDropDownList = [];
  List<GeneralModel> get getTelescopeDropDownList => _TelescopeDropDownList;

  static List<GeneralModel> _DetectorDropDownList = [];
  List<GeneralModel> get getDetectorDropDownList => _DetectorDropDownList;

  static List<GeneralModel> _SObjectDropDownList = [];
  List<GeneralModel> get getSObjectDropDownList => _SObjectDropDownList;

  static List<GeneralModel> _FrameDropDownList = [];
  List<GeneralModel> get getFrameDropDownList => _FrameDropDownList;

//........

  ValueNotifier<List<Data>> getTelescopeList = ValueNotifier([]);

  ValueNotifier<List<Data>> getDetectorsList = ValueNotifier([]);

  ValueNotifier<List<SObjects>> getSObjectsList = ValueNotifier([]);

  ValueNotifier<List<FiltersModel>> getFiltersList = ValueNotifier([]);

  ValueNotifier<List<ObservationsModel>> getObservationsList =
      ValueNotifier([]);

  ValueNotifier<List<User>> getUsersList = ValueNotifier([]);

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
      updatedData.ra = data.ra;
      updatedData.dec = data.dec;
    } else if (list is List<FiltersModel>) {
      updatedData.name = data.name;
    } else if (list is List<User>) {
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
    ValueNotifier<List> list,
    String path,
  ) async {
    try {
      ProgressNotifier.value = true;
      list.value.clear();
      await serviceRepository.getAll(path).then((value) {
        print(value.length);
        if (list.value is List<Data>) {
          final data = <Data>[];
          value.forEach((element) {
            data.add(Data.fromJson(element));
          });
          list.value = data;
        } else if (list.value is List<SObjects>) {
          final data = <SObjects>[];
          value.forEach((element) {
            data.add(SObjects.fromJson(element));
          });
          list.value = data;
        } else if (list.value is List<FiltersModel>) {
          final data = <FiltersModel>[];
          value.forEach((element) {
            data.add(FiltersModel.fromJson(element));
          });
          list.value = data;
        } else if (list.value is List<User>) {
          final data = <User>[];
          value.forEach((element) {
            data.add(User.fromJson(element));
          });
          list.value = data;
        } else if (list.value is List<ObservationsModel>) {
          final data = <ObservationsModel>[];
          value.forEach((element) {
            data.add(ObservationsModel.fromJson(element));
          });
          list.value = data;
        }
        print("t: ${list.value.length}");
        ProgressNotifier.value = false;
      });
    } catch (e) {
      print('e: ${e.toString()}');
      ProgressNotifier.value = false;
      AppException.handleError(e);
    }
  }

  Future<void> getDropDownList(
    BuildContext context,
    List list,
    String path,
  ) async {
    try {
      ProgressNotifier.value = true;
      list.clear();
      await serviceRepository.getAll(path).then((value) {
        print("d2: ${value}");
        final data = <GeneralModel>[];
        value.forEach((element) {
          data.add(GeneralModel.fromJson(element));
        });
        list.addAll(data);
        if (list.length != 0) notifyListeners();
      });
    } catch (e) {
      ProgressNotifier.value = false;
      AppException.handleError(e);
    }
  }

  Future<dynamic> addNew(
      BuildContext context, String path, var formData) async {
    try {
      var data = await serviceRepository.add(path, formData);
      return data;
    } catch (e) {
      if (!checkConnection()!) {
        throw Exception(kConnectionError);
      } else if (e.toString().contains('401')) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
            (route) => false);
      } else
        AppException.handleError(e);
    }
  }

  Future<dynamic> updateData(
      BuildContext context, String path, var data, var formData) async {
    try {
      final d = await serviceRepository.edit(data, path, formData);
      return d;
    } catch (e) {
      AppException.handleError(e);
    }
  }

  Future<dynamic> deleteData(
    BuildContext context,
    String path,
    int id,
  ) async {
    try {
      final d = await serviceRepository.delete(id, path);
      print("delete1 ${d}");

      return d;
    } catch (e) {
      AppException.handleError(e);
    }
  }

  Future<dynamic> deleteDataV2(
    BuildContext context,
    String path,
    String id,
  ) async {
    try {
      final d = await serviceRepository.deleteV2(id, path);
      print("delete1 ${d}");
      return d;
    } catch (e) {
      AppException.handleError(e);
    }
  }

  Future<dynamic> search(BuildContext context, var formData) async {
    try {
      print("tt3: ${formData.toString()}");
      return await serviceRepository.search(formData);
    } catch (e) {
      AppException.handleError(e);
    }
  }

  Future<dynamic> uploadData(
      BuildContext context, String id, var formData) async {
    try {
      var headers = {
        'Content-Type': 'multipart/form-data',
        'Authorization': 'Bearer ${PreferenceUtils.getString("token")}'
      };
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              'https://hilex.the4.ir/api/ObservationSubmissions/FileUpload?Id=$id'));

      request.files.addAll(formData);

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      AppException.handleError(e);
    }
  }

  Future<dynamic> ImportFiles(BuildContext context, var formData) async {
    try {
      return await serviceRepository.ImportFile(formData);
    } catch (e) {
      AppException.handleError(e);
    }
  }

    Future<dynamic> getDownloadFile(String id) async {
    try {
      return await serviceRepository.getDownloadFile(id);
    } catch (e) {
      AppException.handleError(e);
    }
  }
}
