import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        LoginPage(onPageChange: () => pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn)),
        RegisterPage(onPageChange: () => pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn))
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: GestureDetector(
          onTap: onPageChange,
          child: Text("Create an account", style: TextStyle(color: Colors.red[400], fontWeight: FontWeight.bold)),
        ),
        body: Center(
          child: Container(
            width: 300,
            height: 600,
            padding: const EdgeInsets.fromLTRB(16.0, 80.0, 16.0, 0.0),
            child: Column(
              children: [
                Image.asset('assets/images/logo.png', scale: 26),
                Form(
                    child: Column(
                      children: [
                        TextFormField(decoration: const InputDecoration(
                          label: Text('Email'),
                        )),
                        const SizedBox(height: 16),
                        TextFormField(obscureText: true, decoration: const InputDecoration(
                          label: Text('Password'),
                        )),
                        Container(
                          margin: const EdgeInsets.only(top: 16.0),
                          child: InkWell(
                            onTap: () {},
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
            width: 300,
            height: 600,
            padding: const EdgeInsets.fromLTRB(16.0, 80.0, 16.0, 0.0),
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
                            SizedBox(
                              width: 125,
                              child: TextFormField(obscureText: true, decoration: const InputDecoration(
                                label: Text('Password'),
                              )),
                            ),
                            const SizedBox(width: 16),
                            SizedBox(
                              width: 125,
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


