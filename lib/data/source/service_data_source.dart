import 'dart:convert';

import 'package:admin/data/common/http_response_validator.dart';
import 'package:admin/data/models/data.dart';
import 'package:admin/data/models/general_model.dart';
import 'package:admin/data/models/object.dart';
import 'package:admin/data/models/observation.dart';
import 'package:dio/dio.dart';

abstract class IServiceDataSource {
  Future<Map<String, dynamic>> add(String path, var formData);
  Future<List<dynamic>> getAll(String path);
  Future<Data> getById(int id, String path);
  Future<int> delete(int id, String path);
  Future<String> deleteV2(String id, String path);
  Future<dynamic> edit(var data, String path, var formData);
  Future<List<SObjects>> getAllObjects(String path);
  Future<List<ObservationsModel>> search(var data);
  Future<void> uploadData(var data, String id);
  Future<Response> ImportFile(var data);
  Future<List<String>> getDownloadFile(String id);
}

class ServiceRemoteDataSource
    with HttpResponseValidator
    implements IServiceDataSource {
  final Dio httpClient;
  final String token;

  ServiceRemoteDataSource(this.httpClient, this.token);

  @override
  Future<Map<String, dynamic>> add(String path, var formData) async {
    httpClient.options.headers['content-Type'] = 'application/json';
    httpClient.options.headers['Authorization'] = 'Bearer $token';
    print(formData.toString());
    int statusCode = 0;
    Response response = await httpClient.post("api/$path",
        data: formData,
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            statusCode = status!;
            return statusCode < 600;
          },
        ));

    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 204) {
      final js = jsonEncode(response.data);
      final jsonData = json.decode(js);
      var map = Map<String, dynamic>.from(jsonData);
      return map;
    } else {
      return validateResponse(response);
    }
  }

  @override
  Future<int> delete(int id, String path) async {
    httpClient.options.headers['content-Type'] = 'application/json';
    httpClient.options.headers['Authorization'] = 'Bearer $token';
    int statusCode = 0;
    final response = await httpClient.delete("api/$path/$id",
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            statusCode = status!;
            return statusCode < 600;
          },
        ));
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 204) {
      return id;
    } else {
      return validateResponse(response);
    }
  }

  @override
  Future<String> deleteV2(String id, String path) async {
    httpClient.options.headers['content-Type'] = 'application/json';
    httpClient.options.headers['Authorization'] = 'Bearer $token';
    int statusCode = 0;

    final response = await httpClient.delete("api/$path/$id",
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            statusCode = status!;
            return statusCode < 600;
          },
        ));
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 204) {
      return id;
    } else {
      return validateResponse(response);
    }
  }

  @override
  Future<dynamic> edit(var data, String path, var formData) async {
    httpClient.options.headers['content-Type'] = 'application/json';
    httpClient.options.headers['Authorization'] = 'Bearer $token';
    int statusCode = 0;
    final response = await httpClient.put("api/$path/${data.id}",
        data: formData,
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            statusCode = status!;
            return statusCode < 600;
          },
        ));
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 204) {
      return response;
    } else {
      return validateResponse(response);
    }
  }

  @override
  Future<List<dynamic>> getAll(String path) async {
    httpClient.options.headers['content-Type'] = 'application/json';
    httpClient.options.headers['Authorization'] = 'Bearer $token';
    int statusCode = 0;
    final response = await httpClient.get("api/$path",
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            statusCode = status!;
            return statusCode < 600;
          },
        ));

    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 204) {
      return response.data;
    } else {
      return validateResponse(response);
    }
  }

  @override
  Future<Data> getById(int id, String path) async {
    httpClient.options.headers['content-Type'] = 'application/json';
    httpClient.options.headers['Authorization'] = 'Bearer $token';
    int statusCode = 0;
    final response = await httpClient.get("api/$path/?q=$id",
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            statusCode = status!;
            return statusCode < 600;
          },
        ));
    if (statusCode == 200 || statusCode == 201 || statusCode == 204) {
      final js = jsonEncode(response.data);
      final jsonData = json.decode(js);
      var map = Map<String, dynamic>.from(jsonData);
      var res = Data.fromJson(map);
      return res;
    } else
      return validateResponse(response);
  }

  @override
  Future<List<SObjects>> getAllObjects(String path) async {
    httpClient.options.headers['content-Type'] = 'application/json';
    httpClient.options.headers['Authorization'] = 'Bearer $token';
    int statusCode = 0;
    final response = await httpClient.get("api/$path",
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            statusCode = status!;
            return statusCode < 600;
          },
        ));
    if (statusCode == 200 || statusCode == 201 || statusCode == 204) {
      final data = <SObjects>[];
      (response.data as List).forEach((element) {
        data.add(SObjects.fromJson(element));
      });
      return data;
    }
    return validateResponse(response);
  }

  @override
  Future<List<ObservationsModel>> search(var data) async {
    httpClient.options.headers['content-Type'] = 'application/json';
    httpClient.options.headers['Authorization'] = 'Bearer $token';

    int statusCode = 0;

    var formData = FormData.fromMap(data);

    Response response =
        await httpClient.post('api/ObservationSubmissions/Search',
            data: formData,
            options: Options(
              followRedirects: false,
              validateStatus: (status) {
                statusCode = status!;
                return statusCode < 500;
              },
            ));
    if (statusCode == 200 || statusCode == 201 || statusCode == 204) {
      final list = <ObservationsModel>[];
      if (response.data != null) {
        (response.data as List).forEach((element) {
          if ((response.data as List).length > 0)
            list.add(ObservationsModel.fromJson(element));
        });
      }
      return list;
    } else
      return validateResponse(response);
  }

  @override
  Future<void> uploadData(data, String id) async {
    httpClient.options.headers['content-Type'] = 'multipart/form-data';
    httpClient.options.headers['Authorization'] = 'Bearer $token';

    int statusCode = 0;

    Response response =
        await httpClient.post('api/ObservationSubmissions/FileUpload?Id=$id',
            data: data,
            options: Options(
              followRedirects: false,
              validateStatus: (status) {
                statusCode = status!;
                return statusCode < 500;
              },
            ));
    if (statusCode != 200 || statusCode != 201 || statusCode != 204) {
      return validateResponse(response);
    }
  }

  @override
  Future<Response> ImportFile(data) async {
    httpClient.options.headers['content-Type'] = 'multipart/form-data';
    httpClient.options.headers['Authorization'] = 'Bearer $token';

    int statusCode = 0;

    Response response = await httpClient.post(
        'api/ObservationSubmissions/FileUploadAndAutoInsert',
        data: data,
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            statusCode = status!;
            return statusCode < 500;
          },
        ));
    if (statusCode == 200 || statusCode == 201 || statusCode == 204) {
      return response;
    } else
      return validateResponse(response);
  }
  
  @override
  Future<List<String>> getDownloadFile(String id) async{
    httpClient.options.headers['content-Type'] = 'application/json';
    httpClient.options.headers['Authorization'] = 'Bearer $token';
    int statusCode = 0;
    final response = await httpClient.get("api/ObservationSubmissions/GetFiles?Id=$id",
        options: Options(
          followRedirects: false,           
          validateStatus: (status) {
            statusCode = status!;
            return statusCode < 600;
          },
        ));
    if (statusCode == 200 || statusCode == 201 || statusCode == 204) {
      var data = <String>[];
      (response.data as List).forEach((element) {
        data.add(element);
      });
      return data;
    } else
      return validateResponse(response);
  }
}
