import 'package:flutter/material.dart';
import 'package:flutter_testing/configs/routes.dart';
import 'package:flutter_testing/models/favorites_model.dart';
import 'package:flutter_testing/screens/counter_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => FavoritesModel(),
      child: MaterialApp.router(
        title: 'Flutter Tests',
        theme: ThemeData(
          primarySwatch: Colors.green,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        routerConfig: router,
        // home: const CounterScreen(),
      ),
    );
  }
}
