import 'package:flutter/foundation.dart';
import 'package:mofa_mobile/repositories/auth_repository.dart';
import 'package:mofa_mobile/util/api_exception.dart';
import 'package:mofa_mobile/util/string_helper.dart';

enum AuthStatus { initial, loading, success, failure, logout }

class AuthNotifier with ChangeNotifier {
  final AuthRepository _authRepository;

  AuthNotifier(this._authRepository);

  AuthStatus _status = AuthStatus.initial;
  String _error = '';

  AuthStatus get status => _status;
  String get error => _error;

  Future<void> login(String phone, String password) async {
    _setStatus(AuthStatus.loading);

    try {
      if (phone.isEmpty) {
        _setError('Phone number cannot be empty.');
        return;
      }

      if (password.length < 6) {
        _setError('Password must be at least 6 characters long.');
        return;
      }

      await _authRepository.login(phone, password);
      _setStatus(AuthStatus.success);
    } catch (e) {
      if (e is ApiException) {
        _setError(e.message ?? 'Internal error');
      } else {
        _setError(e.toString());
      }
    }
  }

  Future<void> logout() async {
    _setStatus(AuthStatus.loading);
    try {
      final bool isLogout = await _authRepository.logout();
      if (isLogout) {
        _setStatus(AuthStatus.logout);
      }
    } catch (e) {
      _setError(e.toString());
    }
  }

  Future<void> register(
    String name,
    String phone,
    String nrc,
    String password,
    String confirmPassword,
  ) async {
    _setStatus(AuthStatus.loading);

    try {
      if (phone.isEmpty ||
          name.isEmpty ||
          nrc.isEmpty ||
          password.isEmpty ||
          confirmPassword.isEmpty) {
        _setError('Please fill all fields');
        return;
      }

      if (password != confirmPassword) {
        _setError('Passwords do not match');
        return;
      }

      final register = await _authRepository.register(
        name,
        phone,
        StringHelper.convertToBurmese(nrc),
        password,
        confirmPassword,
      );

      if (register) {
        _setStatus(AuthStatus.success);
      }

      // _setStatus(AuthStatus.success);
    } catch (e) {
      if (e is ApiException) {
        _setError(e.message ?? 'Authentication error');
      } else {
        _setError(e.toString());
      }
    }
  }

  void _setStatus(AuthStatus status) {
    if (_status != status) {
      _status = status;
      notifyListeners();
    }
  }

  void _setError(String error) {
    if (_error != error) {
      _error = error;
      _status = AuthStatus.failure;
      notifyListeners();

      Future.delayed(const Duration(microseconds: 3000), () {
        if (_status == AuthStatus.failure) {
          resetStatus();
        }
      });
    }
  }

  void resetStatus() {
    if (_status != AuthStatus.initial || _error.isNotEmpty) {
      _status = AuthStatus.initial;
      _error = '';
      notifyListeners();
    }
  }
}
