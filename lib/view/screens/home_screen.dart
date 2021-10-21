import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takenotes/core/view_models/api_vm.dart';
import 'package:takenotes/view/screens/add_note.dart';
import 'package:takenotes/view/widgets/nav_drawer.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      drawer: NavDrawer(context),
      body: Center(
        child: Text('Welcome Home'),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 1,
        onPressed: () => Navigator.of(context).pushNamed(AddNote.routeName),
        child: Icon(CupertinoIcons.add),
      ),
    );
  }
}
