import 'dart:convert';

import 'package:takenotes/core/services/http.dart';

import '../locator.dart';

class PasswordService {
  /// The forgot passweod endpoint
  static const String FORGOT_PASSWORD_ENDPOINT = 'users/forgot-password';

  /// The reset password endpoint
  static const String RESET_PASSWORD_ENDPOINT = 'users/reset-password';

  /// The http service
  HttpService _http = sl<HttpService>();

  /// Enter your email for token for setting new password
  /// from http server
  Future<String> forgotPassword({required String email}) async {
    try {
      final response =
          await _http.patch(FORGOT_PASSWORD_ENDPOINT, {'email': email});

      if (_http.isSuccessful(response)) {
        return json.decode(response.body)['message'];
      } else {
        throw (json.decode(response.body)['message']);
      }
    } catch (e) {
      throw e;
    }
  }

  /// Create a new password from the http server
  Future<String> resetPassword({
    required String token,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      final response = await _http.patch(RESET_PASSWORD_ENDPOINT, {
        'token': token,
        'newPassword': newPassword,
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
}
