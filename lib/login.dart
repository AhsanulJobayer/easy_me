import 'package:easy_me/homepage.dart';
import 'package:easy_me/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';

class login extends StatelessWidget {
  const login({Key? key}) : super(key: key);

  static const String _title = 'eASY.ME';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'easy.me',
                  style: TextStyle(
                      color: Color.fromARGB(255, 1, 14, 26),
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                //forgot password screen
              },
              child: const Text(
                'Forgot Password',
                style: TextStyle(
                    color: Color.fromARGB(255, 1, 14, 26),
                    fontWeight: FontWeight.w500,
                    fontSize: 20),
              ),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('Login'),
                  onPressed: () {
                    if (emailController.text.isEmpty) {
                      Fluttertoast.showToast(
                        msg: "Email can't be empty",
                      );
                    } else if (passwordController.text.isEmpty) {
                      Fluttertoast.showToast(
                        msg: "password can't be empty",
                      );
                    } else {
                      signin(emailController.text, passwordController.text,
                          context);
                      print(emailController.text);
                      print(passwordController.text);
                    }
                  },
                )),
            Row(
              children: <Widget>[
                const Text('Does not have account?'),
                MaterialButton(
                  child: const Text(
                    'Sign in',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return signup();
                        },
                      ),
                    );
                    //signup screen
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ],
        ));
  }
}

void signin(String email, String password, BuildContext context) async {
  try {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signInWithEmailAndPassword(email: email, password: password);
    Fluttertoast.showToast(
      msg: "Successfully logged in",
    );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return homepage();
        },
      ),
    );
  } catch (e) {
    Fluttertoast.showToast(
      msg: "Invalid email or password",
    );
  }
}
