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
      home: Scaffold(
        appBar: AppBar(),
        body: const Column(
          children: [
            MyPage(),
            MyOtherPage(),
          ],
        ),
      ),
    );
  }
}

class FrogColor extends InheritedWidget {
  const FrogColor({
    super.key,
    required this.color,
    required super.child,
  });

  final Color color;

  static FrogColor? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<FrogColor>();
  }

  static FrogColor of(BuildContext context) {
    final FrogColor? result = maybeOf(context);
    assert(result != null, 'No FrogColor found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(FrogColor oldWidget) => color != oldWidget.color;
}

// continuing from previous example...
class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FrogColor(
          color: Colors.green,
          child: Builder(
            builder: (BuildContext innerContext) {
              return Column(
                children: [
                  Text(
                    'Hello Frog',
                    style: TextStyle(color: FrogColor.of(innerContext).color),
                  ),
                  const Child1(),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class Child1 extends StatelessWidget {
  const Child1({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Hello Frog',
      style: TextStyle(color: FrogColor.of(context).color),
    );
  }
}

// continuing from previous example...

class MyOtherPage extends StatefulWidget {
  const MyOtherPage({super.key});

  @override
  State<MyOtherPage> createState() => _MyOtherPageState();
}

class _MyOtherPageState extends State<MyOtherPage> {
  var color = Colors.purple;
  @override
  Widget build(BuildContext context) {
    return FrogColor(
      color: color,
      child: Builder(builder: (context) {
        return Column(
          children: [
            Text(
              'Hello Frog',
              style: TextStyle(color: FrogColor.of(context).color),
            ),
            const Child2(),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (color == Colors.purple) {
                      color = Colors.cyan;
                    } else {
                      color = Colors.purple;
                    }
                  });
                },
                child: const Text('Change color'))
          ],
        );
      }),
    );
  }
}

class Child2 extends StatelessWidget {
  const Child2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Hello Frog',
          style: TextStyle(color: FrogColor.of(context).color),
        ),
        const Child21(),
      ],
    );
  }
}

class Child21 extends StatelessWidget {
  const Child21({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Hello Frog',
      style: TextStyle(color: FrogColor.of(context).color),
    );
  }
}
