import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takenotes/core/view_models/api_vm.dart';
import 'package:takenotes/utils/helper.dart';
import 'package:takenotes/utils/validator.dart';
import 'package:takenotes/view/arguments/noteArgument.dart';
import 'package:takenotes/view/widgets/color_pallete.dart';
import 'package:takenotes/view/widgets/memoji_colors.dart';
import 'package:takenotes/view/widgets/note_text_field.dart';

class EditNote extends StatefulWidget {
  static const routeName = '/edit_note';
  final NoteArgument? noteArgument;

  EditNote({Key? key, this.noteArgument}) : super(key: key);

  @override
  _EditNoteState createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  final formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  int? _selectedColor;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loadNote();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _loadNote() {
    setState(() {
      _loading = true;
    });

    Provider.of<ApiVM>(context, listen: false)
        .fetchNote(noteId: widget.noteArgument!.noteId)
        .then((note) {
      setState(() {
        _titleController = note.title != null
            ? TextEditingController(text: note.title)
            : TextEditingController(text: '');
        _contentController = note.content != null
            ? TextEditingController(text: note.content)
            : TextEditingController(text: '');
        _selectedColor = note.color != null ? note.color! : 0;
      });
    }).catchError((error) {
      Helper.showSnackbar(context, error);
    }).whenComplete(() {
      setState(() {
        _loading = false;
      });
    });
  }

  void _setColor(int color) {
    setState(() {
      _selectedColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    /// Gets the auth view model
    final apiVM = Provider.of<ApiVM>(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Edit Note'),
        actions: [
          IconButton(
            onPressed: () {
              Helper.showColorPallete(
                context: context,
                child: colorPalletes(context),
              );
            },
            icon: Icon(Icons.palette_outlined),
          ),
        ],
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    titleTextField(),
                    SizedBox(height: 20),
                    contentTextField(),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
      floatingActionButton:
          apiVM.processing ? CircularProgressIndicator() : updateNoteButton(),
    );
  }

  Widget titleTextField() {
    return NoteTextField(
      controller: _titleController,
      validator: Validator.title,
      hintText: 'Title',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget contentTextField() {
    return NoteTextField(
      controller: _contentController,
      validator: Validator.content,
      hintText: 'Content',
    );
  }

  Widget colorPalletes(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: MemojiColors.values.length,
      itemBuilder: (context, int index) {
        Color color = MemojiColors.values[index];

        return ColorPallete(
          isSelected: _selectedColor == index,
          color: color,
          onSelect: () {
            _setColor(index);
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  Widget updateNoteButton() {
    return FloatingActionButton.extended(
      onPressed: () {
        if (formKey.currentState!.validate()) {
          Provider.of<ApiVM>(context, listen: false).updateNote(
            noteId: widget.noteArgument!.noteId,
            title: _titleController.text.trim(),
            content: _contentController.text.trim(),
            color: _selectedColor,
            context: context,
          );
        }
      },
      label: Text('Update'),
      icon: Icon(Icons.save_alt_outlined),
    );
  }
}
