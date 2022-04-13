// import 'dart:ffi';
//
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//
// import 'package:easy_me/login.dart';
// import 'package:easy_me/workspace.dart';
//
// import 'package:easy_me/help.dart';
// void main() => runApp(const homepage());
//
// class homepage extends StatelessWidget {
//   const homepage({Key? key}) : super(key: key);
//
//   // This widget is the root
//   // of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: "HomePage",
//         theme: ThemeData(primarySwatch: Colors.green),
//         debugShowCheckedModeBanner: false,
//         home: const Scaffold(
//           body: MyStatefulWidget(),
//         ));
//   }
// }
//
// class MyStatefulWidget extends StatefulWidget {
//   const MyStatefulWidget({Key? key}) : super(key: key);
//
//   @override
//   State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
// }
//
// class _MyStatefulWidgetState extends State<MyStatefulWidget> {
//   TextEditingController workspacenameController = TextEditingController();
//   TextEditingController workspaceIDController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Homepage")),
//       body: ListView.separated(
//         itemCount: 20,
//         itemBuilder: (BuildContext context, int index) {
//           return ListTile(
//             //contentPadding: const EdgeInsets.only(left:20,),
//             title: Text("Workspace $index"),
//             onTap: () {
//               Fluttertoast.showToast(msg: "Workspace $index");
//             },
//           );
//         },
//         separatorBuilder: (BuildContext context, int index) {
//           return const Divider(height: 5);
//         },
//
//         home: const ListViewBuilder()
//     ),
//     );
//   }
// }
// class ListViewBuilder extends StatelessWidget {
//   const ListViewBuilder({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           title:const Text("Homepage"),
//           actions: <Widget>[
//             PopupMenuButton(
//                 itemBuilder:(context) => [
//                   PopupMenuItem(
//                     child: const Text("Help"),
//                     onTap: () => Future(
//                           () => Navigator.of(context).push(
//                         MaterialPageRoute(builder: (_) => const help()),
//                       ),
//                     ),
//                     value: 1,
//                   ),
//                   PopupMenuItem(
//                     child: const Text("Log Out"),
//                     onTap: () {
//                       showDialog(
//                         context: context,
//                         builder: (ctx) => AlertDialog(
//                           title: const Text("Log Out"),
//                           content: const Text("Are you sure you want to log out?"),
//                           actions: <Widget>[
//                             TextButton(
//                               onPressed: () {
//                                 Navigator.of(ctx).pop();
//                               },
//                               child: const Text("No"),
//                             ),
//                             TextButton(
//                               onPressed: () {
//                                 Navigator.pushReplacement(
//                                     context, MaterialPageRoute(builder: (context) => login()));
//                                 Navigator.of(ctx).pop();
//                               },
//                               child: const Text("Yes"),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                     value: 2,
//                   )
//                 ]
//             ),
//           ],
//       ),
//       body: ListView.separated(
//           itemCount: 20,
//           itemBuilder: (BuildContext context,int index){
//             return ListTile(
//                 //contentPadding: const EdgeInsets.only(left:20,),
//                 title:Text("Workspace $index"),
//                 onTap: () => Navigator.of(context).push(
//                   MaterialPageRoute(builder: (_) => workspace()),
//                 ),
//             );
//           }, separatorBuilder: (BuildContext context, int index) {
//         return const Divider(height: 5);
//       },
//         //itemCount: images.length,
//         shrinkWrap: true,
//         padding: const EdgeInsets.all(5),
//         scrollDirection: Axis.vertical,
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           showDialog(
//               context: context,
//               builder: (BuildContext context) {
//                 return Dialog(
//                     child: Container(
//                   height: 100.0,
//                   width: 60.0,
//                   child: Column(children: [
//                     GestureDetector(
//                         onTap: () {
//                           showDialog(
//                               context: context,
//                               builder: (BuildContext context) {
//                                 return Dialog(
//                                     child: Container(
//                                         height: 230.0,
//                                         width: 60.0,
//                                         child: Column(
//                                           children: <Widget>[
//                                             Container(
//                                               padding: EdgeInsets.all(10.0),
//                                               child: TextField(
//                                                 obscureText: true,
//                                                 controller:
//                                                     workspacenameController,
//                                                 decoration:
//                                                     const InputDecoration(
//                                                   border: OutlineInputBorder(),
//                                                   labelText: 'Name',
//                                                 ),
//                                               ),
//                                             ),
//                                             Container(
//                                               padding: EdgeInsets.all(10.0),
//                                               child: TextField(
//                                                 obscureText: true,
//                                                 controller:
//                                                     workspaceIDController,
//                                                 decoration:
//                                                     const InputDecoration(
//                                                   border: OutlineInputBorder(),
//                                                   labelText: 'ID',
//                                                 ),
//                                               ),
//                                             ),
//                                             Container(
//                                                 height: 50,
//                                                 padding:
//                                                     const EdgeInsets.fromLTRB(
//                                                         10, 0, 10, 0),
//                                                 child: ElevatedButton(
//                                                   child: const Text(
//                                                       'Create Your Workspace'),
//                                                   onPressed: () {
//                                                     Fluttertoast.showToast(
//                                                         msg:
//                                                             "New Workspace Created");
//                                                     Navigator.of(context).pop();
//                                                   },
//                                                 )),
//                                           ],
//                                         )));
//                               });
//                           Fluttertoast.showToast(
//                             msg: "Create workspace",
//                           );
//                         },
//                         child: Container(
//                           child: Padding(
//                             padding: EdgeInsets.all(10.0),
//                             child: const Text(
//                               'Create',
//                               style: TextStyle(fontSize: 20),
//                             ),
//                           ),
//                         )),
//                     GestureDetector(
//                         onTap: () {
//                           showDialog(
//                               context: context,
//                               builder: (BuildContext context) {
//                                 return Dialog(
//                                     child: Container(
//                                         height: 150.0,
//                                         width: 60.0,
//                                         child: Column(
//                                           children: <Widget>[
//                                             Container(
//                                               padding: EdgeInsets.all(10.0),
//                                               child: TextField(
//                                                 obscureText: true,
//                                                 controller:
//                                                     workspaceIDController,
//                                                 decoration:
//                                                     const InputDecoration(
//                                                   border: OutlineInputBorder(),
//                                                   labelText:
//                                                       'Give a Valid Workspace ID',
//                                                 ),
//                                               ),
//                                             ),
//                                             Container(
//                                                 height: 50,
//                                                 padding:
//                                                     const EdgeInsets.fromLTRB(
//                                                         10, 0, 10, 0),
//                                                 child: ElevatedButton(
//                                                   child: const Text(
//                                                       'Join A New Workspace'),
//                                                   onPressed: () {
//                                                     Fluttertoast.showToast(
//                                                         msg:
//                                                             "Succesfully Joined");
//                                                     Navigator.of(context).pop();
//                                                   },
//                                                 )),
//                                           ],
//                                         )));
//                               });
//                           Fluttertoast.showToast(
//                             msg: "Join worskapce",
//                           );
//                         },
//                         child: Container(
//                             child: Padding(
//                           padding: EdgeInsets.all(10.0),
//                           child: Text(
//                             'Join',
//                             style: TextStyle(fontSize: 20),
//                           ),
//                         )))
//                   ]),
//                 ));
//               });
//         },
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Workspace.dart';
import 'help.dart';
import 'login.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Homepage"),
          actions: <Widget>[
          PopupMenuButton(
              itemBuilder:(context) => [
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
                        content: const Text("Are you sure you want to log out?"),
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
                                  context, MaterialPageRoute(builder: (context) => login()));
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
              ]
          ),
        ],

      ),
      body: ListView.separated(
        itemCount: 20,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            //contentPadding: const EdgeInsets.only(left:20,),
            title: Text("Workspace $index"),
          onTap: () => Navigator.of(context).push(
                   MaterialPageRoute(builder: (_) => workspace()),
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
                                        child: Container(
                                            height: 150.0,
                                            width: 60.0,
                                            child: Column(
                                              children: <Widget>[
                                                Container(
                                                  padding: const EdgeInsets.all(10.0),
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
                                                      child: const Text('Join A New Workspace'),
                                                      onPressed: () {
                                                        Fluttertoast.showToast(
                                                            msg: "Succesfully Joined");
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