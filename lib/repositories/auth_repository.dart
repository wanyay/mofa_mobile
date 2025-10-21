import 'package:dio/dio.dart';
import 'package:mofa_mobile/getit/getit.dart';
import 'package:mofa_mobile/models/user.dart';
import 'package:mofa_mobile/util/api_exception.dart';
import 'package:mofa_mobile/util/auth_manager.dart';

class AuthRepository {
  final Dio _dio = locator.get();

  Future<String> login(String phone, String password) async {
    try {
      final response = await _dio.post(
        '/login',
        data: {'phone': phone, 'password': password},
      );
      final responseData = response.data as Map<String, dynamic>;

      // Extract data from the nested structure
      final data = responseData['data'] as Map<String, dynamic>;
      final accessToken = data['token'] as String;
      final user = User.fromJson(data);

      // Save authentication data using AuthManager
      AuthManager.saveToken(accessToken);
      AuthManager.saveId(user.id);
      AuthManager.saveName(user.name);
      AuthManager.savePhone(user.phone);
      AuthManager.saveNRC(user.nrc);

      return accessToken;
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'Unknown error');
    }
  }

  Future<bool> register(
    String name,
    String phone,
    String nrc,
    String password,
    String confirmPassword,
  ) async {
    try {
      final response = await _dio.post(
        '/register',
        data: {
          'name': name,
          'phone': phone,
          'nrc': nrc,
          'password': password,
          'confirmPassword': confirmPassword,
        },
      );
      if (response.statusCode == 201) {
        return true;
      }
      return false;
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'Unknown error');
    }
  }

  Future<bool> logout() async {
    try {
      final response = await _dio.post('logout');
      if (response.statusCode == 200) {
        AuthManager.removeToken();
        AuthManager.removeId();
        AuthManager.removeName();
        AuthManager.removePhone();
        AuthManager.removeNRC();
        return true;
      }
      return false;
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'Unknown error');
    }
  }
}
