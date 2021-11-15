import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:music_management_app/core/domain/models/last_fm_error.dart';


class LastFmInterceptors extends Interceptor {

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    //Continue to call the next error interceptor.
    try {
      var lastFmError = LastFmError.fromJson(err.response?.data);
      log("${lastFmError.error} : ${lastFmError.message}");
    } catch (error) {
      log(error.toString());
    }

    handler.next(err);
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    //Continue to call the next request interceptor.
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    //Continue to call the next response interceptor.
    handler.next(response);
  }
}
