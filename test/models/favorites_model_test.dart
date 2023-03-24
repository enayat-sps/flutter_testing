import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing/models/favorites_model.dart';

void main() {
  group('Testing App Provider', () {
    var favorites = FavoritesModel();

    test('A new item should be added', () {
      var number = 100;
      favorites.add(number);
      expect(favorites.itemsList.contains(number), true);
    });

    test('An item should be removed', () {
      var number = 45;
      favorites.add(number);
      expect(favorites.itemsList.contains(number), true);
      favorites.remove(number);
      expect(favorites.itemsList.contains(number), false);
    });
  });


}
