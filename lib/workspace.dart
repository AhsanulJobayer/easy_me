import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Workspace.dart';
import 'help.dart';
//import 'login.dart';

class workspace extends StatelessWidget {
  const workspace({Key? key}) : super(key: key);

  // This widget is the root
  // of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Workspace",
        theme: ThemeData(primarySwatch: Colors.green),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
          title: const Text("Workspace"),
    ),
    ),
    );
  }
}