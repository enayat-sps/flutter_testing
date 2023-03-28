import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing/configs/constants.dart';
import 'package:flutter_testing/models/favorites_model.dart';
import 'package:flutter_testing/screens/favorites_screen.dart';
import 'package:provider/provider.dart';

late FavoritesModel favoritesModel;

Widget createFavoriteScreen() => ChangeNotifierProvider(
      create: (context) {
        favoritesModel = FavoritesModel();
        return favoritesModel;
      },
      child: const MaterialApp(
        home: FavoritesScreen(),
      ),
    );

void addItems() {
  for (int item = 0; item < 10; item += 2) {
    favoritesModel.add(item);
  }
}

void main() {
  group('FavoritesScreen widget tests', () {
    testWidgets('list visibility test', (widgetTester) async {
      await widgetTester.pumpWidget(createFavoriteScreen());
      addItems();
      await widgetTester.pumpAndSettle();
      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('Delete button test', (widgetTester) async {
      await widgetTester.pumpWidget(createFavoriteScreen());
      addItems();
      await widgetTester.pumpAndSettle();
      final deleteButton = find.byIcon(Icons.delete);
      final totalItems = widgetTester.widgetList(deleteButton).length;
      await widgetTester.tap(deleteButton.first);
      await widgetTester.pumpAndSettle();
      expect(widgetTester.widgetList(deleteButton).length, lessThan(totalItems));
      expect(find.text(favoriteRemoved), findsOneWidget);
    });
  });
}
