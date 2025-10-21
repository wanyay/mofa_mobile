import 'package:flutter/material.dart';
import 'package:mofa_mobile/getit/getit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthManager {
  static final ValueNotifier<String?> authChangeNotifier = ValueNotifier(null);
  static final SharedPreferences _sharedPref = locator.get();

  static void saveToken(String token) async {
    _sharedPref.setString('access_token', token);
    authChangeNotifier.value = token;
  }

  static void removeToken() async {
    _sharedPref.remove('access_token');
  }

  static void saveId(int id) async {
    _sharedPref.setInt('user_id', id);
  }

  static void removeId() async {
    _sharedPref.remove('user_id');
  }

  static int getId() {
    return _sharedPref.getInt('user_id') ?? 0;
  }

  static String readAuth() {
    return _sharedPref.getString('access_token') ?? '';
  }

  static void saveName(String name) {
    _sharedPref.setString('name', name);
  }

  static void removeName() {
    _sharedPref.remove('name');
  }

  static String getName() {
    return _sharedPref.getString('name') ?? '';
  }

  static void savePhone(String role) {
    _sharedPref.setString('phone', role);
  }

  static void removePhone() {
    _sharedPref.remove('phone');
  }

  static String getPhone() {
    return _sharedPref.getString('phone') ?? '';
  }

  static void saveNRC(String nrc) {
    _sharedPref.setString('nrc', nrc);
  }

  static void removeNRC() {
    _sharedPref.remove('nrc');
  }

  static String getNRC() {
    return _sharedPref.getString('nrc') ?? '';
  }

  static void logout() {
    _sharedPref.clear();
    authChangeNotifier.value = null;
  }

  static bool isLogin() {
    String token = readAuth();
    return token.isNotEmpty;
  }
}
