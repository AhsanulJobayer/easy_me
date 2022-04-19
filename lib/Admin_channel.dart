import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';

import 'package:easy_me/workspace.dart';

class Admin_channel extends StatefulWidget {
  final String workspace_ID, username, admin;

  Admin_channel(
      {Key? key,
      required this.workspace_ID,
      required this.username,
      required this.admin})
      : super(key: key);

  @override
  MyStatefulWidget createState() =>
      MyStatefulWidget(username, workspace_ID, admin);
}

// This widget is the root
// of your application.

class MyStatefulWidget extends State<Admin_channel> {
  final String Username, workspace_ID, admin;
  MyStatefulWidget(this.Username, this.workspace_ID, this.admin);

  TextEditingController teamname = TextEditingController();

  //final referenceDatabase = FirebaseDatabase.instance;

  // final db = FirebaseDatabase.instance.ref().child("Workspace").orderByChild("workspace_name");
  // List<Model> list = [];

  // final db = FirebaseDatabase.instance.ref().child("Workspace").orderByChild("workspace_name");
  // List<Model> list = []; main

  @override
  Widget build(BuildContext context) {
    print("Hey this is your Team page  :  " + admin);

    return Scaffold(
        appBar: AppBar(
          title: const Text("Team"),
          backgroundColor: Colors.black,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Team_name')
              .where('Workspace_ID', isEqualTo: workspace_ID)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              print("no data");
              return const Text("No team to work with");
            } else {
              print("Team retirieved :: ");
              print(snapshot.data.toString());

              return ListView(
                shrinkWrap: true,
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return Card(
                    child: ListTile(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 24),
                      title: Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(data['Team_Name'])),
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => workspace(
                                    workspace_ID: workspace_ID,
                                    username: Username,
                                    Team_name: data["Team_Name"],
                                  ))),
                    ),
                  );
                }).toList(),
              );
            }
          },
        ),
        floatingActionButton: admin == "YES"
            ? FloatingActionButton(
                onPressed: () {
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
                                      padding: const EdgeInsets.all(10.0),
                                      child: TextField(
                                        controller: teamname,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Team Name',
                                        ),
                                      ),
                                    ),
                                    Container(
                                        height: 50,
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 0, 10, 0),
                                        child: ElevatedButton(
                                          child: const Text('Create Your Team'),
                                          onPressed: () {
                                            //workspace creating button
                                            if (teamname.text.isEmpty) {
                                              Fluttertoast.showToast(
                                                msg: "Team Name can't be empty",
                                              );
                                            } else {
                                              create_workspace(workspace_ID,
                                                  teamname.text, context);
                                            }
                                          },
                                        )),
                                  ],
                                )));
                      });
                },
                tooltip: 'Increment',
                child: const Icon(Icons.add),
              )
            : Container());
  }
}

void create_workspace(
    String workspaceID, String team_name, BuildContext context) async {
  try {
    String unique_team = workspaceID + team_name;
    FirebaseFirestore.instance.collection("Team_name").doc(unique_team).set({
      'Workspace_ID': workspaceID,
      'Team_Name': team_name,
    });
    Fluttertoast.showToast(
      msg: "New channel created successfully",
    );
    Navigator.of(context).pop();
  } catch (e) {
    Fluttertoast.showToast(
      msg: "Please fill up the void",
    );
  }
}
