import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_me/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class signup extends StatelessWidget {
  signup();

  static const String _title = 'SIGNUP HERE';

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
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();

  final referenceDatabase = FirebaseDatabase.instance; // database instance

  final auth = FirebaseAuth.instance;
  bool _validate = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(10, 60, 10, 10),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'User Name',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: fullnameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Full Name',
                ),
              ),
            ),
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
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextField(
                obscureText: true,
                controller: confirmpasswordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Confirm Password',
                ),
              ),
            ),
            Container(
                height: 70,
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: ElevatedButton(
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 25),
                  ),
                  onPressed: () {
                    if (nameController.text.isEmpty) {
                      Fluttertoast.showToast(
                        msg: "Username can't be empty",
                      );
                    } else if (fullnameController.text.isEmpty) {
                      Fluttertoast.showToast(
                        msg: "Full name can't be empty",
                      );
                    } else if (emailController.text.isEmpty) {
                      Fluttertoast.showToast(
                        msg: "Email can't be empty",
                      );
                    } else if (passwordController.text.isEmpty) {
                      Fluttertoast.showToast(
                        msg: "Password can't be empty",
                      );
                    } else if (confirmpasswordController.text.isEmpty) {
                      Fluttertoast.showToast(
                        msg: "Confirm Password can't be empty",
                      );
                    } else if (passwordController.text !=
                        confirmpasswordController.text) {
                      Fluttertoast.showToast(
                        msg: "Password doesn't match",
                      );
                    } else {
                      signUp(emailController.text, passwordController.text,
                          nameController.text, fullnameController.text);
                    }

                    print(nameController.text);
                    print(passwordController.text);
                  },
                )),
            Row(
              children: <Widget>[
                const Text('Already have an account?',
                    style: TextStyle(
                        color: Color.fromARGB(255, 34, 4, 4),
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
                MaterialButton(
                  child: const Text(
                    'log in',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return login();
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

Future<User?> registerUsingEmailPassword({
  required String email,
  required String password,
}) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  try {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    user = userCredential.user;
    //await user!.updateProfile(displayName: name);
    // await user.reload();
    user = auth.currentUser;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
  } catch (e) {
    print(e);
  }
  return user;
}

void signUp(
    String email, String password, String username, String fullName) async {
  try {
    String nameOnly = email.substring(0, email.indexOf('@'));
    FirebaseAuth auth = FirebaseAuth.instance;

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('User_Info')
        .where('Username', isEqualTo: username)
        .get();

    final data = querySnapshot.docs.map((doc) => doc.data()).toList();

    if (data.isEmpty) {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      FirebaseFirestore.instance.collection("User_Info").doc(username).set({
        'Username': username,
        'FullName': fullName,
        'NameOnly': nameOnly,
        'Email': email,
        'Password': password,
      });
      Fluttertoast.showToast(
        msg: "User created",
      );
    } else {
      Fluttertoast.showToast(
        msg: "User Id is not available",
      );
    }
  } catch (e) {
    Fluttertoast.showToast(
      msg: "Use valid email and use strong password",
    );
  }
}
