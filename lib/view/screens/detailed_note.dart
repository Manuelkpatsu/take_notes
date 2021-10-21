import 'package:flutter/material.dart';

class DetailedNote extends StatefulWidget {
  static const routeName = '/detailed_note';

  @override
  _DetailedNoteState createState() => _DetailedNoteState();
}

class _DetailedNoteState extends State<DetailedNote> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('View and update note'),
      ),
    );
  }
}