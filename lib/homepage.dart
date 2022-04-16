import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:easy_me/login.dart';
import 'package:easy_me/workspace.dart';
import 'package:easy_me/help.dart';

class homepage extends StatelessWidget {
  const homepage({Key? key, Email}) : super(key: key);

  // This widget is the root
  // of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "HomePage",
        theme: ThemeData(primarySwatch: Colors.green),
        debugShowCheckedModeBanner: false,
        home: const Scaffold(
          body: MyStatefulWidget(),
        ));
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController workspacenameController = TextEditingController();
  TextEditingController workspaceIDController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final referenceDatabase = FirebaseDatabase.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Homepage"),
        actions: <Widget>[
          PopupMenuButton(
              itemBuilder: (context) => [
                    PopupMenuItem(
                      child: const Text("Help"),
                      onTap: () => Future(
                        () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const help()),
                        ),
                      ),
                      value: 1,
                    ),
                    PopupMenuItem(
                      child: const Text("Log Out"),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text("Log Out"),
                            content:
                                const Text("Are you sure you want to log out?"),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                                child: const Text("No"),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const login()));
                                  Navigator.of(ctx).pop();
                                },
                                child: const Text("Yes"),
                              ),
                            ],
                          ),
                        );
                      },
                      value: 2,
                    )
                  ]),
        ],
      ),
      body: ListView.separated(
        itemCount: 20,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            //contentPadding: const EdgeInsets.only(left:20,),
            title: Text("Workspace $index"),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const workspace()),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(height: 5);
        },
        //itemCount: images.length,
        shrinkWrap: true,
        padding: const EdgeInsets.all(5),
        scrollDirection: Axis.vertical,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                    child: Container(
                  height: 100.0,
                  width: 60.0,
                  child: Column(children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                    child: Container(
                                        height: 230.0,
                                        width: 60.0,
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: TextField(
                                                controller:
                                                    workspacenameController,
                                                decoration:
                                                    const InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelText: 'Name',
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: TextField(
                                                controller:
                                                    workspaceIDController,
                                                decoration:
                                                    const InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelText: 'ID',
                                                ),
                                              ),
                                            ),
                                            Container(
                                                height: 50,
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 0, 10, 0),
                                                child: ElevatedButton(
                                                  child: const Text(
                                                      'Create Your Workspace'),
                                                  onPressed: () {
                                                    //workspace creating button
                                                    if (workspaceIDController
                                                        .text.isEmpty) {
                                                      Fluttertoast.showToast(
                                                        msg:
                                                            "workspace_ID can't be empty",
                                                      );
                                                    } else if (workspacenameController
                                                        .text.isEmpty) {
                                                      Fluttertoast.showToast(
                                                        msg:
                                                            "Workspace name can't be empty",
                                                      );
                                                    } else {
                                                      retrieve_workspace_date();
                                                      create_workspace(
                                                          workspaceIDController
                                                              .text,
                                                          workspacenameController
                                                              .text,
                                                          context);
                                                    }
                                                  },
                                                )),
                                          ],
                                        )));
                              });
                          Fluttertoast.showToast(
                            msg: "Create workspace",
                          );
                        },
                        child: Container(
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              'Create',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        )),
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                    child: SizedBox(
                                        height: 150.0,
                                        width: 60.0,
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: TextField(
                                                obscureText: true,
                                                controller:
                                                    workspaceIDController,
                                                decoration:
                                                    const InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelText:
                                                      'Give a Valid Workspace ID',
                                                ),
                                              ),
                                            ),
                                            Container(
                                                height: 50,
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 0, 10, 0),
                                                child: ElevatedButton(
                                                  child: const Text(
                                                      'Join A New Workspace'),
                                                  onPressed: () {
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            "Successfully Joined");
                                                    Navigator.of(context).pop();
                                                  },
                                                )),
                                          ],
                                        )));
                              });
                          Fluttertoast.showToast(
                            msg: "Join workspace",
                          );
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'Join',
                            style: TextStyle(fontSize: 20),
                          ),
                        ))
                  ]),
                ));
              });
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

void create_workspace(
    String workspace_ID, String workspace_name, BuildContext context) async {
  try {
    final referenceDatabase = FirebaseDatabase.instance;
    final ref = referenceDatabase.ref().child('Workspace');
    if (workspace_ID.isNotEmpty && workspace_name.isNotEmpty) {
      ref.child(workspace_ID).set({
        'Workspace_ID': workspace_ID,
        'workspace_name': workspace_name,
      });
    }
    Fluttertoast.showToast(
      msg: "New workspace created Successfully",
    );
    Navigator.of(context).pop();
  } catch (e) {
    Fluttertoast.showToast(
      msg: "Please fill up the void",
    );
  }
}

Future<void> retrieve_workspace_date() async {
  final db = FirebaseDatabase.instance.ref().child("Workspace");
  // Get the data once
  DatabaseEvent event = await db.once();

// Print the data of the snapshot
  print(event.snapshot.value); // { "name": "John" }
  final db1 = FirebaseDatabase.instance.ref().child("User_Info");
  // Get the data once
  DatabaseEvent event1 = await db1.once();

// Print the data of the snapshot

  print(event1.snapshot.value); // { "name": "John" }
}
