import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mofa_mobile/util/auth_interceptor.dart';
import 'package:mofa_mobile/util/logging_interceptor.dart';

class DioProvider {
  static late GlobalKey<NavigatorState> navigatorKey;

  static void initialize(GlobalKey<NavigatorState> key) {
    navigatorKey = key;
  }

  static Dio createDioWithoutHeader() {
    // final apiUrl = dotenv.get('API_URL');
    Dio dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.happyfriday.live/api',
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 3),
      ),
    );

    dio.interceptors.addAll([
      AuthInterceptor(navigatorKey),
      LoggingInterceptor(),
    ]);

    return dio;
  }
}
