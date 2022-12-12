import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/exceptions/auth_exception.dart';

import '../data/store.dart';

class Auth with ChangeNotifier {
  String? _token;
  String? _email;
  String? _userId;
  DateTime? _expireDate;
  Timer? _logoutTimer;
  static const _url = 'firebase/api';

  bool get isAuth {
    final isValid = _expireDate?.isAfter(DateTime.now()) ?? false;
    return _token != null && isValid;
  }

  String? get token {
    return isAuth ? _token : null;
  }

  String? get email {
    return isAuth ? _email : null;
  }

  String? get userId {
    return isAuth ? _userId : null;
  }

  Future<void> _autenticate(
      String email, String password, String urlFragment) async {
    final url = '$_url:$urlFragment';
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode({
        'email': email,
        'password': password,
        'urlFragment': urlFragment,
        'returnSecureToken': true,
      }),
    );

    final body = jsonDecode(response.body);

    if (body['error'] != null) {
      throw AuthException(body['error']['message']);
    } else {
      _token = body['idToken'];
      _email = body['email'];
      _userId = body['localId'];

      _expireDate = DateTime.now().add(
        Duration(
          seconds: int.parse(body['expiresIn']),
        ),
      );

      Store.saveMap(
        'userData',
        {
          'token': _token,
          'email': _email,
          'userId': _userId,
          'expireDate': _expireDate!.toIso8601String(),
        },
      );
      _autoLogout();
      notifyListeners();
    }
  }

  Future<void> tryAutoLogin() async {
    if (isAuth) {
      return;
    }

    final userData = await Store.getMap('userData');
    if (userData.isEmpty) {
      return;
    }

    final expireDate = DateTime.parse(userData['expireDate']);
    if (expireDate.isBefore(DateTime.now())) {
      return;
    }

    _token = userData['token'];
    _email = userData['email'];
    _userId = userData['userI'];
    _expireDate = expireDate;

    _autoLogout();
    notifyListeners();
  }

  Future<void> signup(String email, String password) async {
    return _autenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _autenticate(email, password, 'signInWithPassword');
  }

  void logout() {
    _token = null;
    _email = null;
    _userId = null;
    _expireDate = null;

    _clearLogoutTimer();
    notifyListeners();
  }

  void _clearLogoutTimer() {
    _logoutTimer?.cancel();
    _logoutTimer = null;
  }

  void _autoLogout() {
    _clearLogoutTimer();

    final timeToLogout = _expireDate?.difference(DateTime.now()).inSeconds;
    _logoutTimer = Timer(
      Duration(seconds: timeToLogout ?? 0),
      logout,
    );
  }
}
