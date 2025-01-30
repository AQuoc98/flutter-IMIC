import 'package:flutter/material.dart';
import 'package:my_shop/home_page.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

enum AuthType { login, register }

class _AuthState extends State<Auth> {
  var _authType = AuthType.login;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _rePasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _toggleAuthType() {
    setState(() {
      _authType =
          _authType == AuthType.login ? AuthType.register : AuthType.login;
    });
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please type your email';
    }

    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');

    if (!emailRegex.hasMatch(value)) {
      return 'Please type valid email';
    }

    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please type your password';
    }
    if (value.length < 6) {
      return 'Your password has at least 6 characters';
    }
    return null;
  }

  String? _validateRePassword(String? value) {
    if (_authType == AuthType.register && value != _passwordController.text) {
      return 'Password not match';
    }
    return null;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _emailController.clear();
      _passwordController.clear();
      _rePasswordController.clear();

      if (_authType == AuthType.login) {
        _showSnackbar('Login Successfully');

        Future.delayed(const Duration(seconds: 3), () {
          Navigator.of(context)
              .pushReplacementNamed(HomePage.routeName); // Chuyển sang HomePage
        });
      } else {
        _showSnackbar('Register Successfully');

        Future.delayed(const Duration(seconds: 3), () {
          setState(() {
            _authType = AuthType.login;
          });
        });
      }
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(message),
            )
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        margin: const EdgeInsets.all(20),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _rePasswordController.dispose();
    super.dispose();
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
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform.rotate(
                    angle: -0.15,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      padding: const EdgeInsets.all(15),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20),
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
                    margin: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 40,
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      spacing: 10,
                      children: [
                        TextFormField(
                          key: const Key('email'),
                          controller: _emailController,
                          decoration: const InputDecoration(
                            hintText: 'Email',
                          ),
                          validator: _validateEmail,
                        ),
                        TextFormField(
                          key: Key('password'),
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Password',
                          ),
                          validator: _validatePassword,
                        ),
                        if (_authType == AuthType.register) ...[
                          TextFormField(
                            key: const Key('rePassword'),
                            controller: _rePasswordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Re-Password',
                            ),
                            validator: _validateRePassword,
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
                          onPressed: _submitForm,
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
        ),
      ),
    );
  }
}
