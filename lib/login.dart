import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_me/homepage.dart';
import 'package:easy_me/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  static const String _title = 'EASY.ME';

  @override
  MyStatefulWidget createState() => MyStatefulWidget();
}

class MyStatefulWidget extends State<login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override // backgroundColor: Color.fromARGB(255, 41, 40, 40),
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.black,
        // backgroundColor: Color.fromARGB(255, 41, 40, 40),
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          backgroundColor: Colors.black,

          title: Text("LOGIN"),
        ),
        body: Center(
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
                      // print(emailController.text);
                      // print(passwordController.text);
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
        )));
  }
}

void signin(String email, String password, BuildContext context) async {
  try {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signInWithEmailAndPassword(email: email, password: password);
    Fluttertoast.showToast(
      msg: "Successfully logged in",
    );

    String nameOnly = email.substring(0, email.indexOf('@'));
    final db1 =
        FirebaseDatabase.instance.ref().child("User_Info").child(nameOnly);
    // Get the data once
    DatabaseEvent event1 = await db1.once();

    final data = event1.snapshot.value;

    //print(data.toString());

    DatabaseEvent usernameEvent = await db1.child("Username").once();
    String username = usernameEvent.snapshot.value.toString();
    print("UserName: " + username);

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => homepage(Username: username)));
  } catch (e) {
    Fluttertoast.showToast(
      msg: "Invalid email or password",
    );
  }
}

// Future<String> retrieve_user_date(String email) async {
//   // final db1 = FirebaseDatabase.instance
//   //     .ref()
//   //     .child("User_Info")
//   //     .set({"Email": email}).asStream();
//   // Get the data once
//
//   // DatabaseEvent event1 = await db1.once();
//
// // Print the data of the snapshot
// //   db1.toString();
// //   print(db1);
//   // event1.snapshot.value;
//   // print(event1.snapshot.value); // { "name": "John" }
//
//   String nameOnly = email.substring(0,email.indexOf('@'));
//   final db1 = FirebaseDatabase.instance.ref().child("User_Info").child(nameOnly);
//   // Get the data once
//   DatabaseEvent event1 = await db1.once();
//
//   final data  = event1.snapshot.value;
//
//   //print(data.toString());
//
//   DatabaseEvent usernameEvent = await db1.child("Username").once();
//   String username = usernameEvent.snapshot.value.toString();
//   print("UserName: " + username);
//
//   // if(event1.snapshot.value != null && ) {
//   //
//   // }
//
// // Print the data of the snapshot
//   print("retrieved data: ");
//   print(event1.snapshot.value); // { "name": "John" }
//
//   return username;
// }
