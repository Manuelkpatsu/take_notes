import 'dart:convert';

import 'package:takenotes/core/locator.dart';
import 'package:takenotes/core/services/http.dart';

class RegistrationService {
  /// Register user endpoint
  static const String REGISTER_USER_ENDPOINT = 'users/signup';

  /// Activate account endpoint
  static const String ACTIVATE_ACCOUNT_ENDPOINT = 'users/activate';

  /// The http service
  HttpService _http = sl<HttpService>();

  /// Create a new user from the http server
  Future<String> register({
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final response = await _http.post(REGISTER_USER_ENDPOINT, {
        'username': username,
        'email': email,
        'password': password,
        'confirmPassword': confirmPassword,
      });

      if (_http.isSuccessful(response)) {
        return json.decode(response.body)['message'];
      } else {
        throw (json.decode(response.body)['message']);
      }
    } catch (e) {
      throw e;
    }
  }

  /// Activate your account from the http server
  Future<String> activateAccount({
    required String email,
    required String code,
  }) async {
    try {
      final response = await _http.patch(ACTIVATE_ACCOUNT_ENDPOINT, {
        'email': email,
        'code': code,
      });

      if (_http.isSuccessful(response)) {
        return json.decode(response.body)['message'];
      } else {
        throw (json.decode(response.body)['message']);
      }
    } catch (e) {
      throw e;
    }
  }
}
