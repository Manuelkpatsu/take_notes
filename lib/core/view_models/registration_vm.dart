import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:takenotes/core/services/registration_service.dart';
import 'package:takenotes/view/screens/auth/login_screen.dart';
import 'package:takenotes/view/screens/auth/verify_email_screen.dart';

import '../locator.dart';
import 'base_vm.dart';

class RegistrationVM extends BaseModel {
  /// The registration service
  RegistrationService _registrationService = sl<RegistrationService>();

  /// Indicates if registeration/account activation
  /// is being processed
  bool processing = false;

  /// Register the user
  Future<void> register({
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
    required BuildContext context,
  }) async {
    processing = true;
    notifyListeners();

    try {
      /// 1. Request message
      /// 2. Display the message to users using a flutter toast
      final message = await _registrationService.register(
        username: username,
        email: email,
        password: password,
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
      Navigator.of(context).pushNamed(VerifyEmailScreen.routeName);

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

  /// Activate the user's account
  Future<void> activateAccount({
    required String email,
    required String code,
    required   BuildContext context,
  }) async {
    processing = true;
    notifyListeners();

    try {
      /// 1. Request message
      /// 2. Display the message to users using a flutter toast
      final message = await _registrationService.activateAccount(
        email: email,
        code: code,
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
