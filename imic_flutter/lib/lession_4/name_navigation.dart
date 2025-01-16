import 'package:flutter/material.dart';

void main() {
  runApp(const Nav2App());
}

class Nav2App extends StatelessWidget {
  const Nav2App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const HomeScreen(),
        DetailScreen.routeName: (context) => const DetailScreen(),
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
      body: Center(
        child: ElevatedButton(
          child: const Text('View Details'),
          onPressed: () async {
            final data = await Navigator.pushNamed(
              context,
              DetailScreen.routeName,
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
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  static String routeName = '/details';

  const DetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
        Navigator.pop(context, 'details');
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: ElevatedButton(
            child: const Text('Pop!'),
            onPressed: () {
              Navigator.pop(context, 'details');
            },
          ),
        ),
      ),
    );
  }
}
