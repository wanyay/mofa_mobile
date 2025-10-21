import 'package:dio/dio.dart';
import 'package:mofa_mobile/getit/getit.dart';
import 'package:mofa_mobile/models/township.dart';
import 'package:mofa_mobile/util/api_exception.dart';

class TownshipRepository {
  final Dio _dio = locator.get();

  Future<List<Township>> getAll() async {
    try {
      final response = await _dio.get('/townships');
      final responseData = response.data;
      if (responseData['success'] == true && responseData['data'] != null) {
        return (responseData['data'] as List)
            .map(
              (item) => Township(
                id: item['id'] as int,
                name: item['name'].toString(),
              ),
            )
            .toList();
      }
      throw ApiException(
        0,
        responseData['message'] ?? 'Failed to get townships',
      );
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'Unknown error');
    }
  }
}
