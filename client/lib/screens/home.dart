import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
