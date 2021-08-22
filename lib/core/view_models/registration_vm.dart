import 'package:takenotes/core/services/registration_service.dart';

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

    } catch (e) {
      throw (e);
    } finally {
      processing = false;
      notifyListeners();
    }
  }

  /// Activate the user's account
  Future<void> activateAccount({
    String email,
    String code,
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
      
    } catch (e) {
      throw (e);
    } finally {
      processing = false;
      notifyListeners();
    }
  }
}
