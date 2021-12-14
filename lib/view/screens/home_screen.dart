import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:takenotes/core/models/note.dart';
import 'package:takenotes/core/models/user.dart';
import 'package:takenotes/core/services/pref_service.dart';
import 'package:takenotes/core/view_models/api_vm.dart';
import 'package:takenotes/core/view_models/auth_vm.dart';
import 'package:takenotes/core/view_models/pref_vm.dart';
import 'package:takenotes/utils/helper.dart';
import 'package:takenotes/view/screens/add_note.dart';
import 'package:takenotes/view/screens/detailed_note.dart';
import 'package:takenotes/view/widgets/memoji_colors.dart';
import 'package:takenotes/view/widgets/note_grid.dart';
import 'package:takenotes/view/widgets/note_tile.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  Future<User>? _user;
  Future<List<Note>>? _notes;

  @override
  void initState() {
    super.initState();
    _user = Provider.of<ApiVM>(context, listen: false).currentUser();
    _notes = Provider.of<ApiVM>(context, listen: false).fetchNotes();
  }

  @override
  void didChangeDependencies() {
    Provider.of<PrefVm>(context, listen: true).getTileState();
    super.didChangeDependencies();
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
      drawer: drawer(),
      body: FutureBuilder<List<Note>>(
        future: _notes,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            final List<Note>? _notesList = snapshot.data;

            if (_notesList!.length > 0) {
              return Container(
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
                              itemCount: _notesList.length,
                              staggeredTileBuilder: (index) {
                                return StaggeredTile.count(1, 1.1);
                              },
                              itemBuilder: (context, index) {
                                Note note = _notesList[index];
                                print(jsonEncode(note.content));

                                return NoteGrid(
                                    title: note.title!,
                                    content:
                                        'He always comes through whenever we call on Him',
                                    updatedAt: note.updatedAt!,
                                    onPressed: () => Navigator.of(context)
                                        .pushNamed(DetailedNote.routeName),
                                    color: MemojiColors.values[
                                        index % MemojiColors.values.length]);
                              },
                            )
                          : ListView.builder(
                              itemCount: _notesList.length,
                              physics: BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics(),
                              ),
                              itemBuilder: (context, index) {
                                Note note = _notesList[index];

                                return NoteTile(
                                  title: note.title!,
                                  content:
                                      'He always comes through whenever we call on Him',
                                  updatedAt: note.updatedAt!,
                                  onPressed: () => Navigator.of(context)
                                      .pushNamed(DetailedNote.routeName),
                                  color: MemojiColors.values[
                                      index % MemojiColors.values.length],
                                );
                              },
                            ),
                    )
                  ],
                ),
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(LineIcons.stickyNote, size: 120, color: Colors.black),
                    Text(
                      'No notes',
                      style:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 22),
                    ),
                  ],
                ),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 1,
        onPressed: () => Navigator.of(context).pushNamed(AddNote.routeName),
        child: Icon(CupertinoIcons.add),
      ),
    );
  }

  Widget drawer() {
    return FutureBuilder(
      future: _user,
      builder: (context, snapshot) {
        if (snapshot.hasError) return Container(
          width: MediaQuery.of(context).size.width * 0.75,
          child: Drawer(child: Text('Error: ${snapshot.error}'))
        );
        if (snapshot.data == null)
          return Container(
            width: MediaQuery.of(context).size.width * 0.75,
            child: Drawer(
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.black87),
                accountName: Text(''),
                accountEmail: Text(''),
                currentAccountPicture:
                    CircleAvatar(backgroundColor: Colors.white),
              )
            ),
          );

        User? user = snapshot.data as User;

        return Container(
          width: MediaQuery.of(context).size.width * 0.75,
          child: Drawer(
            child: ListView(
              children: [
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: Colors.black87),
                  accountName: Text(
                    user.username!,
                    style: TextStyle(color: Colors.white),
                  ),
                  accountEmail: Text(
                    user.email!,
                    style: TextStyle(color: Colors.white),
                  ),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Text(
                      Helper.getInitials(
                          user.username!.isNotEmpty ? user.username! : ""),
                      style: TextStyle(fontSize: 40, color: Colors.black),
                    ),
                  ),
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
                        Provider.of<AuthVM>(context, listen: false).logout(context);
                        Navigator.of(context).pop();
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
