import 'package:flutter/material.dart';

class AddNote extends StatefulWidget {
  static const routeName = '/add_note';

  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Add new note'),
      ),
    );
  }
}
