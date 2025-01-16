import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'user_model.dart';

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
        body: const DemoHttpApi(),
      ),
    );
  }
}

class DemoHttpApi extends StatefulWidget {
  const DemoHttpApi({super.key});

  @override
  State<DemoHttpApi> createState() => _DemoHttpApiState();
}

class _DemoHttpApiState extends State<DemoHttpApi> {
  final _http = HttpClient();
  late Future<List<User>> _future;

  Future<List<User>> _getUserList() async {
    final request = await _http.getUrl(
        Uri.parse('https://my.api.mockaroo.com/users.json?key=907b9d70'));
    final response = await request.close();
    if (response.statusCode == 200) {
      final contentAsString = await utf8.decodeStream(response);
      final map = json.decode(contentAsString);
      print(map);
      final userList = (map as List)
          .map(
            (e) => User.fromJson(e),
          )
          .toList();
      return userList;
    }
    return [];
  }

  @override
  void initState() {
    _future = _getUserList();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) =>
                Text(snapshot.data![index].toString()),
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
