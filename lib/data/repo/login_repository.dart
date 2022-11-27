import 'package:admin/common/http_client.dart';
import 'package:admin/common/pref.dart';
import 'package:admin/data/models/user.dart';
import 'package:admin/data/source/login_data_source.dart';

String? token = PreferenceUtils.getString("token");
final loginRepository = LoginRepository(LoginRemoteDataSource(httpClient));

abstract class ILoginRepository{
  Future<String> login({required String userName, required String password});
  Future<User> getUser();
}

class LoginRepository implements ILoginRepository{

  final ILoginDataSource dataSource;

  LoginRepository(this.dataSource);

  @override
  Future<String> login({required String userName, required String password}) => dataSource.login(userName: userName, password: password);
  
  @override
  Future<User> getUser() => dataSource.getUser(token!);
  
}