import 'package:flutter/material.dart';
import 'package:takenotes/view/arguments/noteArgument.dart';
import 'package:takenotes/view/screens/edit_note.dart';

import 'view/screens/auth/forgot_password_screen.dart';
import 'view/screens/auth/login_screen.dart';
import 'view/screens/auth/register_screen.dart';
import 'view/screens/auth/reset_password_screen.dart';
import 'view/screens/auth/verify_email_screen.dart';
import 'view/screens/detailed_note.dart';
import 'view/screens/add_note.dart';
import 'view/screens/home_screen.dart';
import 'view/screens/splash_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeScreen.routeName:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case LoginScreen.routeName:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case RegisterScreen.routeName:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case ForgotPasswordScreen.routeName:
        return MaterialPageRoute(builder: (_) => ForgotPasswordScreen());
      case ResetPasswordScreen.routeName:
        return MaterialPageRoute(builder: (_) => ResetPasswordScreen());
      case VerifyEmailScreen.routeName:
        return MaterialPageRoute(builder: (_) => VerifyEmailScreen());
      case SplashScreen.routeName:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case AddNote.routeName:
        return MaterialPageRoute(builder: (_) => AddNote());
      case DetailedNote.routeName:
        final args = settings.arguments as NoteArgument;
        return MaterialPageRoute(builder: (_) => DetailedNote(noteArgument: args));
      case EditNote.routeName:
        final args = settings.arguments as NoteArgument;
        return MaterialPageRoute(builder: (_) => EditNote(noteArgument: args));
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
