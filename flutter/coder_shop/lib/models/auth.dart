import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/exceptions/auth_exception.dart';

class Auth with ChangeNotifier {
  static const _url = 'firebase/api';

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
    }
  }

  Future<void> signup(String email, String password) async {
    return _autenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _autenticate(email, password, 'signInWithPassword');
  }
}
