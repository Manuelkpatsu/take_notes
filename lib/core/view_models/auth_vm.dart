import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:takenotes/core/services/auth_service.dart';
import 'package:takenotes/core/storage/secure_storage.dart';
import 'package:takenotes/core/view_models/base_vm.dart';

import '../locator.dart';

class AuthVM extends BaseModel {
  /// The auth access token key in storage.
  static const String ACCESS_TOKEN_KEY = 'access-token';
  static const String LOGIN_STATE_INITIAL = 'initial';
  static const String LOGIN_STATE_LOGGED_IN = 'logged-in';

  /// The authentication service
  AuthService _auth = sl<AuthService>();

  /// Secure storage for storing auth tokens
  SecureStorage _storage = sl<SecureStorage>();

  /// Indicates if authentication is being processed.
  bool processing = false;

  String _loginState = LOGIN_STATE_INITIAL;

  /// Requests a bool to indicate whether a user
  /// is logged in or not
  Future<bool> get isLoggedIn async {
    return null != (await _storage.read(ACCESS_TOKEN_KEY));
  }

  bool get isLoginComplete => _loginState == LOGIN_STATE_LOGGED_IN;

  /// Logs in the user
  Future<void> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    processing = true;
    notifyListeners();

    try {
      /// 1. Request access token
      /// 2. Store the access token
      final token =
          await _auth.requestAccessToken(email: email, password: password);

      await _storage.write(ACCESS_TOKEN_KEY, token);

      _loginState = LOGIN_STATE_LOGGED_IN;
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14,
      );
    } finally {
      processing = false;
      notifyListeners();
    }
  }

  Future<void> logout(BuildContext context) async {
    processing = true;
    notifyListeners();

    return _auth.logout().then((message) {
      return _storage.deleteAll().then((_) {
        Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 14,
        );
      });
    }).catchError((error) {
      Fluttertoast.showToast(
        msg: error.toString(),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14,
      );
    }).whenComplete(() {
      processing = false;
      notifyListeners();
    });
  }
}
