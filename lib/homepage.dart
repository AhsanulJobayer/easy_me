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
        theme: ThemeData(
            primarySwatch: Colors.green
        ),
        debugShowCheckedModeBanner: false,
        home: ListViewBuilder()
    );
  }
}
class ListViewBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:const Text("Homepage")
      ),
      body: ListView.separated(
          itemCount: 20,
          itemBuilder: (BuildContext context,int index){
            return ListTile(
                //contentPadding: const EdgeInsets.only(left:20,),
                title:Text("Workspace $index"),
                onTap: () {
                  Fluttertoast.showToast(msg: "Workspace $index");

                },
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