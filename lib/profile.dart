import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
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
                TextEditingController changefullname = TextEditingController();
                return Container(
                  padding: const EdgeInsets.fromLTRB(0, 5, 5, 5),
                  child: Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.fromLTRB(0, 40, 90, 5),
                          child: Column(
                            children: [
                              Text(
                                "Username : " + data["Username"],
                                style: TextStyle(fontSize: 30),
                              ),
                            ],
                          )),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(15, 5, 5, 5),
                          child: Row(
                            children: [
                              Container(
                                child: Text(
                                  "Name : " + data["FullName"],
                                  style: TextStyle(fontSize: 30),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.fromLTRB(70, 0, 0, 0),
                                child: ElevatedButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Dialog(
                                                child: Container(
                                              height: 150,
                                              child: Column(children: [
                                                Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: TextField(
                                                      controller:
                                                          changefullname,
                                                      decoration:
                                                          const InputDecoration(
                                                        border:
                                                            OutlineInputBorder(),
                                                        labelText: 'Name',
                                                      ),
                                                    )),
                                                Container(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      FirebaseFirestore.instance
                                                          .collection(
                                                              'User_Info')
                                                          .doc(Username)
                                                          .update({
                                                        "FullName":
                                                            changefullname.text
                                                      });
                                                    },
                                                    child: Text("Save Changes"),
                                                  ),
                                                ),
                                              ]),
                                            ));
                                          });
                                    },
                                    child: Text("Edit")),
                              )
                            ],
                          )),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 10, 20),
                        child: Text(
                          "Email : " + data["Email"],
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        child: ElevatedButton(
                            onPressed: () {}, child: Text("Change Password")),
                      )
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
