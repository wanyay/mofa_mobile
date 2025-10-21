import 'package:flutter/material.dart';
import 'package:mofa_mobile/models/bachelor_certificate.dart';
import 'package:mofa_mobile/models/matrix_mark.dart';
import 'package:mofa_mobile/models/matrix_pass.dart';
import 'package:mofa_mobile/models/notary_history.dart';
import 'package:mofa_mobile/repositories/notary_repository.dart';
import 'package:mofa_mobile/util/api_exception.dart';

enum NotaryStatus { initial, loading, success, failure }

class NotaryProvider extends ChangeNotifier {
  final NotaryRepository _notaryRepository;

  NotaryProvider(this._notaryRepository);

  NotaryStatus _status = NotaryStatus.initial;
  String _error = '';

  NotaryStatus get status => _status;
  String get error => _error;

  List<NotaryHistory> _notaryHistory = [];
  List<NotaryHistory> get notaryHistory => _notaryHistory;

  MatrixMark? _matrixMarkDetail;
  MatrixMark? get matrixMarkDetail => _matrixMarkDetail;

  MatrixPass? _matrixPassDetail;
  MatrixPass? get matrixPassDetail => _matrixPassDetail;

  BachelorCertificate? _bachelorCertificateDetail;
  BachelorCertificate? get bachelorCertificateDetail =>
      _bachelorCertificateDetail;

  Future<void> createMatrixPassNotary(
    String rollNo,
    String year,
    String? school,
    int? passTownship,
    int? getTownship,
  ) async {
    try {
      if (rollNo.isEmpty) {
        setError('ခုံနံပါတ် ကို ဖြည့်စွက်ပါ');
        return;
      }

      if (year.isEmpty) {
        setError('ခုနှစ် ကို ဖြည့်စွက်ပါ');
        return;
      }

      if (school == null || school.isEmpty) {
        setError('ကျောင်းအမည် ကို ဖြည့်စွက်ပါ');
        return;
      }
      if (passTownship == null) {
        setError('အောင်မြင်သည့် မြို့နယ် ကို ရွေးချယ်ပါ');
        return;
      }

      if (getTownship == null) {
        setError('ထုတ်ယူမည့် မြို့နယ် ကို ရွေးချယ်ပါ');
        return;
      }

      _setStatus(NotaryStatus.loading);
      final response = await _notaryRepository.createMatrixPass(
        rollNo,
        year,
        school,
        passTownship,
        getTownship,
      );

      if (response) {
        _setStatus(NotaryStatus.success);
      } else {
        setError('Failed to create matrix pass');
      }
    } catch (e) {
      if (e is ApiException) {
        setError(e.message ?? 'Authentication error');
      } else {
        setError(e.toString());
      }
    }
  }

  Future<void> createMatrixMarkNotary(
    String rollNo,
    String year,
    String? school,
    int? passTownship,
    int? getTownship,
  ) async {
    try {
      if (rollNo.isEmpty) {
        setError('ခုံနံပါတ် ကို ဖြည့်စွက်ပါ');
        return;
      }

      if (year.isEmpty) {
        setError('ခုနှစ် ကို ဖြည့်စွက်ပါ');
        return;
      }

      if (school == null || school.isEmpty) {
        setError('ကျောင်းအမည် ကို ဖြည့်စွက်ပါ');
        return;
      }
      if (passTownship == null) {
        setError('အောင်မြင်သည့် မြို့နယ် ကို ရွေးချယ်ပါ');
        return;
      }

      if (getTownship == null) {
        setError('ထုတ်ယူမည့် မြို့နယ် ကို ရွေးချယ်ပါ');
        return;
      }

      _setStatus(NotaryStatus.loading);
      final response = await _notaryRepository.createMatrixMark(
        rollNo,
        year,
        school,
        passTownship,
        getTownship,
      );

      if (response) {
        _setStatus(NotaryStatus.success);
      } else {
        setError('Failed to create matrix pass');
      }
    } catch (e) {
      if (e is ApiException) {
        setError(e.message ?? 'Authentication error');
      } else {
        setError(e.toString());
      }
    }
  }

  Future<void> createBachelorCertificateNotary(
    String rollNo,
    String year,
    String? degree,
    int? passUniversity,
    int? getTownship,
  ) async {
    try {
      if (rollNo.isEmpty) {
        setError('ခုံနံပါတ် ကို ဖြည့်စွက်ပါ');
        return;
      }

      if (year.isEmpty) {
        setError('ခုနှစ် ကို ဖြည့်စွက်ပါ');
        return;
      }

      if (degree == null || degree.isEmpty) {
        setError('ဘွဲ့ အမည် ကို ဖြည့်စွက်ပါ');
        return;
      }
      if (passUniversity == null) {
        setError('အောင်မြင်သည့် တက္ကသိုလ် ကို ရွေးချယ်ပါ');
        return;
      }

      if (getTownship == null) {
        setError('ထုတ်ယူမည့် မြို့နယ် ကို ရွေးချယ်ပါ');
        return;
      }

      _setStatus(NotaryStatus.loading);
      final response = await _notaryRepository.createBachelorCertificateNotary(
        rollNo,
        year,
        degree,
        passUniversity,
        getTownship,
      );

      if (response) {
        _setStatus(NotaryStatus.success);
      } else {
        setError('Failed to create matrix pass');
      }
    } catch (e) {
      if (e is ApiException) {
        setError(e.message ?? 'Authentication error');
      } else {
        setError(e.toString());
      }
    }
  }

  Future<void> getNotaryHistory() async {
    try {
      _setStatus(NotaryStatus.loading);
      _notaryHistory = await _notaryRepository.fetchNotaryHistory();
      _setStatus(NotaryStatus.success);
    } catch (e) {
      if (e is ApiException) {
        setError(e.message ?? 'Authentication error');
      } else {
        setError(e.toString());
      }
    }
  }

  Future<void> getMatrixPassDetail(String ticketID) async {
    try {
      _setStatus(NotaryStatus.loading);
      _matrixPassDetail = await _notaryRepository.fetchMatrixPassDetail(
        ticketID,
      );
      _setStatus(NotaryStatus.success);
    } catch (e) {
      if (e is ApiException) {
        setError(e.message ?? 'Authentication error');
      } else {
        setError(e.toString());
      }
    }
  }

  Future<void> getMatrixMarkDetail(String ticketID) async {
    try {
      _setStatus(NotaryStatus.loading);
      _matrixMarkDetail = await _notaryRepository.fetchMatrixMarkDetail(
        ticketID,
      );
      _setStatus(NotaryStatus.success);
    } catch (e) {
      if (e is ApiException) {
        setError(e.message ?? 'Authentication error');
      } else {
        setError(e.toString());
      }
    }
  }

  Future<void> getBachelorCertificateDetail(String ticketID) async {
    try {
      _setStatus(NotaryStatus.loading);
      _bachelorCertificateDetail = await _notaryRepository
          .fetchBachelorCertificateDetail(ticketID);
      _setStatus(NotaryStatus.success);
    } catch (e) {
      if (e is ApiException) {
        setError(e.message ?? 'Authentication error');
      } else {
        setError(e.toString());
      }
    }
  }

  void _setStatus(NotaryStatus status) {
    _status = status;
    if (status != NotaryStatus.failure) {
      _error = '';
    }
    notifyListeners();
  }

  void setError(String error) {
    _error = error;
    _status = NotaryStatus.failure;
    notifyListeners();
  }

  void resetStatus() {
    _status = NotaryStatus.initial;
    _error = '';
    _matrixMarkDetail = null;
    _matrixPassDetail = null;
    _bachelorCertificateDetail = null;
    notifyListeners();
  }

  void resetAll() {
    _status = NotaryStatus.initial;
    _error = '';
    _notaryHistory = [];
    _matrixMarkDetail = null;
    _matrixPassDetail = null;
    _bachelorCertificateDetail = null;
    notifyListeners();
  }
}
