class ApiException implements Exception {
  int? code;
  String? message;
  ApiException(this.code, this.message);

  @override
  String toString() {
    return message ?? 'ApiException';
  }
}
