import 'package:dio/dio.dart';
import 'package:mofa_mobile/getit/getit.dart';
import 'package:mofa_mobile/models/bachelor_certificate.dart';
import 'package:mofa_mobile/models/matrix_mark.dart';
import 'package:mofa_mobile/models/matrix_pass.dart';
import 'package:mofa_mobile/models/notary_history.dart';
import 'package:mofa_mobile/util/api_exception.dart';

class NotaryRepository {
  final Dio _dio = locator.get();

  Future<bool> createMatrixPass(
    String rollNo,
    String year,
    String school,
    int passTownship,
    int getTownship,
  ) async {
    try {
      final response = await _dio.post(
        '/matrix-pass/create',
        data: {
          'rollNo': rollNo,
          'year': year,
          'school': school,
          'passTownshipID': passTownship,
          'getTownshipID': getTownship,
        },
      );
      final responseData = response.data;
      if (responseData['success'] == true) {
        return true;
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

  Future<bool> createMatrixMark(
    String rollNo,
    String year,
    String school,
    int passTownship,
    int getTownship,
  ) async {
    try {
      final response = await _dio.post(
        '/matrix-mark/create',
        data: {
          'rollNo': rollNo,
          'year': year,
          'school': school,
          'passTownshipID': passTownship,
          'getTownshipID': getTownship,
        },
      );
      final responseData = response.data;
      if (responseData['success'] == true) {
        return true;
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

  Future<bool> createBachelorCertificateNotary(
    String rollNo,
    String year,
    String degree,
    int passUniversity,
    int getTownship,
  ) async {
    try {
      final response = await _dio.post(
        '/bachelor-certificate/create',
        data: {
          'rollNo': rollNo,
          'year': year,
          'degree': degree,
          'passUniversityID': passUniversity,
          'getTownshipID': getTownship,
        },
      );
      final responseData = response.data;
      if (responseData['success'] == true) {
        return true;
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

  Future<List<NotaryHistory>> fetchNotaryHistory() async {
    try {
      final response = await _dio.get('/notary/history');
      final responseData = response.data;
      if (responseData['success'] == true) {
        final List<dynamic> data = responseData['data'];
        return data
            .map((item) => NotaryHistory.fromJson(item))
            .toList(growable: false);
      }
      throw ApiException(
        0,
        responseData['message'] ?? 'Failed to get notary history',
      );
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'Unknown error');
    }
  }

  Future<MatrixPass> fetchMatrixPassDetail(String ticketID) async {
    try {
      final response = await _dio.get('/matrix-pass/$ticketID');
      final responseData = response.data;
      if (responseData['success'] == true) {
        return MatrixPass.fromJson(responseData['data']);
      }
      throw ApiException(
        0,
        responseData['message'] ?? 'Failed to get matrix pass detail',
      );
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'Unknown error');
    }
  }

  Future<MatrixMark> fetchMatrixMarkDetail(String ticketID) async {
    try {
      final response = await _dio.get('/matrix-mark/$ticketID');
      final responseData = response.data;
      if (responseData['success'] == true) {
        return MatrixMark.fromJson(responseData['data']);
      }
      throw ApiException(
        0,
        responseData['message'] ?? 'Failed to get matrix mark detail',
      );
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'Unknown error');
    }
  }

  Future<BachelorCertificate> fetchBachelorCertificateDetail(
    String ticketID,
  ) async {
    try {
      final response = await _dio.get('/bachelor-certificate/$ticketID');
      final responseData = response.data;
      if (responseData['success'] == true) {
        return BachelorCertificate.fromJson(responseData['data']);
      }
      throw ApiException(
        0,
        responseData['message'] ?? 'Failed to get bachelor certificate detail',
      );
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'Unknown error');
    }
  }
}
