import 'dart:developer';

import 'package:dio/dio.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.method == 'GET') {
      log('GET Request: ${options.uri}');
    }

    if (options.method == 'POST') {
      log('POST Request: ${options.uri}, ${options.data}');
    }
    super.onRequest(options, handler);
  }
}
