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
            DemoKey(),
            DemoTextField(),
          ],
        ),
      ),
    );
  }
}

class DemoTextField extends StatefulWidget {
  const DemoTextField({super.key});

  @override
  State<DemoTextField> createState() => _DemoTextFieldState();
}

class _DemoTextFieldState extends State<DemoTextField> {
  final userNameController = TextEditingController();
  final passWordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('DemoTextField');
    return Column(
      children: [
        MyTextField(
          key: const Key('txtUserName'),
          controller: userNameController,
          onChanged: (value) {
            String? errorText;
            if (value.isNotEmpty && value.length < 6) {
              errorText = 'Username length > 6 characters';
            }
            return errorText;
          },
          hintText: 'Enter UserName',
        ),
        MyTextField(
          key: const Key('txtPassword'),
          controller: passWordController,
          obscureText: true,
          hintText: 'Enter Password',
          onChanged: (value) {
            String? errorText;
            if (value.isNotEmpty && value.length < 6) {
              errorText = 'Password length > 6 characters';
            }
            return errorText;
          },
        ),
        ElevatedButton(
            onPressed: () {
              setState(() {
                if (userNameController.text.length > 6 &&
                    passWordController.text.length > 6) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Successfully!')));
                }
              });
            },
            child: const Text('Validate')),
      ],
    );
  }
}

class MyTextField extends TextField {
  const MyTextField({
    super.key,
    super.obscureText,
    super.controller,
    this.hintText,
    this.onChanged,
  });
  final String? Function(String)? onChanged;

  final String? hintText;

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  String? errorText;

  @override
  Widget build(BuildContext context) {
    print('MyTextField');
    return TextField(
      controller: widget.controller,
      onChanged: (value) {
        errorText = widget.onChanged?.call(value);
        setState(() {});
      },
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: widget.hintText,
        errorText: errorText,
      ),
    );
  }
}

class DemoKey extends StatefulWidget {
  const DemoKey({super.key});

  @override
  State<DemoKey> createState() => _DemoKeyState();
}

class _DemoKeyState extends State<DemoKey> {
  bool isRemoved = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!isRemoved)
          const TextField(
            key: Key('txtUserName'),
            decoration: InputDecoration(hintText: 'Enter UserName'),
          ),
        const TextField(
          key: Key('txtPassword'),
          decoration: InputDecoration(hintText: 'Enter Password'),
        ),
        ElevatedButton(
            onPressed: () {
              setState(() {
                isRemoved = true;
              });
            },
            child: const Text('Change State')),
      ],
    );
  }
}
