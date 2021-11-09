import 'package:dio/dio.dart';

mixin LastFmClientErrorsMixin implements Exception{
  String fromDioError(DioError dioError) {

    switch (dioError.type) {
      case DioErrorType.cancel:
        return "Request to API server was cancelled";

      case DioErrorType.connectTimeout:
        return "Connection timeout with API server";

      case DioErrorType.other:
        return
            "Connection to API server failed due to internet connection";

      case DioErrorType.receiveTimeout:
        return "Receive timeout in connection with API server";

      case DioErrorType.response:
        return _handleError(
            dioError.response?.statusCode, dioError.response?.data);

      case DioErrorType.sendTimeout:
        return "Send timeout in connection with API server";

      default:
        return "Something went wrong";
    }
  }

  String _handleError(int? statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 403:
        return error["message"];
      case 500:
        return 'Internal server error';
      default:
        return 'Oops something went wrong';
    }
  }
}
