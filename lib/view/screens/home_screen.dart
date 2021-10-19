import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takenotes/core/view_models/auth_vm.dart';
import 'package:takenotes/utils/helper.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    /// Gets the auth view model
    final authVM = Provider.of<AuthVM>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: authVM.processing
            ? CircularProgressIndicator()
            : ElevatedButton(
                child: Text('Logout'),
                onPressed: () {
                  Helper.showModalSheet(
                    context,
                    'Do you want to logout?',
                    () {
                      authVM.logout(context);
                      Navigator.of(context).pop();
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                    side: BorderSide(color: Colors.black, width: 2),
                  ),
                  onPrimary: Colors.black,
                  primary: Colors.white,
                  elevation: 0,
                ),
              ),
      ),
    );
  }
}
