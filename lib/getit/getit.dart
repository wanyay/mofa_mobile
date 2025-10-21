import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mofa_mobile/util/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

var locator = GetIt.instance;

Future<void> getItInit() async {
  await _initComponents();
}

Future<void> _initComponents() async {
  locator.registerSingleton<Dio>(DioProvider.createDioWithoutHeader());
  locator.registerSingleton<SharedPreferences>(
    await SharedPreferences.getInstance(),
  );
}
