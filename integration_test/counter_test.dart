import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_testing/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Counter increment test with 200ms delay till 100 ',
      (widgetTester) async {
    //setup
    app.main();
    await widgetTester.pumpAndSettle();
    final plusButton = find.byIcon(Icons.exposure_plus_1);
    //do
    for (int i = 0; i < 30; i++) {
      await widgetTester.tap(plusButton);
      await Future.delayed(const Duration(milliseconds: 200));
    }
    await widgetTester.pumpAndSettle();
    //test
    expect(find.text('30'), findsOneWidget);
  });

  testWidgets('Counter decrement test with 200ms delay till 15 ',
      (widgetTester) async {
    //setup
    app.main();
    await widgetTester.pumpAndSettle();
    final plusButton = find.byIcon(Icons.exposure_plus_1);
    final minusButton = find.byIcon(Icons.exposure_minus_1);
    //do
    for (int i = 0; i < 30; i++) {
      await widgetTester.tap(plusButton);
      await Future.delayed(const Duration(milliseconds: 10));
    }
    for (int i = 0; i < 15; i++) {
      await widgetTester.tap(minusButton);
      await Future.delayed(const Duration(milliseconds: 200));
    }
    await widgetTester.pumpAndSettle();
    //test
    expect(find.text('0'), findsNothing);
    expect(find.text('15'), findsOneWidget);
  });

  testWidgets('Counter reset test', (widgetTester) async {
    //setup
    app.main();
    await widgetTester.pumpAndSettle();
    final plusButton = find.byIcon(Icons.exposure_plus_1);
    final resetButton = find.byIcon(Icons.undo);
    //do
    await widgetTester.tap(plusButton);
    await Future.delayed(const Duration(seconds: 1));
    await widgetTester.tap(resetButton);
    await widgetTester.pumpAndSettle();
    //test
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);
  });

  testWidgets('Counter reset then undo', (widgetTester) async {
    ///setup
    app.main();
    await widgetTester.pumpAndSettle();
    final plusButton = find.byIcon(Icons.exposure_plus_1);
    final resetButton = find.byIcon(Icons.undo);
    final undoButton = find.text('UNDO');

    ///do
    for (int i = 0; i < 10; i++) {
      await widgetTester.tap(plusButton);
      await Future.delayed(const Duration(milliseconds: 100));
    }
    await widgetTester.tap(resetButton);
    await widgetTester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 2));
    await widgetTester.tap(undoButton);
    await widgetTester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 2));

    ///test
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsNothing);
    expect(find.text('10'), findsOneWidget);
  });

  testWidgets(
      'Counter increment by 10 then reset then again increment by 10 again reset then undo',
      (widgetTester) async {
    ///setup
    app.main();
    await widgetTester.pumpAndSettle();
    final plusButton = find.byIcon(Icons.exposure_plus_1);
    final minusButton = find.byIcon(Icons.exposure_minus_1);
    final resetButton = find.byIcon(Icons.undo);
    final undoButton = find.text('UNDO');

    ///do
    for (int i = 0; i < 20; i++) {
      await widgetTester.tap(plusButton);
      await Future.delayed(const Duration(milliseconds: 100));
    }
    for (int i = 0; i < 15; i++) {
      await widgetTester.tap(minusButton);
      await Future.delayed(const Duration(milliseconds: 200));
    }
    await widgetTester.tap(resetButton);
    await widgetTester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 5));
    for (int i = 0; i < 10; i++) {
      await widgetTester.tap(plusButton);
      await Future.delayed(const Duration(milliseconds: 100));
    }
    await widgetTester.tap(resetButton);
    await widgetTester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 2));
    await widgetTester.tap(undoButton);
    await widgetTester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 2));

    ///test
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsNothing);
    expect(find.text('10'), findsOneWidget);
  });
}
