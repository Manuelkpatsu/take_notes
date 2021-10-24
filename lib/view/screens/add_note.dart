import 'package:flutter/material.dart';
import 'package:flutter_quill/widgets/controller.dart';
import 'package:flutter_quill/widgets/editor.dart';
import 'package:flutter_quill/widgets/toolbar.dart';

class AddNote extends StatefulWidget {
  static const routeName = '/add_note';

  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  QuillController _controller = QuillController.basic();
  TextEditingController _titleController = TextEditingController();
  FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _controller.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Note')
      ),
      body: Column(
        children: [
          QuillToolbar.basic(
            controller: _controller
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: _titleController,
              autofocus: true,
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
                contentPadding: EdgeInsets.symmetric(horizontal: 10)
              )
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
                expands: false,
                placeholder: 'Create your note',
                padding: EdgeInsets.zero,
                readOnly: false, // change to true to be view only mode
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {}, 
        label: Text('Save'),
        icon: Icon(Icons.save_alt_outlined)
      ),
    );
  }
}
