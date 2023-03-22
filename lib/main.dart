import 'package:flutter/material.dart';
import 'package:flutter_testing/screens/counter_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Tests',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const CounterScreen(),
    );
  }
}
