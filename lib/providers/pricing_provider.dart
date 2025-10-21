import 'package:flutter/material.dart';
import 'package:mofa_mobile/models/pricing.dart';
import 'package:mofa_mobile/repositories/pricing_repository.dart';
import 'package:mofa_mobile/util/api_exception.dart';

enum PricingStatus { initial, loading, success, failure }

class PricingProvider extends ChangeNotifier {
  final PricingRepository _pricingRepository;

  PricingProvider(this._pricingRepository);

  PricingStatus _status = PricingStatus.initial;
  String _error = '';

  PricingStatus get status => _status;
  String get error => _error;

  List<Pricing> _pricings = [];
  List<Pricing> get pricings => _pricings;

  Future<void> fetchPricings() async {
    try {
      _setStatus(PricingStatus.loading);
      _pricings = await _pricingRepository.getAll();
      _setStatus(PricingStatus.success);
    } catch (e) {
      if (e is ApiException) {
        _setError(e.message ?? 'Authentication error');
      } else {
        _setError(e.toString());
      }
    }
  }

  void _setStatus(PricingStatus status) {
    _status = status;
    if (status != PricingStatus.failure) {
      _error = '';
    }
    notifyListeners();
  }

  void _setError(String error) {
    _error = error;
    _status = PricingStatus.failure;
    notifyListeners();
  }
}
