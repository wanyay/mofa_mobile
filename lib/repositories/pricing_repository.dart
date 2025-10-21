import 'package:dio/dio.dart';
import 'package:mofa_mobile/getit/getit.dart';
import 'package:mofa_mobile/models/pricing.dart';
import 'package:mofa_mobile/util/api_exception.dart';

class PricingRepository {
  final Dio _dio = locator.get();

  Future<List<Pricing>> getAll() async {
    try {
      final response = await _dio.get('/pricings');
      final responseData = response.data;
      if (responseData['success'] == true && responseData['data'] != null) {
        return (responseData['data'] as List)
            .map(
              (item) => Pricing(
                id: item['id'].toString(),
                name: item['name'].toString(),
                notaryID: item['notaryID'] as int,
                price: item['price'] as int,
              ),
            )
            .toList();
      }
      throw ApiException(
        0,
        responseData['message'] ?? 'Failed to get pricings',
      );
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'Unknown error');
    }
  }
}
