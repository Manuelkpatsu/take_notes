import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:takenotes/core/locator.dart';
import 'package:takenotes/core/storage/secure_storage.dart';

class HttpService {
  /// Base url of the api.
  static const String API_BASE_URL = 'https://my-notes.herokuapp.com/api';

  /// Base url for localhost api
  static const String API_LOCALHOST_BASE_URL = 'http://192.168.100.7:3000/api';

  /// The secure storage
  SecureStorage _storage = sl<SecureStorage>();

  Uri _makeUrl(String uri) {
    return Uri.parse('$API_LOCALHOST_BASE_URL/$uri');
  }

  Future<String> _getAccessToken() async {
    return await _storage.read('accessToken');
  }

  // perform post requests
  Future<http.Response> post(String url, Map<String, dynamic> body) async {
    final header = <String, String>{
      'Accept': 'application/json',
      'Content-type': 'application/json',
      'Authorization': 'Bearer ${await _getAccessToken()}'
    };

    return http.post(_makeUrl(url), headers: header, body: json.encode(body));
  }

  // perform get requests
  Future<http.Response> get(String url) async {
    final header = <String, String>{
      'Accept': 'application/json',
      'Content-type': 'application/json',
      'Authorization': 'Bearer ${await _getAccessToken()}'
    };

    return http.get(_makeUrl(url), headers: header);
  }

  // perform edit
  Future<http.Response> put(String url, Map<String, dynamic> body) async {
    final header = <String, String>{
      'Accept': 'application/json',
      'Content-type': 'application/json',
      'Authorization': 'Bearer ${await _getAccessToken()}'
    };
    
    return http.put(_makeUrl(url), headers: header, body: json.encode(body));
  }

  // perform delete
  Future<http.Response> delete(String url) async {
    return http.delete(_makeUrl(url));
  }

  // check if http.response is successful
  bool isSuccessful(http.Response r) =>
      r.statusCode >= 200 && r.statusCode < 400;
}
