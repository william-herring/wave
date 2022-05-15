import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:wave/auth/requests.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        LoginPage(onPageChange: () => _pageController.nextPage(duration: const Duration(milliseconds: 250), curve: Curves.easeIn)),
        RegisterPage(onPageChange: () => _pageController.previousPage(duration: const Duration(milliseconds: 250), curve: Curves.easeIn))
      ],
    );
  }
}

class LoginPage extends StatefulWidget {
  Function() onPageChange;
  LoginPage({Key? key, required this.onPageChange}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState(onPageChange);
}

class _LoginPageState extends State<LoginPage> {
  late Function() onPageChange;
  _LoginPageState(this.onPageChange);

  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  void handleSubmit() {
    _formKey.currentState!.validate();
    requestLogin(email, password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: GestureDetector(
          onTap: onPageChange,
          child: Text("Create an account", style: TextStyle(color: Colors.red[400], fontWeight: FontWeight.bold)),
        ),
        body: Center(
          child: Container(
            height: 600,
            padding: const EdgeInsets.fromLTRB(46.0, 80.0, 46.0, 0.0),
            child: Column(
              children: [
                Image.asset('assets/images/logo.png', scale: 26),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(validator: (input) {
                          setState(() => email = input!);
                          return null;
                        },
                            decoration: const InputDecoration(
                              label: Text('Email'),
                            )),
                        const SizedBox(height: 16),
                        TextFormField(obscureText: true, validator: (input) {
                              setState(() => password = input!);
                              return null;
                            },
                            decoration: const InputDecoration(
                              label: Text('Password'),
                            )),
                        Container(
                          margin: const EdgeInsets.only(top: 16.0),
                          child: InkWell(
                            onTap: () => handleSubmit(),
                            borderRadius: BorderRadius.circular(360),
                            child: Ink(
                              padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 12.0),
                              child: const Text(
                                'Sign in',
                                style: TextStyle(color: Colors.white, fontSize: 18),
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.red[500],
                                  borderRadius: BorderRadius.circular(360)
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                )
              ],
            ),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
          ),
        )
    );
  }
}

class RegisterPage extends StatefulWidget {
  Function() onPageChange;
  RegisterPage({Key? key, required this.onPageChange}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState(onPageChange);
}

class _RegisterPageState extends State<RegisterPage> {
  late Function() onPageChange;
  _RegisterPageState(this.onPageChange);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: GestureDetector(
          onTap: onPageChange,
          child: Text("Sign in", style: TextStyle(color: Colors.red[400], fontWeight: FontWeight.bold)),
        ),
        body: Center(
          child: Container(
            height: 600,
            padding: const EdgeInsets.fromLTRB(46.0, 80.0, 46.0, 0.0),
            child: Column(
              children: [
                Image.asset('assets/images/logo.png', scale: 26),
                Form(
                    child: Column(
                      children: [
                        Container(
                          color: Colors.red[500],
                        ),
                        const SizedBox(height: 16),
                        TextFormField(decoration: const InputDecoration(
                          label: Text('Email'),
                        )),
                        const SizedBox(height: 16),
                        TextFormField(decoration: const InputDecoration(
                          label: Text('Username'),
                        )),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: TextFormField(obscureText: true, decoration: const InputDecoration(
                                label: Text('Password'),
                              )),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: TextFormField(obscureText: true, decoration: const InputDecoration(
                                label: Text('Confirm password'),
                              )),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 16.0),
                          child: InkWell(
                            onTap: () {},
                            borderRadius: BorderRadius.circular(360),
                            child: Ink(
                              padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 12.0),
                              child: const Text(
                                'Sign up',
                                style: TextStyle(color: Colors.white, fontSize: 18),
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.red[500],
                                  borderRadius: BorderRadius.circular(360)
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                )
              ],
            ),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
          ),
        )
    );
  }
}


