import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Color> _colors = [
    Colors.red,
    Colors.black,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.grey,
    Colors.orange,
    Colors.purple
  ];
  int _counter = 0;
  Color _backgroundColor = Colors.white;
  String _primeResult = "";
  final TextEditingController _numberController = TextEditingController();

  void _changeColor() {
    setState(() {
      _counter++;

      if (_counter % 2 == 0) {
        _backgroundColor = _colors[Random().nextInt(_colors.length)];
      } else {
        _backgroundColor = Colors.white;
      }
    });
  }

  bool _isPrime(int number) {
    if (number <= 1) return false;
    for (int i = 2; i <= sqrt(number).toInt(); i++) {
      if (number % i == 0) return false;
    }
    return true;
  }

  void _checkPrime() {
    final input = _numberController.text;
    final number = int.tryParse(input);

    if (input.isEmpty) {
      setState(() {
        _primeResult = "Please type a number";
      });
      return;
    }

    if (number == null) {
      setState(() {
        _primeResult = "invalid value";
      });
      return;
    }

    setState(() {
      if (_isPrime(number)) {
        _primeResult = "the $number is the prime number.";
      } else {
        _primeResult = "the $number is not the prime number.";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: _backgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: _changeColor,
                    child: Text('Change Color ($_counter)')),
                SizedBox(
                  height: 50,
                ),
                TextField(
                  controller: _numberController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Type a number'),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _checkPrime,
                  child: Text('Prime number check'),
                ),
                SizedBox(height: 16),
                Text(_primeResult)
              ],
            ),
          ),
        ));
  }
}
