import 'package:dio/dio.dart';
import 'package:music_management_app/core/infrastructure/last_fm_interceptors.dart';
import 'package:music_management_app/core/shared/client_constants.dart'
    as client_constants;

///Singleton class with last.fm dio client
class LastFmClient {
  final _dio = createDio();

  get dio => _dio;

  LastFmClient._internal();

  static final LastFmClient _lastFmClient = LastFmClient._internal();

  factory LastFmClient() => _lastFmClient;

  static final BaseOptions _baseOptions = BaseOptions(
    sendTimeout: client_constants.connectTimeout,
    receiveTimeout: client_constants.receiveTimeout,
  );

  static Dio createDio() {
    var dio = Dio(_baseOptions);
    dio.interceptors.add(LastFmInterceptors());
    return dio;
  }

  Future<Response<dynamic>> get({
    required Map<String, dynamic> queryParameters,
  }) async {
    Map<String, dynamic> defaultParams = {
      "api_key": client_constants.apiKey,
      "format": "json"
    };

    queryParameters.addAll(defaultParams);

    final Response response = await _dio.get(client_constants.baseUrl,
        queryParameters: queryParameters);
    return response;
  }
}
