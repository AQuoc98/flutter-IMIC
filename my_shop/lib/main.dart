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
      title: 'My Shop',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

enum AuthType { login, register }

class _MyHomePageState extends State<MyHomePage> {
  var _authType = AuthType.login;

  void _toggleAuthType() {
    if (_authType == AuthType.login) {
      setState(() {
        _authType = AuthType.register;
      });
    } else {
      setState(() {
        _authType = AuthType.login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.purple.shade100,
              Colors.pink.shade100,
              Colors.orange.shade100
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Transform.rotate(
                angle: -0.15,
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  padding: const EdgeInsets.all(15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(
                      20,
                    ),
                  ),
                  child: const Text(
                    'MyShop',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    20,
                  ),
                ),
                margin:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
                padding: const EdgeInsets.all(10),
                child: Column(
                  spacing: 10,
                  children: [
                    const TextField(
                      key: Key('email'),
                      decoration: InputDecoration(
                        hintText: 'Email',
                      ),
                    ),
                    const TextField(
                      key: Key('password'),
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                      ),
                    ),
                    if (_authType == AuthType.register) ...[
                      const TextField(
                        decoration: InputDecoration(
                          hintText: 'Re-Password',
                        ),
                      ),
                    ],
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 10,
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        _authType == AuthType.login ? 'SIGNIN' : 'SIGNUP',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: _toggleAuthType,
                      child: Text(
                        _authType == AuthType.login
                            ? 'SIGNUP INSTEAD'
                            : 'SIGNIN INSTEAD',
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
