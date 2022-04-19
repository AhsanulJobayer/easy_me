import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:fluttertoast/fluttertoast.dart';

class profile extends StatefulWidget {
  final String Username;
  profile({Key? key, required this.Username}) : super(key: key);

  // This widget is the root of your application.

  @override
  Myprofilestate createState() => Myprofilestate(Username);
}

class Myprofilestate extends State<profile> {
  final String Username;
  Myprofilestate(this.Username);

  @override
  Widget build(BuildContext context) {
    print("Hey this is your profile :  " + Username);
    TextEditingController fullnameedit = TextEditingController();
    TextEditingController edit_password = TextEditingController();
    TextEditingController edit_confirmpassword = TextEditingController();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 41, 40, 40),

      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        backgroundColor: Colors.black,

        title: Text("View Profile"),
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('User_Info')
            .where('Username', isEqualTo: Username)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            print("no data here , sorry");
            return const Text("No user to work with");
          } else {
            print("user retirieved :: ");
            //print(snapshot.data.toString());

            return ListView(
              shrinkWrap: true,
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                print(data["FullName"]);
                print(data["Email"]);

                return Container(
                  padding: const EdgeInsets.only(top: 80),
                  child: Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Column(
                            children: [
                              Container(
                                  alignment: Alignment.topLeft,
                                  color: Colors.white,
                                  padding: const EdgeInsets.all(2.0),
                                  margin:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                  child: Container(
                                    alignment: Alignment.topLeft,
                                    color: Colors.black,
                                    child: Text(
                                      "Username : " + data["Username"],
                                      style: const TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                    padding: const EdgeInsets.all(10.0),
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 00),
                                  )),
                            ],
                          )),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Column(
                            children: [
                              Container(
                                  alignment: Alignment.topLeft,
                                  color: Colors.white,
                                  padding: const EdgeInsets.all(2.0),
                                  margin:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                  child: Container(
                                      height: 40,
                                      alignment: Alignment.topLeft,
                                      color: Colors.black,
                                      padding: const EdgeInsets.all(10.0),
                                      margin:
                                          const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Name : " + data["FullName"],
                                            style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.white),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return Dialog(
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.all(10),
                                                        height: 128,
                                                        child:
                                                            Column(children: [
                                                          TextField(
                                                            controller:
                                                                fullnameedit,
                                                            decoration:
                                                                const InputDecoration(
                                                              border:
                                                                  OutlineInputBorder(),
                                                              labelText: 'Name',
                                                            ),
                                                          ),
                                                          ElevatedButton(
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              primary:
                                                                  Colors.black,
                                                            ),
                                                            onPressed: () {
                                                              if (fullnameedit
                                                                  .text
                                                                  .isEmpty) {
                                                                Fluttertoast
                                                                    .showToast(
                                                                  msg:
                                                                      "Name can't be empty",
                                                                );
                                                              } else {
                                                                FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'User_Info')
                                                                    .doc(
                                                                        Username)
                                                                    .update({
                                                                  "FullName":
                                                                      fullnameedit
                                                                          .text,
                                                                });
                                                                Navigator.pop(
                                                                    context);
                                                              }
                                                            },
                                                            child: Text(
                                                                "Save changes"),
                                                          )
                                                        ]),
                                                      ),
                                                    );
                                                  });
                                            },
                                            icon: const Icon(Icons.edit),
                                            color: Colors.white,
                                            iconSize: 20,
                                            padding:
                                                EdgeInsets.only(bottom: 10),
                                          )
                                        ],
                                      ))),
                            ],
                          )),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Column(
                            children: [
                              Container(
                                  alignment: Alignment.topLeft,
                                  color: Colors.white,
                                  padding: const EdgeInsets.all(2.0),
                                  margin:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                  child: Container(
                                    alignment: Alignment.topLeft,
                                    color: Colors.black,
                                    child: Text(
                                      "Email : " + data["Email"],
                                      style: const TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                    padding: const EdgeInsets.all(10.0),
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 00),
                                  )),
                            ],
                          )),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Column(
                            children: [
                              Container(
                                child: ElevatedButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Dialog(
                                            child: Container(
                                              padding: EdgeInsets.all(10),
                                              height: 208,
                                              child: Column(children: [
                                                TextField(
                                                  controller: edit_password,
                                                  decoration:
                                                      const InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    labelText: 'New Password',
                                                  ),
                                                ),
                                                TextField(
                                                  controller:
                                                      edit_confirmpassword,
                                                  decoration:
                                                      const InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    labelText:
                                                        'Cofirm Password',
                                                  ),
                                                ),
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    primary: Colors.black,
                                                  ),
                                                  onPressed: () {
                                                    if (edit_password
                                                        .text.isEmpty) {
                                                      Fluttertoast.showToast(
                                                        msg:
                                                            "password can't be empty",
                                                      );
                                                    } else if (edit_confirmpassword
                                                        .text.isEmpty) {
                                                      Fluttertoast.showToast(
                                                        msg:
                                                            "Confirm password can't be empty",
                                                      );
                                                    }
                                                    if (edit_password.text !=
                                                        edit_confirmpassword
                                                            .text) {
                                                      Fluttertoast.showToast(
                                                        msg:
                                                            "Password doesn't match",
                                                      );
                                                    } else {
                                                      changePassword(
                                                          data['Email']);
                                                      Navigator.pop(context);
                                                    }
                                                  },
                                                  child: Text("Confirm"),
                                                )
                                              ]),
                                            ),
                                          );
                                        });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.black,
                                  ),
                                  child: Text(
                                    "Change Passowrd",
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                );
              }).toList(),
            );
          }
        },
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

changePassword(String email) {
  print("fuck");
}
