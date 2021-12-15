import 'dart:convert';

import 'package:takenotes/core/models/user.dart';
import 'package:takenotes/core/models/note.dart';
import 'package:takenotes/core/services/http.dart';

import '../locator.dart';

class APIService {
  // The currentUser endpoint
  static const String CURRENT_USER_ENDPOINT = 'users/currentUser';

  // The fetch notes endpoint
  static const String FETCH_NOTES_ENDPOINT = 'notes';

  // The create note endpoint
  static const String CREATE_NOTE_ENDPOINT = 'create-note';

  // The http service
  HttpService _http = sl<HttpService>();

  // Requests an access token from the http server
  Future<User> currentUser() async {
    try {
      final response = await _http.get(CURRENT_USER_ENDPOINT);

      if (_http.isSuccessful(response)) {
        final user = json.decode(response.body)['user'];
        
        return User.fromJson(user);
      } else {
        throw (json.decode(response.body)['message']);
      }
    } catch (e) {
      throw e;
    }
  }
  
  // Fetch all notes created by an authenticated user from the server
  Future<List<Note>> fetchNotes() async {
    try {
      final response = await _http.get(FETCH_NOTES_ENDPOINT);

      if (_http.isSuccessful(response)) {
        final parsed = json.decode(response.body)['notes'];

        return parsed.map<Note>((json) => Note.fromJson(json)).toList();
      } else {
        throw (json.decode(response.body)['message']);
      }
    } catch (e) {
      throw e;
    }
  }

  // Authenticated user creates a new note
  Future<String> createNote({
    required String title,
    required String content,
    required int? color
  }) async {
    try {
      final response = await _http.post(CREATE_NOTE_ENDPOINT, {
        'title': title,
        'content': content,
        'color': color,
      });

      if (_http.isSuccessful(response)) {
        return json.decode(response.body)['message'];
      } else {
        throw (json.decode(response.body)['message']);
      }
    } catch (e) {
      throw e;
    }
  }

  // Authenticated user fetches a note from the http server
  Future<Note> fetchNote({required String noteId}) async {
    try {
      final response = await _http.get(noteId);

      if (_http.isSuccessful(response)) {
        final parsed = json.decode(response.body);

        return Note.fromJson(parsed);
      } else {
        throw (json.decode(response.body)['message']);
      }
    } catch (e) {
      throw e;
    }
  }

  // Authenticated user updates a note
  Future<String> updateNote({
    required String noteId,
    required String title,
    required String content,
    required int? color
  }) async {
    try {
      final response = await _http.patch(noteId, {
        'title': title,
        'content': content,
        'color': color,
      });

      if (_http.isSuccessful(response)) {
        return json.decode(response.body)['message'];
      } else {
        throw (json.decode(response.body)['message']);
      }
    } catch (e) {
      throw e;
    }
  }

  // Authenticated user deletes a note
  Future<String> deleteNote({required String noteId}) async {
    try {
      final response = await _http.delete(noteId);

      if (_http.isSuccessful(response)) {
        return json.decode(response.body)['message'];
      } else {
        throw (json.decode(response.body)['message']);
      }
    } catch (e) {
      throw e;
    }
  }
}
