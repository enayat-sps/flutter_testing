// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing/screens/login_screen.dart';

void main() {
  // testWidgets('Counter increments smoke test', (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(const MyApp());
  //
  //   // Verify that our counter starts at 0.
  //   expect(find.text('0'), findsOneWidget);
  //   expect(find.text('1'), findsNothing);
  //
  //   // Tap the '+' icon and trigger a frame.
  //   await tester.tap(find.byIcon(Icons.add));
  //   await tester.pump();
  //
  //   // Verify that our counter has incremented.
  //   expect(find.text('0'), findsNothing);
  //   expect(find.text('1'), findsOneWidget);
  // });
  group('BooksScreen', () {
    testWidgets('should not scroll with less items', (widgetTester) async {
      await widgetTester.pumpWidget(MaterialApp(
        home: BooksScreen(
          books: List.generate(10, (index) => 'Books $index'),
        ),
      ));
      await widgetTester.drag(find.byType(ListView), const Offset(0, -300));
      await widgetTester.pump();
      final firstBook = find.text('Books 0');
      expect(firstBook, findsOneWidget);
    });

    testWidgets('should scroll with lot of items', (widgetTester) async {
      await widgetTester.pumpWidget(MaterialApp(
        home: BooksScreen(
          books: List.generate(100, (index) => 'Books $index'),
        ),
      ));
      await widgetTester.drag(find.byType(ListView), const Offset(0, -300));
      await widgetTester.pump();
      final firstBook = find.text('Books 0');
      final lastBook = find.text('Books 14');
      final cardFinder = find.byType(Card);
      expect(firstBook, findsNothing);
      expect(lastBook, findsOneWidget);
      expect(cardFinder, findsNWidgets(11));
    });

    testWidgets('should show 2 items on small device', (widgetTester) async {
      widgetTester.binding.window.physicalSizeTestValue = const Size(320, 350);
      await widgetTester.pumpWidget(MaterialApp(
        home: BooksScreen(
          books: List.generate(10, (index) => 'Books $index'),
        ),
      ));
      await widgetTester.drag(find.byType(ListView), const Offset(0, -300));
      await widgetTester.pump();
      final cardFinder = find.byType(Card);
      expect(cardFinder, findsNWidgets(2));
    });

    testWidgets('should show error if list is empty', (widgetTester) async {
      await widgetTester.pumpWidget(const MaterialApp(
        home: BooksScreen(
          books: [],
        ),
      ));
      expect(widgetTester.takeException(), isAssertionError);
    });
  });
}
