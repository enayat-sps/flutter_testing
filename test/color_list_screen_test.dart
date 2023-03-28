import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing/configs/constants.dart';
import 'package:flutter_testing/models/favorites_model.dart';
import 'package:flutter_testing/screens/color_list_screen.dart';
import 'package:provider/provider.dart';

Widget createHomeScreen() => ChangeNotifierProvider(
      create: (context) => FavoritesModel(),
      child: const MaterialApp(home: ColorListScreen()),
    );

void main() {
  group('ColorListScreen widget tests', () {
    testWidgets('To test the visibility of listView', (widgetTester) async {
      await widgetTester.pumpWidget(createHomeScreen());
      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('Scrolling test', (widgetTester) async {
      await widgetTester.pumpWidget(
        createHomeScreen(),
      );
      expect(find.text('Item 0'), findsOneWidget);
      await widgetTester.fling(
          find.byType(ListView), const Offset(0, -200), 3000);
      await widgetTester.pumpAndSettle();
      expect(find.text('Item 0'), findsNothing);
    });

    testWidgets('IconButton tests', (widgetTester) async {
      await widgetTester.pumpWidget(createHomeScreen());

      final addFavoriteButton = find.byIcon(Icons.favorite_border);
      final removeFavoriteButton = find.byIcon(Icons.favorite);
      expect(removeFavoriteButton, findsNothing);
      expect(addFavoriteButton, findsWidgets);
      await widgetTester.tap(addFavoriteButton.first);
      await widgetTester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.text(favoriteAdded), findsOneWidget);

      expect(removeFavoriteButton, findsOneWidget);
      await widgetTester.tap(removeFavoriteButton);
      await widgetTester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.text(favoriteRemoved), findsOneWidget);
      expect(removeFavoriteButton, findsNothing);
    });
  });
}
