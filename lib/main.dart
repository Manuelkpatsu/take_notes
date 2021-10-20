import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:takenotes/core/locator.dart';
import 'package:takenotes/core/view_models/api_vm.dart';
import 'package:takenotes/view/screens/auth/login_screen.dart';
import 'package:takenotes/view/screens/home_screen.dart';
import 'package:takenotes/view/screens/splash_screen.dart';

import 'core/view_models/auth_vm.dart';
import 'core/view_models/password_vm.dart';
import 'core/view_models/registration_vm.dart';
import 'router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  setUpLocator();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthVM>(create: (_) => AuthVM()),
        ChangeNotifierProvider<RegistrationVM>(create: (_) => RegistrationVM()),
        ChangeNotifierProvider<PasswordVM>(create: (_) => PasswordVM()),
        ChangeNotifierProvider<ApiVM>(create: (_) => ApiVM()),
      ],
      child: Consumer<AuthVM>(
        builder: (BuildContext context, AuthVM authVM, Widget child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: FutureBuilder(
                future: authVM.isLoggedIn,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data == false) {
                      return LoginScreen();
                    } else {
                      return HomeScreen();
                    }
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  return SplashScreen();
                }),
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              primaryColor: Colors.white,
              appBarTheme: AppBarTheme(
                elevation: 0,
                brightness: Brightness.dark,
                backgroundColor: Colors.transparent,
                iconTheme: IconThemeData(color: Colors.black),
                textTheme: TextTheme(
                  headline6: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              textTheme: TextTheme(
                headline4: GoogleFonts.lato(
                  textStyle: Theme.of(context).textTheme.headline4,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade900,
                ),
                bodyText2: GoogleFonts.montserrat(
                  textStyle: Theme.of(context).textTheme.bodyText2,
                  fontSize: 14,
                  color: Colors.grey.shade900,
                ),
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  primary: Colors.transparent,
                  onPrimary: Colors.white,
                  elevation: 0,
                  padding: EdgeInsets.fromLTRB(18, 10, 18, 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
            onGenerateRoute: AppRouter.generateRoute,
          );
        },
      ),
    );
  }
}
