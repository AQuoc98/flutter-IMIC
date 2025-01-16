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
        body: const DemoListView(),
      ),
    );
  }
}

class DemoListView extends StatefulWidget {
  const DemoListView({super.key});

  @override
  State<DemoListView> createState() => _DemoListViewState();
}

class _DemoListViewState extends State<DemoListView> {
  final ScrollController controller = ScrollController();
  List<String> items = List.generate(100, (index) => 'Hello $index');

  @override
  void initState() {
    super.initState();
    controller.addListener(_scrollListener);
    Future.delayed(const Duration(milliseconds: 300)).then(
      (value) {
        controller.animateTo(
          controller.position.maxScrollExtent,
          duration: const Duration(seconds: 2),
          curve: Curves.fastOutSlowIn,
        );
      },
    );
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
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

  // @override
  // Widget build(BuildContext context) {
  //   // return ListView(
  //   //   scrollDirection: Axis.horizontal,
  //   //   children: data
  //   //       .map(
  //   //         (e) => Text('$e'),
  //   //       )
  //   //       .toList(),
  //   // );
  //   return ListView.builder(
  //     itemCount: data.length,
  //     itemBuilder: (context, index) {
  //       return Text('${data[index]}');
  //     },
  //   );
  // }
}
