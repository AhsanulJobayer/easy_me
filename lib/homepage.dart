import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_me/Model.dart';
import 'package:easy_me/profile.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:easy_me/login.dart';
import 'package:easy_me/workspace.dart';
import 'package:easy_me/help.dart';
import 'package:easy_me/Model.dart';

class homepage extends StatefulWidget {
  final String Username;

  homepage({Key? key, required this.Username}) : super(key: key);

  @override
  MyStatefulWidget createState() => MyStatefulWidget(Username);
}

// This widget is the root
// of your application.

class MyStatefulWidget extends State<homepage> {
  final String Username;
  MyStatefulWidget(this.Username);

  TextEditingController workspacenameController = TextEditingController();
  TextEditingController workspaceIDController = TextEditingController();
  TextEditingController workspaceJoinIDController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final referenceDatabase = FirebaseDatabase.instance;

  // final db = FirebaseDatabase.instance.ref().child("Workspace").orderByChild("workspace_name");
  // List<Model> list = [];

  // final db = FirebaseDatabase.instance.ref().child("Workspace").orderByChild("workspace_name");
  // List<Model> list = []; main

  @override
  Widget build(BuildContext context) {
    print("Hey this is your Home page  :  " + Username);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Homepage"),
        actions: <Widget>[
          PopupMenuButton(
              itemBuilder: (context) => [
                    PopupMenuItem(
                      child: const Text("Profile"),
                      onTap: () => Future(
                        () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (_) => profile(Username: Username)),
                        ),
                      ),
                      value: 1,
                    ),
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
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Workspace')
            .where('Username', isEqualTo: Username)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            print("no data");
            return const Text("No workspace to work with");
          } else {
            print("Worksapces retirieved :: ");
            print(snapshot.data.toString());

            return ListView(
              shrinkWrap: true,
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return Card(
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                    title: Padding(
                        padding: EdgeInsets.all(5),
                        child: Text(data['workspace_name'])),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => workspace(
                                workspace_ID: data['Workspace_ID'],
                                username: Username))),
                  ),
                );
              }).toList(),
            );
          }
        },
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
                                                          Username,
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
                                                    workspaceJoinIDController,
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
                                                    if (workspaceJoinIDController
                                                        .text.isEmpty) {
                                                      Fluttertoast.showToast(
                                                        msg:
                                                            "workspace_ID can't be empty",
                                                      );
                                                    } else {
                                                      retrieve_workspace_date();
                                                      join_workspace(
                                                          workspaceJoinIDController
                                                              .text,
                                                          Username,
                                                          context);
                                                    }
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

void create_workspace(String workspaceID, String workspaceName, String Username,
    BuildContext context) async {
  try {
    FirebaseFirestore.instance.collection("Workspace").doc(workspaceID).set({
      'Workspace_ID': workspaceID,
      'workspace_name': workspaceName,
      'Username': Username,
    });
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

void join_workspace(
    String workspaceID, String Username, BuildContext context) async {
  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Workspace')
        .where('Workspace_ID', isEqualTo: workspaceID)
        .get();
    List data = [];
    data = querySnapshot.docs.map((doc) => doc.data()).toList();
    //List list = data.entries.map((e) => data(e.key, e.value)).toList();
    print("JOining a workspace _shit" + data.toString());
    String unique_name = workspaceID + Username;

    FirebaseFirestore.instance.collection("Workspace").doc(unique_name).set({
      'Workspace_ID': workspaceID,
      'workspace_name': "hagu",
      'Username': Username,
    });
    Fluttertoast.showToast(
      msg: "New workspace joined Successfully",
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
  DatabaseEvent event = await db.once();

  print(event.snapshot.value); // { "name": "John" }
}
