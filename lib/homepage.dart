import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() => runApp(const homepage());

class homepage extends StatelessWidget {
  const homepage({Key? key}) : super(key: key);

  // This widget is the root
  // of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "HomePage",
        theme: ThemeData(primarySwatch: Colors.green),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: const MyStatefulWidget(),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Homepage")),
      body: ListView.separated(
        itemCount: 20,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            //contentPadding: const EdgeInsets.only(left:20,),
            title: Text("Workspace $index"),
            onTap: () {
              Fluttertoast.showToast(msg: "Workspace $index");
            },
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
                                              padding: EdgeInsets.all(10.0),
                                              child: TextField(
                                                obscureText: true,
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
                                              padding: EdgeInsets.all(10.0),
                                              child: TextField(
                                                obscureText: true,
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
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            "New Workspace Created");
                                                    Navigator.of(context).pop();
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
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: const Text(
                              'Create',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        )),
                    GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                    child: Container(
                                        height: 150.0,
                                        width: 60.0,
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.all(10.0),
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
                                                            "Succesfully Joined");
                                                    Navigator.of(context).pop();
                                                  },
                                                )),
                                          ],
                                        )));
                              });
                          Fluttertoast.showToast(
                            msg: "Join worskapce",
                          );
                        },
                        child: Container(
                            child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'Join',
                            style: TextStyle(fontSize: 20),
                          ),
                        )))
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
