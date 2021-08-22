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
    String username,
    String email,
    String password,
    String confirmPassword,
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
        throw new Exception(response.reasonPhrase);
      }
    } catch (e) {
      throw e;
    }
  }

  /// Activate your account from the http server
  Future<String> activateAccount({String email, String code,}) async {
    try {
      final response = await _http.post(ACTIVATE_ACCOUNT_ENDPOINT, {
        'email': email,
        'code': code,
      });

      if (_http.isSuccessful(response)) {
        return json.decode(response.body)['message'];
      } else {
        throw new Exception(response.reasonPhrase);
      }
    } catch (e) {
      throw e;
    }
  }
}
