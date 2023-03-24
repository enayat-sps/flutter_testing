import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_testing/configs/routes.dart';
import 'package:flutter_testing/screens/books_screen.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  static const routeName = AppRoutes.counterScreen;

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int _counter = 0;
  int _redoCount = 0;
  bool undo = false;
  late Timer _timer;

  final zeroCounterSnack = const SnackBar(
    content: Text('Counter is already at 0'),
    showCloseIcon: true,
    closeIconColor: Colors.red,
  );

  void _incrementCounter() {
    setState(() {
      _counter++;
      _redoCount = _counter;
    });
  }

  void _longIncrement() {
    _timer = Timer.periodic(
        const Duration(
          milliseconds: 200,
        ), (timer) {
      setState(() {
        _counter++;
        _redoCount == _counter;
      });
    });
  }

  void _decrementCounter() {
    if (_counter != 0) {
      _counter--;
      _redoCount == _counter;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(zeroCounterSnack);
    }
    setState(() {});
  }

  void _longDecrement() {
    _timer = Timer.periodic(
        const Duration(
          milliseconds: 200,
        ), (timer) {
      setState(() {
        if (_counter != 0) {
          _counter--;
          _redoCount == _counter;
        }
      });
    });
  }

  void _resetCounter() async {
    final resetSnack = SnackBar(
      content: const Text('Counter is set to 0'),
      action: SnackBarAction(label: 'UNDO', onPressed: _redoCounterValue),
    );
    if (_counter == 0) {
      ScaffoldMessenger.of(context).showSnackBar(zeroCounterSnack);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(resetSnack);
    }
    _counter = 0;
    setState(() {});
  }

  void _redoCounterValue() async {
    setState(() {
      _counter = _redoCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter Page'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Press Count:',
                    ),
                    Text(
                      '$_counter',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => BooksScreen(
                            books:
                                List.generate(100, (index) => 'Books $index'),
                          ),
                        ),
                      ),
                      child: const Text(
                        'Go to the next page',
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onLongPress: _longDecrement,
                    onLongPressEnd: (details) => _timer.cancel(),
                    child: SizedBox(
                      height: 60,
                      child: ElevatedButton(
                        onPressed: _decrementCounter,
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          elevation: 10,
                        ),
                        child: const Icon(Icons.exposure_minus_1),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                    child: ElevatedButton(
                      onPressed: _resetCounter,
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        elevation: 10,
                      ),
                      child: const Icon(Icons.undo),
                    ),
                  ),
                  GestureDetector(
                    onLongPress: _longIncrement,
                    onLongPressEnd: (details) => _timer.cancel(),
                    child: SizedBox(
                      height: 60,
                      child: ElevatedButton(
                        onPressed: _incrementCounter,
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          elevation: 10,
                        ),
                        child: const Icon(Icons.exposure_plus_1),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40)
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
