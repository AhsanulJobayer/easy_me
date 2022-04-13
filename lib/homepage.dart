import 'package:easy_me/login.dart';
import 'package:easy_me/workspace.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:easy_me/help.dart';
void main() => runApp(const homepage());

class homepage extends StatelessWidget {
  const homepage({Key? key}) : super(key: key);

  // This widget is the root
  // of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "HomePage",
        theme: ThemeData(
            primarySwatch: Colors.green
        ),
        debugShowCheckedModeBanner: false,
        home: const ListViewBuilder()
    );
  }
}
class ListViewBuilder extends StatelessWidget {
  const ListViewBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:const Text("Homepage"),
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
          itemBuilder: (BuildContext context,int index){
            return ListTile(
                //contentPadding: const EdgeInsets.only(left:20,),
                title:Text("Workspace $index"),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => workspace()),
                ),
            );
          }, separatorBuilder: (BuildContext context, int index) {
        return const Divider(height: 5);
      },
        //itemCount: images.length,
        shrinkWrap: true,
        padding: const EdgeInsets.all(5),
        scrollDirection: Axis.vertical,
      ),
    );
  }
}