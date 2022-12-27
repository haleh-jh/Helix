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
  Future<dynamic> edit(var data, String path, var formData);
  Future<List<SObjects>> getAllObjects(String path);
  Future<List<ObservationsModel>> search(var data);
  Future<void> uploadData(var data, String id);
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
    Response response = await httpClient
        .post("api/$path",
            data: formData,
            options: Options(
              followRedirects: false,
              validateStatus: (status) {
                statusCode = status!;
                return statusCode < 600;
              },
            ))
        .then((value) {
          print("add: $value");
          print("add: $statusCode");
      return validateResponse(value);
    });

    final js = jsonEncode(response.data);
    final jsonData = json.decode(js);
    var map = Map<String, dynamic>.from(jsonData);
    return map;
  }

  @override
  Future<int> delete(int id, String path) async {
    httpClient.options.headers['content-Type'] = 'application/json';
    httpClient.options.headers['Authorization'] = 'Bearer $token';
    final response = await httpClient.delete("api/$path/$id");
    validateResponse(response);
    return id;
  }

  @override
  Future<dynamic> edit(var data, String path, var formData) async {
    httpClient.options.headers['content-Type'] = 'application/json';
    httpClient.options.headers['Authorization'] = 'Bearer $token';
    final response = await httpClient.put(
      "api/$path/${data.id}",
      data: formData,
    );
    validateResponse(response);
    return data;
  }

  @override
  Future<List<dynamic>> getAll(String path) async {
    httpClient.options.headers['content-Type'] = 'application/json';
    httpClient.options.headers['Authorization'] = 'Bearer $token';
    final response = await httpClient.get("api/$path");
    validateResponse(response);
    return response.data;
  }

  @override
  Future<Data> getById(int id, String path) async {
    httpClient.options.headers['content-Type'] = 'application/json';
    httpClient.options.headers['Authorization'] = 'Bearer $token';
    final response = await httpClient.get("api/$path/?q=$id");
    validateResponse(response);
    final js = jsonEncode(response.data);
    final jsonData = json.decode(js);
    var map = Map<String, dynamic>.from(jsonData);
    var res = Data.fromJson(map);
    return res;
  }

  @override
  Future<List<SObjects>> getAllObjects(String path) async {
    httpClient.options.headers['content-Type'] = 'application/json';
    httpClient.options.headers['Authorization'] = 'Bearer $token';
    print("getAllObjects $path");
    final response = await httpClient.get("api/$path");
    print("getAllObjects $response");
    validateResponse(response);
    final data = <SObjects>[];
    (response.data as List).forEach((element) {
      data.add(SObjects.fromJson(element));
    });
    return data;
  }

  @override
  Future<List<ObservationsModel>> search(var data) async {
    httpClient.options.headers['content-Type'] = 'application/json';
    httpClient.options.headers['Authorization'] = 'Bearer $token';

    int statusCode = 0;

    var formData = FormData.fromMap(data);

    Response response = await httpClient
        .post('api/ObservationSubmissions/Search',
            data: formData,
            options: Options(
              followRedirects: false,
              validateStatus: (status) {
                statusCode = status!;
                return statusCode < 500;
              },
            ))
        .then((value) {
      print("search vv: ${value.data}");
      return validateResponse(value);
    });

    print("response: $response");

    final list = <ObservationsModel>[];
    if (response.data != null) {
      (response.data as List).forEach((element) {
        if ((response.data as List).length > 0)
          list.add(ObservationsModel.fromJson(element));
      });
    }
    return list;
  }

  @override
  Future<void> uploadData(data, String id) async {
    httpClient.options.headers['content-Type'] = 'multipart/form-data';
    httpClient.options.headers['Authorization'] = 'Bearer $token';

    int statusCode = 0;

    Response response = await httpClient
        .post('api/ObservationSubmissions/FileUpload?Id=$id',
            data: data,
            options: Options(
              followRedirects: false,
              validateStatus: (status) {
                statusCode = status!;
                return statusCode < 500;
              },
            ))
        .then((value) {
      print("upload vv: ${value.data}");
      return validateResponse(value);
    });

    print("response: $response");
  }
}
