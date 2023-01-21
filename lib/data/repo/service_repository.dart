import 'package:admin/common/http_client.dart';
import 'package:admin/common/pref.dart';
import 'package:admin/data/models/data.dart';
import 'package:admin/data/models/general_model.dart';
import 'package:admin/data/models/object.dart';
import 'package:admin/data/models/observation.dart';
import 'package:admin/data/source/service_data_source.dart';
import 'package:dio/dio.dart';

String? token = PreferenceUtils.getString("token");
final serviceRepository =
    ServiceRepository(ServiceRemoteDataSource(httpClient, token!));

abstract class IServiceRepository {
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

class ServiceRepository implements IServiceRepository {
  final IServiceDataSource dataSource;

  ServiceRepository(this.dataSource);

  @override
  Future<Map<String, dynamic>> add(String path, var formData) =>
      dataSource.add(path, formData);

  @override
  Future<int> delete(int id, String path) async => dataSource.delete(id, path);

  @override
  Future<String> deleteV2(String id, String path) async =>
      dataSource.deleteV2(id, path);

  @override
  Future<dynamic> edit(var data, String path, var formData) async =>
      dataSource.edit(data, path, formData);
  @override
  Future<List<dynamic>> getAll(String path) async => dataSource.getAll(path);

  @override
  Future<Data> getById(int id, String path) {
    // TODO: implement getById
    throw UnimplementedError();
  }

  @override
  Future<List<SObjects>> getAllObjects(String path) async =>
      dataSource.getAllObjects(path);

  @override
  Future<List<ObservationsModel>> search(var data) async =>
      dataSource.search(data);

  @override
  Future<void> uploadData(data, id) => dataSource.uploadData(data, id);

  @override
  Future<Response> ImportFile(data) => dataSource.ImportFile(data);
  
  @override
  Future<List<String>> getDownloadFile(String id) => dataSource.getDownloadFile(id);
}
