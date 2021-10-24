import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:takenotes/core/services/pref_service.dart';
import 'package:takenotes/core/view_models/api_vm.dart';
import 'package:takenotes/core/view_models/pref_vm.dart';
import 'package:takenotes/view/screens/add_note.dart';
import 'package:takenotes/view/screens/detailed_note.dart';
import 'package:takenotes/view/widgets/memoji_colors.dart';
import 'package:takenotes/view/widgets/nav_drawer.dart';
import 'package:takenotes/view/widgets/note_grid.dart';
import 'package:takenotes/view/widgets/note_tile.dart';

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
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: prefVM.isTile == true
                  ? StaggeredGridView.countBuilder(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 0,
                      physics: BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      itemCount: 10,
                      staggeredTileBuilder: (index) {
                        return StaggeredTile.count(1, 1.1);
                      },
                      itemBuilder: (context, index) {
                        return NoteGrid(
                          title: 'God is Good',
                          content:
                              'He always comes through whenever we call on Him',
                          updatedAt: '2021-09-10T01:50:49.683+00:00',
                          onPressed: () => Navigator.of(context).pushNamed(DetailedNote.routeName),
                          color: MemojiColors.values[index % MemojiColors.values.length]
                        );
                      },
                    )
                  : ListView.builder(
                      itemCount: 8,
                      physics: BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      itemBuilder: (context, index) {
                        return NoteTile(
                          title: 'God is Good',
                          content:
                              'He always comes through whenever we call on Him',
                          updatedAt: '2021-09-10T01:50:49.683+00:00',
                          onPressed: () => Navigator.of(context).pushNamed(DetailedNote.routeName),
                          color: MemojiColors.values[index % MemojiColors.values.length],
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 1,
        onPressed: () => Navigator.of(context).pushNamed(AddNote.routeName),
        child: Icon(CupertinoIcons.add),
      ),
    );
  }
}
