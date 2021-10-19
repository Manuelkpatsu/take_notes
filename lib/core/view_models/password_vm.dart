import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:takenotes/core/services/password_service.dart';
import 'package:takenotes/core/view_models/base_vm.dart';
import 'package:takenotes/view/screens/auth/login_screen.dart';
import 'package:takenotes/view/screens/auth/reset_password_screen.dart';

import '../locator.dart';

class PasswordVM extends BaseModel {
  /// The password service
  PasswordService _passwordService = sl<PasswordService>();

  /// Indicates if forgot password/reset password
  /// is being processed
  bool processing = false;

  /// Get token to reset new password
  Future<void> forgotPassword({
    String email,
    BuildContext context,
  }) async {
    processing = true;
    notifyListeners();

    try {
      /// 1. Request message
      /// 2. Display the message to users using a flutter toast
      final message = await _passwordService.forgotPassword(email: email);

      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 14,
      );
      Navigator.of(context).pushNamed(ResetPasswordScreen.routeName);
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

  /// Reset your new password
  Future<void> resetPassword({
    String token,
    String newPassword,
    String confirmPassword,
    BuildContext context,
  }) async {
    processing = true;
    notifyListeners();

    try {
      /// 1. Request message
      /// 2. Display the message to users using a flutter toast
      final message = await _passwordService.resetPassword(
        token: token,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );

      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 14,
      );
      Navigator.of(context).pushNamed(LoginScreen.routeName);
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
}
