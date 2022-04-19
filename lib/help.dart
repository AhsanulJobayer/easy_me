import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class help extends StatelessWidget {
  const help({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Help';

    return MaterialApp(
      title: appTitle,
      theme: ThemeData(primarySwatch: Colors.green),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(appTitle),
        ),
        body: const ReadTextFile(),
      ),
    );
  }
}

class ReadTextFile extends StatefulWidget {
  const ReadTextFile({Key? key}) : super(key: key);

  @override
  _ReadTextFileState createState() => _ReadTextFileState();
}

class _ReadTextFileState extends State<ReadTextFile> {
  String dataFromFile = "";

  Future<void> readText() async {
    final String response =
        await rootBundle.loadString('assets/textFile/help.txt');
    setState(() {
      dataFromFile = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    readText();
    return Text(dataFromFile);
  }
}
