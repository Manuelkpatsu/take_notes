import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takenotes/core/models/user.dart';
import 'package:takenotes/core/view_models/api_vm.dart';
import 'package:takenotes/core/view_models/auth_vm.dart';
import 'package:takenotes/utils/helper.dart';

class NavDrawer extends StatelessWidget {
  final BuildContext appContext;

  NavDrawer(this.appContext);

  @override
  Widget build(BuildContext context) {
    final authVM = Provider.of<AuthVM>(context);

    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            FutureBuilder(
              future: Provider.of<ApiVM>(context).currentUser(),
              builder: (context, snapshot) {
                if (snapshot.hasError) return Text('Error: ${snapshot.error}');
                if (snapshot.data == null)
                  return UserAccountsDrawerHeader(
                    decoration: BoxDecoration(color: Colors.black),
                    accountName: Text(''),
                    accountEmail: Text(''),
                    currentAccountPicture:
                        CircleAvatar(backgroundColor: Colors.white),
                  );

                User user = snapshot.data;

                return UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: Colors.black),
                  accountName: Text(
                    user.username,
                    style: TextStyle(color: Colors.white),
                  ),
                  accountEmail: Text(
                    user.email,
                    style: TextStyle(color: Colors.white),
                  ),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Text(
                      'MA',
                      style: TextStyle(fontSize: 40, color: Colors.black),
                    ),
                  ),
                );
              },
            ),
            ListTile(
              minLeadingWidth: 10,
              leading: Icon(
                Icons.note_add_outlined,
                color: Colors.black,
              ),
              title: Text('Add New Note', style: TextStyle(fontSize: 16)),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              minLeadingWidth: 10,
              leading: Icon(
                Icons.logout_outlined,
                color: Colors.black,
              ),
              title: Text('Logout', style: TextStyle(fontSize: 16)),
              onTap: () {
                Navigator.of(context).pop();
                Helper.showModalSheet(
                  context,
                  'Do you want to logout?',
                  () {
                    authVM.logout(appContext);
                    Navigator.of(appContext).pop();
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}