import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takenotes/core/services/pref_service.dart';
import 'package:takenotes/core/view_models/api_vm.dart';
import 'package:takenotes/core/view_models/pref_vm.dart';
import 'package:takenotes/view/screens/add_note.dart';
import 'package:takenotes/view/screens/detailed_note.dart';
import 'package:takenotes/view/widgets/nav_drawer.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<PrefVm>(context, listen: true).getTileState();
  }

  @override
  Widget build(BuildContext context) {
    final prefVM = Provider.of<PrefVm>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        actions: [
          Visibility(
            visible: prefVM.isTile == true,
            child: IconButton(
              onPressed: () {
                Provider.of<PrefVm>(context, listen: false)
                    .toggleView(ViewType.Grid);
              },
              icon: Icon(Icons.grid_view_outlined),
            ),
          ),
          Visibility(
            visible: prefVM.isTile == false,
            child: IconButton(
              onPressed: () {
                Provider.of<PrefVm>(context, listen: false)
                    .toggleView(ViewType.Tile);
              },
              icon: Icon(Icons.view_agenda_outlined),
            ),
          )
        ],
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
