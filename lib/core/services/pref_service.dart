import 'package:takenotes/core/storage/secure_storage.dart';

import '../locator.dart';

enum ViewType { Tile, Grid }

class PrefService {
  /// The view type key in storage.
  static const String IS_TILE = 'is-tile';
  ViewType _viewType = ViewType.Tile;

  /// Secure storage for storing keys
  SecureStorage _storage = sl<SecureStorage>();

  Future<void> toggleView(ViewType viewType) {
    _viewType = viewType;

    return _storage.write(IS_TILE, _viewType.index.toString());
  }

  Future<String> isTile() {
    return _storage.read(IS_TILE);
  }
}
