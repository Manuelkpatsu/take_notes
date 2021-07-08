import 'package:flutter/material.dart';

import 'view/screens/auth/forgot_password_screen.dart';
import 'view/screens/auth/login_screen.dart';
import 'view/screens/auth/register_screen.dart';
import 'view/screens/auth/reset_password_screen.dart';
import 'view/screens/auth/verify_account_screen.dart';
import 'view/screens/home_screen.dart';
import 'view/screens/splash_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '/register':
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case '/forgot_password':
        return MaterialPageRoute(builder: (_) => ForgotPasswordScreen());
      case '/reset_password':
        return MaterialPageRoute(builder: (_) => ResetPasswordScreen());
      case 'verify_account':
        return MaterialPageRoute(builder: (_) => VerifyAccountScreen());
      case '/splash':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text(
                'No route defined for ${settings.name}',
              ),
            ),
          ),
        );
    }
  }
}
