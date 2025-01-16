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
        body: Column(
          children: [
            _DemoMediaQuery(),
            _DemoLayoutBuilder(),
          ],
        ),
      ),
    );
  }
}

class _DemoMediaQuery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        size.width > 480 ? const Text('Large') : const Text('Small'),
      ],
    );
  }
}

class _DemoLayoutBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: LayoutBuilder(builder: (context, constrain) {
        return constrain.biggest.width > 480
            ? const Text('Large')
            : const Text('Small');
      }),
    );
  }
}
