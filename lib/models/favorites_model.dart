import 'package:flutter/material.dart';

class FavoritesModel extends ChangeNotifier {
  final List _favoriteItems = [];

  List get itemsList => _favoriteItems;

  void add(int item) {
    _favoriteItems.add(item);
    notifyListeners();
  }

  void remove(int item) {
    _favoriteItems.remove(item);
    notifyListeners();
  }
}
