import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:takenotes/core/models/note.dart';
import 'package:takenotes/core/models/user.dart';
import 'package:takenotes/core/services/api_service.dart';
import 'package:takenotes/core/view_models/base_vm.dart';
import 'package:takenotes/view/screens/home_screen.dart';

import '../locator.dart';

class ApiVM extends BaseModel {
  /// The password service
  APIService _apiService = sl<APIService>();

  /// Indicates if authentication is being processed.
  bool processing = false;

  Future<User> currentUser() async {
    User _user = User();

    try {
      _user = await _apiService.currentUser();
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14,
      );
    }

    return _user;
  }

  Future<List<Note>> fetchNotes() async {
    return _apiService.fetchNotes()
      .then((notes) => notes)
      .catchError((error) {
        throw (error);
      });
  }

  Future<Note> fetchNote({required String noteId}) async {
    Note _note = Note();

    try {
      _note = await _apiService.fetchNote(noteId: noteId);
    } catch (e) {
      throw (e);
    }

    return _note;
  }

  Future<void> createNote({
    required String title,
    required String content,
    required int? color,
    required BuildContext context,
  }) async {
    processing = true;
    notifyListeners();

    try {
      final message = await _apiService.createNote(
        title: title,
        content: content,
        color: color,
      );

      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 14,
      );
      Navigator.of(context).pushNamed(HomeScreen.routeName);
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14,
      );
    } finally {
      processing = false;
      notifyListeners();
    }
  }

  Future<void> updateNote({
    required String noteId,
    required String title,
    required String content,
    required int? color,
    required BuildContext context,
  }) async {
    processing = true;
    notifyListeners();

    try {
      final message = await _apiService.updateNote(
        noteId: noteId,
        title: title,
        content: content,
        color: color,
      );

      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 14,
      );
      Navigator.of(context).pushNamed(HomeScreen.routeName);
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14,
      );
    } finally {
      processing = false;
      notifyListeners();
    }
  }

  Future<void> deleteNote({
    required String noteId,
    required BuildContext context,
  }) async {
    processing = true;
    notifyListeners();

    try {
      final message = await _apiService.deleteNote(noteId: noteId);

      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 14,
      );
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14,
      );
    } finally {
      processing = false;
      notifyListeners();
    }
  }
}
