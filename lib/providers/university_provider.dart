import 'package:flutter/material.dart';
import 'package:mofa_mobile/models/university.dart';
import 'package:mofa_mobile/repositories/university_repository.dart';
import 'package:mofa_mobile/util/api_exception.dart';

enum UniversityStatus { initial, loading, success, failure }

class UniversityProvider extends ChangeNotifier {
  final UniversityRepository _universityRepository;

  UniversityProvider(this._universityRepository);

  UniversityStatus _status = UniversityStatus.initial;
  String _error = '';

  UniversityStatus get status => _status;
  String get error => _error;

  List<University> _universities = [];
  List<University> get universities => _universities;

  Future<void> fetchUniversities() async {
    try {
      _setStatus(UniversityStatus.loading);
      _universities = await _universityRepository.getAll();
      _setStatus(UniversityStatus.success);
    } catch (e) {
      if (e is ApiException) {
        _setError(e.message ?? 'Authentication error');
      } else {
        _setError(e.toString());
      }
    }
  }

  void _setStatus(UniversityStatus status) {
    _status = status;
    if (status != UniversityStatus.failure) {
      _error = '';
    }
    notifyListeners();
  }

  void _setError(String error) {
    _error = error;
    _status = UniversityStatus.failure;
    notifyListeners();
  }
}
