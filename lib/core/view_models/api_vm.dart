import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:takenotes/core/models/user.dart';
import 'package:takenotes/core/services/api_service.dart';
import 'package:takenotes/core/view_models/base_vm.dart';

import '../locator.dart';

class ApiVM extends BaseModel {
  /// The password service
  APIService _apiService = sl<APIService>();

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
}