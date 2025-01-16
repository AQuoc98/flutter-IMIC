// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

void main() {
  runApp(const Nav2App());
}

class Nav2App extends StatelessWidget {
  const Nav2App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) {
        // Handle '/'
        if (settings.name is! String) {
          return null;
        }
        if (settings.name == '/') {
          return MaterialPageRoute(builder: (context) => const HomeScreen());
        }

        // Handle '/details/:id'
        var uri = Uri.parse(settings.name!);
        if (uri.pathSegments.length == 2 &&
            uri.pathSegments.first == 'details') {
          var id = uri.pathSegments[1];
          return MaterialPageRoute(builder: (context) => DetailScreen(id: id));
        }

        return MaterialPageRoute(builder: (context) => const UnknownScreen());
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          ElevatedButton(
            child: const Text('View Details 1'),
            onPressed: () async {
              final data = await Navigator.pushNamed(
                context,
                '/details/1',
              );
              if (data is String && context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(data),
                  ),
                );
              }
            },
          ),
          ElevatedButton(
            child: const Text('View Details 2'),
            onPressed: () async {
              final data = await Navigator.pushNamed(
                context,
                '/details/2',
              );
              if (data is String && context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(data),
                  ),
                );
              }
            },
          ),
          ElevatedButton(
            child: const Text('Unknown route'),
            onPressed: () async {
              final data = await Navigator.pushNamed(
                context,
                '/details/2',
              );
              if (data is String && context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(data),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final String id;

  const DetailScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Viewing details for item $id'),
            ElevatedButton(
              child: const Text('Pop!'),
              onPressed: () {
                Navigator.pop(context, id);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class UnknownScreen extends StatelessWidget {
  const UnknownScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('404!'),
      ),
    );
  }
}
