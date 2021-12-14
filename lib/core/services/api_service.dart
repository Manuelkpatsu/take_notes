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
}
