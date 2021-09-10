import 'dart:convert';

import 'package:takenotes/core/services/http.dart';

import '../locator.dart';

class AuthService {
  /// The login endpoint
  static const String LOGIN_USER_ENDPOINT = 'users/login';

  /// The http service
  HttpService _http = sl<HttpService>();

  /// Requests an access token from the http server
  Future<String> requestAccessToken({String email, String password}) async {
    try {
      final response = await _http
          .post(LOGIN_USER_ENDPOINT, {'email': email, 'password': password});

      if (_http.isSuccessful(response)) {
        return json.decode(response.body)['accessToken'];
      }
      throw (json.decode(response.body)['message']);
    } catch (e) {
      throw e;
    }
  }
}
