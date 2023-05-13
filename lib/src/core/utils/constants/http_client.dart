import 'package:dio/dio.dart';

const String BaseUrl = "https://hilex.the4.ir/";

final httpClient =
    Dio(BaseOptions(baseUrl: BaseUrl));