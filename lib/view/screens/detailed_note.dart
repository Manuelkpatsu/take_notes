import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quill/models/documents/document.dart';
import 'package:flutter_quill/widgets/toolbar.dart';
import 'package:flutter_quill/widgets/editor.dart';
import 'package:flutter_quill/widgets/controller.dart';

class DetailedNote extends StatefulWidget {
  static const routeName = '/detailed_note';

  @override
  _DetailedNoteState createState() => _DetailedNoteState();
}

class _DetailedNoteState extends State<DetailedNote> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  FocusNode _focusNode = FocusNode();
  QuillController _controller;
  TextEditingController _titleController;
  bool _loading = false;
  bool _edit = false;

  @override
  void initState() {
    super.initState();
    if (_controller == null && !_loading) {
      _loading = true;
      _loadFromAssets();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _loadFromAssets() async {
    try {
      final result = await rootBundle.loadString('assets/sample_data.json');
      final doc = Document.fromJson(jsonDecode(result));
      setState(() {
        _controller = QuillController(
          document: doc,
          selection: TextSelection.collapsed(offset: 0),
        );
        _loading = false;
        _titleController = TextEditingController(text: 'Hello world');
      });
    } catch (error) {
      final doc = Document()..insert(0, 'Empty asset');
      setState(() {
        _controller = QuillController(
          document: doc,
          selection: TextSelection.collapsed(offset: 0),
        );
        _loading = false;
        _titleController = TextEditingController(text: '');
      });
    }
  }

  void _toggleEdit() {
    setState(() {
      _edit = !_edit;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Edit Note'),
      ),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                QuillToolbar.basic(
                  controller: _controller,
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: _titleController,
                    autofocus: true,
                    readOnly: !_edit,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    textCapitalization: TextCapitalization.sentences,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 0, 
                          style: BorderStyle.none,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.black12,
                      hintText: 'Title',
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 20, left: 20, top: 10),
                    child: QuillEditor(
                      controller: _controller,
                      scrollController: ScrollController(),
                      scrollable: true,
                      focusNode: _focusNode,
                      autoFocus: true,
                      readOnly: !_edit,
                      expands: false,
                      placeholder: 'Edit your note',
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text(_edit == true ? 'Done' : 'Edit'),
        onPressed: _toggleEdit,
        icon: Icon(_edit == true ? Icons.check : Icons.edit),
      ),
    );
  }
}
