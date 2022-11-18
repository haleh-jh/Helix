import 'dart:convert';

import 'package:admin/data/common/http_response_validator.dart';
import 'package:admin/data/models/data.dart';
import 'package:admin/data/models/object.dart';
import 'package:dio/dio.dart';

abstract class IServiceDataSource {
  Future<Map<String, dynamic>> add(String path, var formData);
  Future<List<dynamic>> getAll(String path);
  Future<Data> getById(int id, String path);
  Future<int> delete(int id, String path);
  Future<dynamic> edit(var data, String path, var formData);
  Future<List<SObjects>> getAllObjects(String path);
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
    final response = await httpClient.post("api/$path", data: formData);
    print(response);
    validateResponse(response);
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
    print("${formData} $path");
    final response = await httpClient.put(
      "api/$path/${data.id}",
      data: formData,
    );
    print(response);
    validateResponse(response);
    return data;
  }

  @override
  Future<List<dynamic>> getAll(String path) async {
    httpClient.options.headers['content-Type'] = 'application/json';
    httpClient.options.headers['Authorization'] = 'Bearer $token';
    print("t: $path");
    final response = await httpClient.get("api/$path");
     print("t2: $path");
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
  Future<List<SObjects>> getAllObjects(String path) async{
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
}
