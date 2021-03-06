import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takenotes/core/view_models/api_vm.dart';
import 'package:takenotes/utils/helper.dart';
import 'package:takenotes/utils/validator.dart';
import 'package:takenotes/view/widgets/color_pallete.dart';
import 'package:takenotes/view/widgets/memoji_colors.dart';
import 'package:takenotes/view/widgets/note_text_field.dart';

class AddNote extends StatefulWidget {
  static const routeName = '/add_note';

  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  int _selectedColor = 0;
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _contentController.dispose();
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
      appBar: AppBar(
        title: Text('Add New Note'),
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
      body: SingleChildScrollView(
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
          apiVM.processing ? CircularProgressIndicator() : createNoteButton(),
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

  Widget createNoteButton() {
    return FloatingActionButton.extended(
      onPressed: () {
        if (formKey.currentState!.validate()) {
          Provider.of<ApiVM>(context, listen: false).createNote(
            title: _titleController.text.trim(),
            content: _contentController.text.trim(),
            color: _selectedColor,
            context: context,
          );
        }
      },
      label: Text('Save'),
      icon: Icon(Icons.save_alt_outlined),
    );
  }
}
