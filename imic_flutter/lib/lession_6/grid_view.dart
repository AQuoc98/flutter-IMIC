import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

final data = List.generate(
  100,
  (index) => index,
);

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
        body: const DemoGridView(),
      ),
    );
  }
}

class DemoGridView extends StatefulWidget {
  const DemoGridView({super.key});

  @override
  State<DemoGridView> createState() => _DemoGridViewState();
}

class _DemoGridViewState extends State<DemoGridView> {
  final ScrollController controller = ScrollController();
  List<String> items = List.generate(100, (index) => 'Hello $index');

  @override
  void initState() {
    super.initState();
    controller.addListener(_scrollListener);
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      controller: controller,
      itemBuilder: (context, index) {
        return Text(items[index]);
      },
      itemCount: items.length,
    );
  }

  void _scrollListener() {
    if (controller.hasClients && controller.position.extentAfter < 500) {
      print(controller.position.extentAfter);
      setState(() {
        items.addAll(List.generate(42, (index) => 'Inserted $index'));
      });
    }
  }
}
