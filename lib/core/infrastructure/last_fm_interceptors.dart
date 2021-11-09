import 'package:dio/dio.dart';

//TODO: check if class will be necessary
class LastFmInterceptors extends Interceptor {

  //TODO: implement this class completely
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    //Continue to call the next error interceptor.
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
