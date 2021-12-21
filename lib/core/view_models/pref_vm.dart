import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:takenotes/core/services/pref_service.dart';

import '../locator.dart';
import 'base_vm.dart';

class PrefVm extends BaseModel {
  /// The authentication service
  PrefService _pref = sl<PrefService>();

  bool isTile = true;

  void getTileState() {
    _pref.isTile()
      .then((viewType) {
        if (viewType!.isNotEmpty) {
          if (viewType == '0') {
            isTile = true;
            notifyListeners();
          } else {
            isTile = false;
            notifyListeners();
          }
        } else {
          isTile = true;
          notifyListeners();
        }
      })
      .catchError((error) {
        print('Error: $error');
      });
  }

  void toggleView(ViewType viewType) {
    _pref.toggleView(viewType)
      .then((_) {})
      .catchError((error) {
        Fluttertoast.showToast(
          msg: error.toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 14,
        );
      });
  }
}
