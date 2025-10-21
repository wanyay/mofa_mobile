import 'package:flutter/material.dart';
import 'package:mofa_mobile/models/township.dart';
import 'package:mofa_mobile/repositories/township_repository.dart';
import 'package:mofa_mobile/util/api_exception.dart';

enum TownshipStatus { initial, loading, success, failure }

class TownshipProvider extends ChangeNotifier {
  final TownshipRepository _townshipRepository;

  TownshipProvider(this._townshipRepository);

  TownshipStatus _status = TownshipStatus.initial;
  String _error = '';

  TownshipStatus get status => _status;
  String get error => _error;

  List<Township> _townships = [];
  List<Township> get townships => _townships;

  Future<void> fetchTownships() async {
    try {
      _setStatus(TownshipStatus.loading);
      _townships = await _townshipRepository.getAll();
      _setStatus(TownshipStatus.success);
    } catch (e) {
      if (e is ApiException) {
        _setError(e.message ?? 'Authentication error');
      } else {
        _setError(e.toString());
      }
    }
  }

  void _setStatus(TownshipStatus status) {
    _status = status;
    if (status != TownshipStatus.failure) {
      _error = '';
    }
    notifyListeners();
  }

  void _setError(String error) {
    _error = error;
    _status = TownshipStatus.failure;
    notifyListeners();
  }
}
