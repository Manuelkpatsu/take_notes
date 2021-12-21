import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:takenotes/core/models/note.dart';
import 'package:takenotes/core/view_models/api_vm.dart';
import 'package:takenotes/utils/helper.dart';
import 'package:takenotes/view/arguments/noteArgument.dart';
import 'package:takenotes/view/screens/edit_note.dart';
import 'package:takenotes/view/widgets/memoji_colors.dart';

class DetailedNote extends StatefulWidget {
  static const routeName = '/detailed_note';
  final NoteArgument? noteArgument;

  DetailedNote({this.noteArgument});

  @override
  _DetailedNoteState createState() => _DetailedNoteState();
}

class _DetailedNoteState extends State<DetailedNote> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Future<Note>? _note;

  @override
  void initState() {
    super.initState();
    _note = Provider.of<ApiVM>(context, listen: false)
        .fetchNote(noteId: widget.noteArgument!.noteId);
  }

  void _editNote() {
    Navigator.of(context)
        .pushNamed(EditNote.routeName, arguments: widget.noteArgument);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(),
      body: FutureBuilder<Note>(
        future: _note,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            final Note? detailedNote = snapshot.data!;

            if (detailedNote != null) {
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    title(detailedNote),
                    dateCreated(detailedNote.updatedAt!),
                    SizedBox(height: 20),
                    content(detailedNote.content!),
                    SizedBox(height: 20),
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
                      'No note',
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
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Edit'),
        onPressed: _editNote,
        icon: Icon(Icons.edit),
      ),
    );
  }

  Widget title(Note note) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Container(
            width: 5,
            color: MemojiColors.values[note.color!],
          ),
          SizedBox(width: 5),
          Expanded(
            child: Text(
              note.title!,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget dateCreated(String date) {
    return Text(
      Helper.formatDateTime(date),
      style: TextStyle(fontSize: 12),
    );
  }

  Widget content(String content) {
    return Text(
      content,
      style: TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 16,
      ),
    );
  }
}
