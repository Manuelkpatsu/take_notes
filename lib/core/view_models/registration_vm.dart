import 'package:flutter/material.dart';
import 'package:takenotes/core/services/registration_service.dart';
import 'package:takenotes/utils/helper.dart';
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
    String username,
    String email,
    String password,
    String confirmPassword,
    BuildContext context,
  }) async {
    processing = true;
    notifyListeners();

    try {
      /// 1. Request message
      /// 2. Display the message to users using a snackbar
      final message = await _registrationService.register(
        username: username,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
      );

      Helper.showSnackbar(context, message);
      Navigator.of(context).pushNamed(VerifyEmailScreen.routeName);

    } catch (e) {
      processing = false;
      notifyListeners();
      Helper.showSnackbar(context, e.toString());
    } finally {
      processing = false;
      notifyListeners();
    }
  }

  /// Activate the user's account
  Future<void> activateAccount({
    String email,
    String code,
    BuildContext context,
  }) async {
    processing = true;
    notifyListeners();

    try {
      /// 1. Request message
      /// 2. Display the message to users using a snackbar
      final message = await _registrationService.activateAccount(
        email: email,
        code: code,
      );

      Helper.showSnackbar(context, message);
      Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
      
    } catch (e) {
      processing = false;
      notifyListeners();
      throw (e);
    } finally {
      processing = false;
      notifyListeners();
    }
  }
}
